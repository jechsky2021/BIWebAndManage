<template>
  <div class="question-detail">
    <main class="main-content">
      <div class="container">
        <div v-if="loading" class="loading-container">
          <el-icon class="is-loading"><Loading /></el-icon>
          <p>加载中...</p>
        </div>

        <div v-else-if="!question" class="empty-container">
          <p>问题不存在</p>
        </div>

        <div v-else class="question-wrapper">
          <div class="question-main">
            <div class="question-header">
              <h1 class="question-title">{{ question.title }}</h1>
              <div class="question-meta">
                <div class="author-info">
                  <img :src="getAvatarUrl(question.uAvatar) || '/placeholder-avatar.jpg'" :alt="question.uName" class="author-avatar" />
                  <div class="author-details">
                    <span class="author-name">{{ question.uName || '未知用户' }}</span>
                    <span class="author-occupation">{{ question.uOccupation || '' }}</span>
                  </div>
                </div>
                <div class="question-time">{{ dayjs(question.createTime).format('YYYY-MM-DD HH:mm:ss') }}</div>
              </div>
            </div>

            <div class="question-content">
              <div class="content-text">{{ question.content }}</div>
            </div>

            <div class="question-tags" v-if="question.tagNames">
              <span 
                v-for="(tagName, index) in question.tagNames.split(',')" 
                :key="index" 
                class="tag-item"
              >
                {{ tagName }}
              </span>
            </div>

            <div class="question-stats">
              <div class="stat-item">
                <el-icon><View /></el-icon>
                <span>{{ question.pageViews || 0 }}</span>
              </div>
              <div class="stat-item" @click="handleLike">
                <el-icon><Pointer /></el-icon>
                <span>{{ question.likes || 0 }}</span>
              </div>
            </div>

            <div class="answers-section">
              <div class="answers-header">
                <h3>回答 ({{ total }})</h3>
              </div>

              <div v-if="isLoggedIn" class="answer-form">
                <el-input
                  v-model="answerForm.content"
                  type="textarea"
                  :rows="4"
                  placeholder="写下你的回答..."
                  maxlength="1000"
                  show-word-limit
                />
                <el-button type="primary" @click="handleSubmitAnswer" :loading="answerLoading">
                  发表回答
                </el-button>
              </div>
              <div v-else class="login-tip">
                <router-link to="/login">登录后参与回答</router-link>
              </div>

              <div class="answers-list">
                <div v-if="answersLoading" class="answers-loading">
                  <el-icon class="is-loading"><Loading /></el-icon>
                </div>
                <div v-else-if="answers.length === 0" class="no-answers">
                  暂无回答，快来抢答吧~
                </div>
                <div v-else>
                  <div 
                    v-for="answer in answers" 
                    :key="answer.id" 
                    class="answer-item"
                    :class="{ 'is-best': answer.isBest }"
                  >
                    <div class="answer-header">
                      <div class="answer-author">
                        <img :src="getAvatarUrl(answer.uAvatar) || '/placeholder-avatar.jpg'" :alt="answer.uName" class="answer-avatar" />
                        <div class="answer-author-info">
                          <span class="answer-author-name">{{ answer.uName || '未知用户' }}</span>
                          <span class="answer-time">{{ dayjs(answer.createTime).format('YYYY-MM-DD HH:mm') }}</span>
                        </div>
                      </div>
                      <div class="answer-badge" v-if="answer.isBest">
                        <el-icon><Select /></el-icon>
                        最佳答案
                      </div>
                    </div>
                    <div class="answer-content">{{ answer.content }}</div>
                    <div class="answer-stats">
                      <!-- <span class="stat-item" @click="handleAnswerLike(answer)">
                        <el-icon><Pointer /></el-icon>
                        {{ answer.likes || 0 }}
                      </span> -->
                      <span 
                        v-if="isQuestionAuthor && question.status !== 2 && !hasBestAnswer && !answer.isBest" 
                        class="adopt-btn"
                        @click="handleAdoptAnswer(answer)"
                      >
                        采纳为最佳答案
                      </span>
                    </div>
                  </div>
                </div>
                
                <div class="load-more" v-if="answers.length > 0">
                  <span v-if="answers.length < total" 
                    class="load-more-btn" 
                    @click="loadMoreAnswers"
                    :class="{ 'loading': answersLoading }"
                  >
                    {{ answersLoading ? '加载中...' : '显示更多' }}
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
import { Loading, View, Pointer, Select } from '@element-plus/icons-vue'
import { 
  getQuestionDetail, 
  UpdateQuestionPageViews, 
  updateQuestionLikes, 
  getUidQid, 
  cancelQuestionLikes,
  getAnswersByPage,
  addAnswer,
  updateAnswerIsAccepted
} from '../../api/questions'
import { getAvatarUrl } from '../../utils/helpers'
import dayjs from 'dayjs'

const route = useRoute()
const questionId = computed(() => route.params.id as string)

const loading = ref(false)
const question = ref<any>(null)
const answers = ref<any[]>([])
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(2)
const answersLoading = ref(false)
const answerLoading = ref(false)
const answerForm = ref({
  content: ''
})

