<template>
  <div class="topic-detail">
    <main class="main-content">
      <div class="container">
        <div v-if="loading" class="loading-container">
          <el-icon class="is-loading"><Loading /></el-icon>
          <p>加载中...</p>
        </div>

        <div v-else-if="!topic" class="empty-container">
          <p>话题不存在</p>
        </div>

        <div v-else class="topic-wrapper">
          <div class="topic-main">
            <div class="topic-header">
              <h1 class="topic-title">{{ topic.title }}</h1>
              <div class="topic-meta">
                <div class="author-info">
                  <img :src="getAvatarUrl(topic.uAvatar) || '/placeholder-avatar.jpg'" :alt="topic.uName" class="author-avatar" />
                  <div class="author-details">
                    <span class="author-name">{{ topic.uName || '未知用户' }}</span>
                    <span class="author-occupation">{{ topic.uOccupation || '' }}</span>
                  </div>
                </div>
                <div class="topic-time">{{ dayjs(topic.createTime).format('YYYY-MM-DD HH:mm:ss') }}</div>
              </div>
            </div>

            <div class="topic-content">
              <div class="content-text" v-html="topic.content"></div>
            </div>

            <div class="topic-stats">
              <div class="stat-item">
                <el-icon><View /></el-icon>
                <span>{{ topic.pageViews || 0 }}</span>
              </div>
              <div class="stat-item" @click="handleLike">
                <el-icon><Pointer /></el-icon>
                <span>{{ topic.likes || 0 }}</span>
              </div>
            </div>

            <div class="comments-section">
              <div class="comments-header">
                <h3>评论 ({{ total }})</h3>
              </div>

              <div v-if="isLoggedIn" class="comment-form">
                <el-input
                  v-model="commentForm.content"
                  type="textarea"
                  :rows="3"
                  placeholder="写下你的评论..."
                  maxlength="500"
                  show-word-limit
                />
                <el-button type="primary" @click="handleSubmitComment" :loading="commentLoading">
                  发表评论
                </el-button>
              </div>
              <div v-else class="login-tip">
                <router-link to="/login">登录后参与评论</router-link>
              </div>

              <div class="comments-list">
                <div v-if="commentsLoading" class="comments-loading">
                  <el-icon class="is-loading"><Loading /></el-icon>
                </div>
                <div v-else-if="rootComments.length === 0" class="no-comments">
                  暂无评论，快来抢沙发吧~
                </div>
                <div v-else>
                  <CommentItem
                    v-for="comment in rootComments"
                    :key="comment.id"
                    :comment="comment"
                    :all-comments="comments"
                    :replying-to="replyingTo"
                    :reply-loading="replyLoading"
                    :reply-form="replyForm"
                    :topic-id="topicId"
                    @show-reply="showReplyForm"
                    @cancel-reply="cancelReply"
                    @submit-reply="handleSubmitReply"
                    @refresh-comments="loadComments"
                  />
                </div>
                
                <!-- 显示更多按钮 -->
                <div class="load-more">
                  <span v-if="rootComments.length < total" 
                    class="load-more-btn" 
                    @click="loadMoreComments"
                    :class="{ 'loading': commentsLoading }"
                  >
                    {{ commentsLoading ? '加载中...' : '显示更多' }}
                  </span>
                  <span v-else class="no-more">没有更多了</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Loading, View, Pointer } from '@element-plus/icons-vue'
import { getTopicDetail, getCommentsByPage, addComment, updateTopicPageViews, updateTopicLikes, getUidTid, cancelTopicLikes } from '../../api/topics'
import { getAvatarUrl } from '../../utils/helpers'
import CommentItem from './CommentItem.vue'
import dayjs from 'dayjs'

const route = useRoute()
const topicId = computed(() => route.params.id as string)

const loading = ref(false)
const topic = ref<any>(null)
const comments = ref<any[]>([])
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(2)
const commentsLoading = ref(false)
const commentLoading = ref(false)
const replyLoading = ref(false)
const replyingTo = ref<number | null>(null)
const commentForm = ref({
  content: ''
})
const replyForm = ref({
  content: ''
})

const isLoggedIn = computed(() => {
  return !!localStorage.getItem('token')
})

// 计算根评论（parentId为0或null）
const rootComments = computed(() => {
  return comments.value.filter(c => !c.parentId || c.parentId === 0)
})

// 显示回复表单
const showReplyForm = (commentId: number) => {
  if (!isLoggedIn.value) {
    ElMessage.warning('请先登录')
    return
  }
  replyingTo.value = commentId
  replyForm.value.content = ''
}

// 加载更多评论
const loadMoreComments = () => {
  if (commentsLoading.value) return
  currentPage.value++
  loadComments()
}

// 取消回复
const cancelReply = () => {
  replyingTo.value = null
  replyForm.value.content = ''
}

// 提交回复
const handleSubmitReply = async (parentId: number) => {
  if (!replyForm.value.content.trim()) {
    ElMessage.warning('请输入回复内容')
    return
  }

  try {
    replyLoading.value = true
    const userInfo = localStorage.getItem('userInfo')
    if (!userInfo) {
      ElMessage.error('请先登录')
      return
    }

    const parsedUserInfo = JSON.parse(userInfo)
    const params = {
      topicId: topicId.value,
      content: replyForm.value.content,
      uId: parsedUserInfo.id,
      parentId: parentId
    }

    const response = await addComment(params)
    
    if (response.sign === '1') {
      ElMessage.success('回复发表成功')
      replyForm.value.content = ''
      replyingTo.value = null
      // 重置页码并重新加载评论
      currentPage.value = 1
      loadComments()
    } else {
      ElMessage.error(response.msg || '回复发表失败')
    }
  } catch (error) {
    console.error('发表回复失败:', error)
    ElMessage.error('发表回复失败，请稍后重试')
  } finally {
    replyLoading.value = false
  }
}