const isLoggedIn = computed(() => {
  return !!localStorage.getItem('token')
})

const isQuestionAuthor = computed(() => {
  const userInfo = localStorage.getItem('userInfo')
  if (!userInfo || !question.value) return false
  const parsedUserInfo = JSON.parse(userInfo)
  return parsedUserInfo.id === question.value.uId
})

// 是否已有最佳答案
const hasBestAnswer = computed(() => {
  return answers.value.some(answer => answer.isBest)
})

const loadQuestion = async () => {
  try {
    loading.value = true
    const response = await getQuestionDetail({ id: questionId.value })
    console.log("ddresponse", response)
    if (response.sign === '1' && response.data) {
      question.value = response.data[0]
      UpdateQuestionPageViews({ id: questionId.value })
    } else {
      ElMessage.error(response.msg || '获取问题详情失败')
    }
  } catch (error) {
    console.error('获取问题详情失败:', error)
    ElMessage.error('获取问题详情失败，请稍后重试')
  } finally {
    loading.value = false
  }
}

const loadAnswers = async () => {
  try {
    answersLoading.value = true
    const response = await getAnswersByPage({
      questionId: questionId.value,
      pageNumber: currentPage.value,
      pageSize: pageSize.value
    })
    
    if (response.sign === '1' && response.data) {
      const lists = (response.data.lists || []).map((item: any) => ({
        ...item,
        isBest: item.isAccepted === 1
      }))
      if (currentPage.value === 1) {
        answers.value = lists
      } else {
        answers.value = [...answers.value, ...lists]
      }
      total.value = response.data.total || 0
    }
  } catch (error) {
    console.error('获取回答失败:', error)
    ElMessage.error('获取回答失败，请稍后重试')
  } finally {
    answersLoading.value = false
  }
}

const loadMoreAnswers = () => {
  if (answersLoading.value) return
  currentPage.value++
  loadAnswers()
}