const loadTopicDetail = async () => {
  try {
    loading.value = true

    console.log('topicId.value:', topicId.value)
    const response = await getTopicDetail({ id: topicId.value })
    console.log('getTopicDetail response:', response)

    if (response.sign === '1' && response.data) {
      topic.value = response.data[0]
      // 更新浏览量
      updateTopicPageViews({ id: topicId.value })
      topic.value.pageViews = (topic.value.pageViews || 0) + 1
    } else {
      ElMessage.error(response.msg || '获取话题详情失败')
    }
  } catch (error) {
    console.error('获取话题详情失败:', error)
    ElMessage.error('获取话题详情失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

const loadComments = async () => {
  try {
    commentsLoading.value = true
    const params = {
      topicId: topicId.value,
      pageNumber: currentPage.value,
      pageSize: pageSize.value
    }
    console.log('getCommentsByPage params:', params)
    const response = await getCommentsByPage(params)
    console.log('getCommentsByPage response:', response)
    
    if (response.sign === '1' && response.data) {
      // 加载更多时追加数据，否则替换数据
      if (currentPage.value > 1) {
        comments.value = [...comments.value, ...(response.data.lists || [])]
      } else {
        comments.value = response.data.lists || []
      }
      total.value = response.data.total || 0
    }
  } catch (error) {
    console.error('获取评论失败:', error)
  } finally {
    commentsLoading.value = false
  }
}

const handleSubmitComment = async () => {
  if (!commentForm.value.content.trim()) {
    ElMessage.warning('请输入评论内容')
    return
  }

  try {
    commentLoading.value = true
    const userInfo = localStorage.getItem('userInfo')
    if (!userInfo) {
      ElMessage.error('请先登录')
      return
    }

    const parsedUserInfo = JSON.parse(userInfo)
    const params = {
      topicId: topicId.value,
      content: commentForm.value.content,
      uId: parsedUserInfo.id
    }

    const response = await addComment(params)
    
    if (response.sign === '1') {
      ElMessage.success('评论发表成功')
      commentForm.value.content = ''
      // 重置页码并重新加载评论
      currentPage.value = 1
      loadComments()
    } else {
      ElMessage.error(response.msg || '评论发表失败')
    }
  } catch (error) {
    console.error('发表评论失败:', error)
    ElMessage.error('发表评论失败，请稍后重试')
  } finally {
    commentLoading.value = false
  }
}

const handleLike = async () => {
  try {
    const userInfo = localStorage.getItem('userInfo')
    if (!userInfo) {
      ElMessage.warning('请先登录')
      return
    }

    const parsedUserInfo = JSON.parse(userInfo)
    const params = {
      uId: parsedUserInfo.id,
      tId: topicId.value
    }
    console.log("params:",params)

    // 先查询用户是否已点赞
    const checkResponse = await getUidTid(params)
    console.log("checkResponse:",checkResponse)
    
    if (checkResponse.sign === '1' && checkResponse.data) {
      const count = checkResponse.data[0].count || 0
      console.log("count:",count);
      if (count > 0) {
        // 取消点赞
        const cancelResponse = await cancelTopicLikes(params)
        
        if (cancelResponse.sign === '1') {
          ElMessage.success('取消点赞成功')
          // 更新本地点赞数
          if (topic.value) {
            topic.value.likes = Math.max(0, (topic.value.likes || 0) - 1)
          }
        } else {
          ElMessage.error(cancelResponse.msg || '取消点赞失败')
        }
      } else {
        // 添加点赞
        const likeResponse = await updateTopicLikes(params)
        
        if (likeResponse.sign === '1') {
          ElMessage.success('点赞成功')
          // 更新本地点赞数
          if (topic.value) {
            topic.value.likes = (topic.value.likes || 0) + 1
          }
        } else {
          ElMessage.error(likeResponse.msg || '点赞失败')
        }
      }
    } else {
      ElMessage.error('查询点赞状态失败')
    }
  } catch (error) {
    console.error('操作失败:', error)
    ElMessage.error('操作失败，请稍后重试')
  }
}

onMounted(() => {
  loadTopicDetail()
  loadComments()
})
</script>

<style lang="scss" scoped>
.topic-detail {
  min-height: 100vh;
  background-color: #f8f8f8;
}

.loading-container,
.empty-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100px 0;

  .is-loading {
    font-size: 48px;
    color: #ff6b6b;
    margin-bottom: 16px;
    animation: rotate 2s linear infinite;
  }

  p {
    font-size: 16px;
    color: #999;
  }
}

@keyframes rotate {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

.topic-wrapper {
  max-width: 1400px;
  margin: 0 auto;
  padding: 20px;
}

.topic-main {
  background: #fff;
  border-radius: 8px;
  padding: 30px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

.topic-header {
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #f0f0f0;

  .topic-title {
    font-size: 28px;
    font-weight: 600;
    color: #333;
    margin-bottom: 20px;
    line-height: 1.4;
  }

  .topic-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;

    .author-info {
      display: flex;
      align-items: center;
      gap: 12px;

      .author-avatar {
        width: 48px;
        height: 48px;
        border-radius: 50%;
        object-fit: cover;
      }

      .author-details {
        display: flex;
        flex-direction: column;
        gap: 4px;

        .author-name {
          font-size: 16px;
          font-weight: 500;
          color: #333;
        }

        .author-occupation {
          font-size: 14px;
          color: #999;
        }
      }
    }

    .topic-time {
      font-size: 14px;
      color: #999;
    }
  }
}

.topic-content {
  margin-bottom: 30px;
  padding-bottom: 30px;
  border-bottom: 1px solid #f0f0f0;

  .content-text {
    font-size: 16px;
    line-height: 1.8;
    color: #333;
    word-break: break-word;
  }
}

.topic-stats {
  display: flex;
  gap: 30px;
  margin-bottom: 30px;
  padding-bottom: 20px;
  border-bottom: 1px solid #f0f0f0;

  .stat-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    color: #666;
    cursor: pointer;
    transition: color 0.3s;

    &:hover {
      color: #ff6b6b;
    }

    .el-icon {
      font-size: 18px;
    }
  }
}

.comments-section {
  .comments-header {
    margin-bottom: 20px;

    h3 {
      font-size: 18px;
      font-weight: 600;
      color: #333;
    }
  }

  .comment-form {
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f8f8;
    border-radius: 8px;

    .el-textarea {
      margin-bottom: 12px;
    }

    .el-button {
      background-color: #ff6b6b;
      border-color: #ff6b6b;

      &:hover {
        background-color: #ff5252;
        border-color: #ff5252;
      }
    }
  }

  .login-tip {
    margin-bottom: 30px;
    padding: 20px;
    background: #f8f8f8;
    border-radius: 8px;
    text-align: center;

    a {
      color: #ff6b6b;
      text-decoration: none;

      &:hover {
        text-decoration: underline;
      }
    }
  }

  .comments-list {
    .comments-loading {
      display: flex;
      justify-content: center;
      padding: 40px 0;

      .is-loading {
        font-size: 32px;
        color: #ff6b6b;
        animation: rotate 2s linear infinite;
      }
    }

    .no-comments {
      text-align: center;
      padding: 40px 0;
      color: #999;
      font-size: 14px;
    }

    .comment-item {
      display: flex;
      gap: 12px;
      padding: 20px 0;
      border-bottom: 1px solid #f0f0f0;

      &:last-child {
        border-bottom: none;
      }

      .comment-avatar {
        flex-shrink: 0;

        img {
          width: 40px;
          height: 40px;
          border-radius: 50%;
          object-fit: cover;
        }
      }

      .comment-content {
        flex: 1;
        min-width: 0;

        .comment-header {
          display: flex;
          align-items: center;
          gap: 12px;
          margin-bottom: 8px;

          .comment-author {
            font-size: 14px;
            font-weight: 500;
            color: #333;
          }

          .comment-time {
            font-size: 12px;
            color: #999;
          }
        }

        .comment-text {
          font-size: 14px;
          line-height: 1.6;
          color: #666;
          word-break: break-word;
        }
      }
    }
  }
}

:deep(.el-textarea__inner) {
  border-radius: 8px;
  border-color: #e0e0e0;

  &:focus {
    border-color: #ff6b6b;
  }
}

.load-more {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  padding: 10px 0;

  .load-more-btn {
    font-size: 14px;
    color: #999;
    cursor: pointer;
    padding: 8px 20px;
    border-radius: 20px;
    transition: all 0.3s;

    &:hover {
      color: #666;
      background-color: #f5f5f5;
    }

    &.loading {
      color: #999;
      cursor: not-allowed;
    }
  }

  .no-more {
    font-size: 14px;
    color: #999;
    padding: 8px 20px;
  }
}

.comment-main {
  display: flex;
  gap: 12px;
}

.comment-actions {
  margin-top: 8px;

  .reply-btn {
    font-size: 13px;
    color: #999;
    cursor: pointer;
    transition: color 0.3s;

    &:hover {
      color: #ff6b6b;
    }
  }
}

.reply-form {
  margin-top: 12px;
  padding: 12px;
  background: #f8f8f8;
  border-radius: 8px;

  .reply-form-actions {
    margin-top: 8px;
    display: flex;
    justify-content: flex-end;
    gap: 8px;

    .el-button--primary {
      background-color: #ff6b6b;
      border-color: #ff6b6b;

      &:hover {
        background-color: #ff5252;
        border-color: #ff5252;
      }
    }
  }
}

.child-comments {
  margin-top: 16px;
  padding-left: 20px;
  border-left: 2px solid #f0f0f0;

  .child-comment-item {
    display: flex;
    gap: 10px;
    padding: 12px 0;

    &:first-child {
      padding-top: 0;
    }

    .child-comment-avatar {
      flex-shrink: 0;

      img {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        object-fit: cover;
      }
    }

    .child-comment-content {
      flex: 1;
      min-width: 0;

      .child-comment-header {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 4px;

        .child-comment-author {
          font-size: 13px;
          font-weight: 500;
          color: #333;
        }

        .reply-to {
          font-size: 12px;
          color: #999;
        }

        .parent-author {
          font-size: 13px;
          color: #ff6b6b;
          font-weight: 500;
        }

        .child-comment-time {
          font-size: 12px;
          color: #999;
        }
      }

      .child-comment-text {
        font-size: 13px;
        line-height: 1.5;
        color: #666;
        word-break: break-word;
      }

      .child-comment-actions {
        margin-top: 6px;

        .reply-btn {
          font-size: 12px;
          color: #999;
          cursor: pointer;
          transition: color 0.3s;

          &:hover {
            color: #ff6b6b;
          }
        }
      }
    }
  }
}
</style>