const handleSubmitAnswer = async () => {
  if (!answerForm.value.content.trim()) {
    ElMessage.warning('请输入回答内容')
    return
  }

  try {
    answerLoading.value = true
    const userInfo = localStorage.getItem('userInfo')
    if (!userInfo) {
      ElMessage.error('请先登录')
      return
    }

    const parsedUserInfo = JSON.parse(userInfo)
    const params = {
      questionId: questionId.value,
      content: answerForm.value.content,
      uId: parsedUserInfo.id
    }
    console.log("params:",params)
    const response = await addAnswer(params)
    console.log("response:",response)

    if (response.sign === '1') {
      ElMessage.success('回答发表成功')
      answerForm.value.content = ''
      currentPage.value = 1
      loadAnswers()
    } else {
      ElMessage.error(response.msg || '回答发表失败')
    }
  } catch (error) {
    console.error('发表回答失败:', error)
    ElMessage.error('发表回答失败，请稍后重试')
  } finally {
    answerLoading.value = false
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
      qId: questionId.value
    }

    console.log("params:",params)
    const checkResponse = await getUidQid(params)
    console.log("checkResponse:",checkResponse)
    
    if (checkResponse.sign === '1' && checkResponse.data) {
      const count = checkResponse.data[0].count || 0
      
      if (count > 0) {
        const cancelResponse = await cancelQuestionLikes(params)
        
        if (cancelResponse.sign === '1') {
          ElMessage.success('取消点赞成功')
          if (question.value) {
            question.value.likes = Math.max(0, (question.value.likes || 0) - 1)
          }
        } else {
          ElMessage.error(cancelResponse.msg || '取消点赞失败')
        }
      } else {
        const likeResponse = await updateQuestionLikes(params)
        
        if (likeResponse.sign === '1') {
          ElMessage.success('点赞成功')
          if (question.value) {
            question.value.likes = (question.value.likes || 0) + 1
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


const handleAdoptAnswer = async (answer: any) => {
  try {
    const response = await updateAnswerIsAccepted({
      id: questionId.value
    })
    
    if (response.sign === '1') {
      ElMessage.success('已采纳为最佳答案')
      // 更新问题状态
      if (question.value) {
        question.value.status = 2
      }
      // 更新回答的 isBest 状态
      answers.value.forEach(a => {
        a.isBest = a.id === answer.id
      })
    } else {
      ElMessage.error(response.msg || '采纳失败')
    }
  } catch (error) {
    console.error('采纳失败:', error)
    ElMessage.error('采纳失败，请稍后重试')
  }
}

onMounted(() => {
  loadQuestion()
  loadAnswers()
})
</script>

<style lang="scss" scoped>
.question-detail {
  min-height: 100vh;
  background-color: #f8f8f8;
}

.main-content {
  padding: 30px 0;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }
}

.loading-container,
.empty-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100px 0;
  color: #999;

  .is-loading {
    font-size: 40px;
    margin-bottom: 16px;
    animation: rotate 1s linear infinite;
  }

  p {
    font-size: 16px;
    color: #999;
    margin: 0;
  }
}

@keyframes rotate {
  from {
    transform: rotate(0deg);
  }
  to {
    transform: rotate(360deg);
  }
}

.question-wrapper {
  max-width: 900px;
  margin: 0 auto;
}

.question-main {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.question-header {
  padding: 24px;
  border-bottom: 1px solid #f0f0f0;

  .question-title {
    font-size: 24px;
    font-weight: 600;
    color: #333;
    margin: 0 0 16px 0;
    line-height: 1.4;
  }

  .question-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .author-info {
    display: flex;
    align-items: center;
    gap: 12px;

    .author-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
    }

    .author-details {
      display: flex;
      flex-direction: column;
      gap: 4px;

      .author-name {
        font-size: 14px;
        font-weight: 500;
        color: #333;
      }

      .author-occupation {
        font-size: 12px;
        color: #999;
      }
    }
  }

  .question-time {
    font-size: 14px;
    color: #999;
  }
}

.question-content {
  padding: 24px;

  .content-text {
    font-size: 16px;
    color: #333;
    line-height: 1.8;
    white-space: pre-wrap;
    word-break: break-word;
  }
}

.question-tags {
  padding: 0 24px 16px;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;

  .tag-item {
    display: inline-block;
    padding: 4px 12px;
    background-color: #fff5f5;
    color: #ff6b6b;
    border-radius: 12px;
    font-size: 12px;
    border: 1px solid #ffe0e0;
  }
}

.question-stats {
  padding: 16px 24px;
  border-top: 1px solid #f0f0f0;
  display: flex;
  gap: 24px;

  .stat-item {
    display: flex;
    align-items: center;
    gap: 6px;
    color: #999;
    cursor: pointer;
    transition: color 0.2s ease;

    &:hover {
      color: #ff6b6b;
    }

    .el-icon {
      font-size: 18px;
    }
  }
}

.answers-section {
  border-top: 1px solid #f0f0f0;

  .answers-header {
    padding: 16px 24px;
    border-bottom: 1px solid #f0f0f0;

    h3 {
      margin: 0;
      font-size: 18px;
      color: #333;
    }
  }
}

.answer-form {
  padding: 20px 24px;
  border-bottom: 1px solid #f0f0f0;

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
  padding: 20px 24px;
  text-align: center;
  color: #999;
  border-bottom: 1px solid #f0f0f0;

  a {
    color: #ff6b6b;
    text-decoration: none;

    &:hover {
      text-decoration: underline;
    }
  }
}

.answers-list {
  padding: 16px 24px;
}

.answers-loading,
.no-answers {
  text-align: center;
  padding: 40px 0;
  color: #999;

  .is-loading {
    font-size: 32px;
    animation: rotate 1s linear infinite;
  }
}

.answer-item {
  padding: 20px 0;
  border-bottom: 1px solid #f0f0f0;

  &:last-child {
    border-bottom: none;
  }

  &.is-best {
    background-color: #f0fff4;
    border: 1px solid #4caf50;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 16px;
  }

  .answer-header {
    margin-bottom: 12px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    .answer-author {
      display: flex;
      align-items: center;
      gap: 12px;

      .answer-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        object-fit: cover;
      }

      .answer-author-info {
        display: flex;
        flex-direction: column;
        gap: 2px;

        .answer-author-name {
          font-size: 14px;
          font-weight: 500;
          color: #333;
        }

        .answer-time {
          font-size: 12px;
          color: #999;
        }
      }
    }

    .answer-badge {
      display: flex;
      align-items: center;
      gap: 4px;
      background-color: #4caf50;
      color: #fff;
      padding: 4px 12px;
      border-radius: 12px;
      font-size: 12px;
      font-weight: 500;
    }
  }

  .answer-content {
    font-size: 14px;
    color: #333;
    line-height: 1.6;
    margin-bottom: 12px;
    white-space: pre-wrap;
    word-break: break-word;
  }

  .answer-stats {
    display: flex;
    gap: 16px;
    align-items: center;

    .stat-item {
      display: flex;
      align-items: center;
      gap: 4px;
      font-size: 14px;
      color: #999;
      cursor: pointer;
      transition: color 0.2s ease;

      &:hover {
        color: #ff6b6b;
      }
    }

    .adopt-btn {
      font-size: 14px;
      color: #4caf50;
      cursor: pointer;
      transition: all 0.2s ease;
      padding: 4px 12px;
      border: 1px solid #4caf50;
      border-radius: 4px;

      &:hover {
        background-color: #4caf50;
        color: #fff;
      }
    }
  }
}

.load-more {
  text-align: center;
  padding: 20px 0;

  .load-more-btn {
    color: #ff6b6b;
    cursor: pointer;
    font-size: 14px;
    transition: opacity 0.3s ease;

    &:hover {
      opacity: 0.8;
    }

    &.loading {
      opacity: 0.6;
      cursor: not-allowed;
    }
  }

  .no-more {
    color: #999;
    font-size: 14px;
  }
}
</style>
