<template>
  <div class="beauty-circle">

    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <div class="circle-tabs">
          <button 
            v-for="tab in tabs" 
            :key="tab.key"
            :class="['tab', { active: activeTab === tab.key }]"
            @click="handleTabChange(tab.key)"
          >
            {{ tab.name }}
          </button>
        </div>

        <div class="circle-content">
          <!-- 热门话题 -->
          
          <div v-if="activeTab === 'hot'" class="hot-topics">
            <!-- 发布话题按钮 -->
            <div class="post-button-container" v-if="isLoggedIn">
              <el-button type="primary" @click="showPostDialog = true" class="post-btn">
                <el-icon><Plus /></el-icon>
                发布话题
              </el-button>
            </div>

            <div v-if="loading" class="loading-container">
              <el-icon class="is-loading"><Loading /></el-icon>
              <p>加载中...</p>
            </div>
            <div v-else-if="hotTopics.length === 0" class="empty-container">
              <p>暂无话题</p>
            </div>
            <div v-else v-for="topic in hotTopics" :key="topic.id" class="topic-card" @click="goToDetail(topic.id)">
              <div class="topic-header">
                <div class="topic-avatar">
                  <img :src="getAvatarUrl(topic.uAvatar) || '/placeholder-avatar.jpg'" :alt="topic.uName || '用户'" />
                </div>
                <div class="topic-author">
                  <div class="author-name">{{ topic.uName || '未知用户' }}</div>
                  <div class="author-title">{{ topic.uOccupation || '' }}</div>
                </div>
                <div class="topic-time">{{ dayjs(topic.createTime).format('YYYY-MM-DD HH:mm:ss') || '' }}</div>
              </div>

              <div class="topic-content">
                <h3 class="topic-title">{{ topic.title || '' }}</h3>
                <p class="topic-description">{{ topic.content || '' }}</p>

                <div v-if="topic.images && topic.images.length > 0" class="topic-images">
                  <img
                    v-for="(_image, index) in topic.images"
                    :key="index"
                    :src="'/placeholder-topic.jpg'"
                    :alt="topic.title || '话题图片'"
                  />
                </div>
              </div>

              <div class="topic-stats">
                <div class="stat-item">
                  <span class="stat-icon">👍</span>
                  <span class="stat-count">{{ topic.likes || 0 }}</span>
                </div>
                <div class="stat-item">
                  <span class="stat-icon">💬</span>
                  <span class="stat-count">{{ topic.comments || 0 }}</span>
                </div>
              </div>
            </div>

            <!-- 分页 -->
            <div class="pagination-wrapper">
              <el-pagination
                v-model:current-page="currentPage"
                v-model:page-size="pageSize"
                :total="total"
                :page-sizes="[10, 20, 30, 50]"
                layout="total, sizes, prev, pager, next, jumper"
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
              />
            </div>
          </div>
        

          <!-- 美业问答 -->
          <div v-else-if="activeTab === 'qa'" class="qa-section">
            <!-- 发布问答按钮 -->
            <div class="post-button-container" v-if="isLoggedIn">
              <el-button type="primary" @click="showQuestionDialog = true" class="post-btn">
                <el-icon><Plus /></el-icon>
                发布问答
              </el-button>
            </div>
            
            <div class="qa-filters">
              <button 
                :class="['filter-btn', { active: currentFilter === '全部问题' }]" 
                @click="createFilter('全部问题')"
              >
                全部问题
              </button>
              <button 
                :class="['filter-btn', { active: currentFilter === '待回答' }]" 
                @click="createFilter('待回答')"
              >
                待回答
              </button>
              <button 
                :class="['filter-btn', { active: currentFilter === '已解决' }]" 
                @click="createFilter('已解决')"
              >
                已解决
              </button>
            </div>
            
            <div v-if="questionLoading" class="loading-container">
              <el-icon class="is-loading"><Loading /></el-icon>
              <p>加载中...</p>
            </div>
            <div v-else-if="filterQuestion.length === 0" class="empty-container">
              <p>暂无问题</p>
            </div>
            <div v-else class="qa-list">
              <div v-for="question in filterQuestion" :key="question.id" class="question-card" @click="goToQuestionDetail(question.id)">
                <div class="question-header">
                  <div class="question-title">{{ question.title }}</div>
                </div>
                
                <div class="question-content" v-if="question.content">
                  {{ question.content.substring(0, 100) }}{{ question.content.length > 100 ? '...' : '' }}
                </div>
                
                <div class="question-tag-list" v-if="question.tagNames">
                  <span 
                    v-for="(tagName, index) in question.tagNames.split(',')" 
                    :key="index" 
                    class="tag-item"
                  >
                    {{ tagName }}
                  </span>
                </div>
                
                <div class="question-stats">
                  <span class="stat-text">{{ question.answers || 0 }} 回答</span>
                  <span class="stat-text">{{ question.pageViews || 0 }} 浏览</span>
                  <span class="stat-text">{{ question.createTime ? dayjs(question.createTime).format('YYYY-MM-DD HH:mm') : '' }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 发帖对话框 -->
        <el-dialog
          v-model="showPostDialog"
          title="发布话题"
          width="600px"
        >
          <el-form :model="postForm" :rules="postRules" ref="postFormRef" label-width="80px">
            <el-form-item label="标题" prop="title">
              <el-input v-model="postForm.title" placeholder="请输入话题标题" maxlength="50" show-word-limit />
            </el-form-item>
            
            <el-form-item label="内容" prop="content">
              <el-input
                v-model="postForm.content"
                type="textarea"
                placeholder="请输入话题内容"
                :rows="6"
                maxlength="500"
                show-word-limit
              />
            </el-form-item>
          </el-form>
          
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="showPostDialog = false">取消</el-button>
              <el-button type="primary" @click="handlePostTopic" :loading="postLoading">
                发布
              </el-button>
            </span>
          </template>
        </el-dialog>

        <!-- 发布问答对话框 -->
        <el-dialog
          v-model="showQuestionDialog"
          title="发布问答"
          width="600px"
        >
          <el-form :model="questionForm" :rules="questionRules" ref="questionFormRef" label-width="80px">
            <el-form-item label="标题" prop="title">
              <el-input v-model="questionForm.title" placeholder="请输入问题标题" maxlength="50" show-word-limit />
            </el-form-item>
            
            <el-form-item label="内容" prop="content">
              <el-input
                v-model="questionForm.content"
                type="textarea"
                placeholder="请详细描述您的问题"
                :rows="6"
                maxlength="500"
                show-word-limit
              />
            </el-form-item>
            
            <el-form-item label="标签" prop="tagIds">
              <div class="tag-select-wrapper">
                <el-select
                  v-model="selectedTagIds"
                  multiple
                  placeholder="请选择标签"
                  class="tag-select"
                  :loading="tagLoading"
                >
                  <el-option
                    v-for="tag in allTags"
                    :key="tag.id"
                    :label="tag.name"
                    :value="tag.id"
                  />
                </el-select>
                <el-button type="primary" @click="goToTagManage" class="tag-manage-btn">
                  标签管理
                </el-button>
              </div>
            </el-form-item>
          </el-form>
          
          <template #footer>
            <span class="dialog-footer">
              <el-button @click="showQuestionDialog = false">取消</el-button>
              <el-button type="primary" @click="handlePostQuestion" :loading="questionPosting">
                发布
              </el-button>
            </span>
          </template>
        </el-dialog>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import { useRouter } from 'vue-router';
import { ElMessage } from 'element-plus';
import { Plus, Loading } from '@element-plus/icons-vue';
import type { FormInstance, FormRules } from 'element-plus';
import { addTopic, getTopicsByPage } from '../../api/topics';
import { addQuestion, getQuestionsByPage } from '../../api/questions';
import { getAvatarUrl } from '../../utils/helpers';
import dayjs from 'dayjs'


const router = useRouter();
const filterQuestion = ref<any[]>([]);
const activeTab = ref('hot');
const currentFilter = ref('全部问题');
const questionLoading = ref(false);
const questionCurrentPage = ref(1);
const questionPageSize = ref(10);
const questionTotal = ref(0);

// 发帖相关
const showPostDialog = ref(false);
const postFormRef = ref<FormInstance>();
const postLoading = ref(false);
const postForm = ref({
  title: '',
  content: ''
});

const postRules = ref<FormRules>({
  title: [
    { required: true, message: '请输入话题标题', trigger: 'blur' },
    { min: 2, max: 50, message: '标题长度在 2 到 50 个字符', trigger: 'blur' }
  ],
  content: [
    { required: true, message: '请输入话题内容', trigger: 'blur' },
    { min: 5, max: 500, message: '内容长度在 5 到 500 个字符', trigger: 'blur' }
  ]
});

// 发布问答相关
const showQuestionDialog = ref(false);
const questionFormRef = ref<FormInstance>();
const questionPosting = ref(false);
const questionForm = ref({
  title: '',
  content: '',
  tagIds: ''
});

// 选中的标签ID数组（用于下拉框绑定）
const selectedTagIds = ref<number[]>([]);

const questionRules = ref<FormRules>({
  title: [
    { required: true, message: '请输入问题标题', trigger: 'blur' },
    { min: 2, max: 50, message: '标题长度在 2 到 50 个字符', trigger: 'blur' }
  ],
  content: [
    { required: true, message: '请输入问题内容', trigger: 'blur' },
    { min: 5, max: 500, message: '内容长度在 5 到 500 个字符', trigger: 'blur' }
  ]
});

// 标签相关
const allTags = ref<any[]>([]);
const tagLoading = ref(false);

// 登录状态
const isLoggedIn = computed(() => {
  return !!localStorage.getItem('token');
});

const tabs: any[] = [
  { key: 'hot', name: '热门话题' },
  { key: 'qa', name: '美业问答' }
  // , { key: 'exchange', name: '行业交流' }
];

// 热门话题数据
const hotTopics = ref<any[]>([]);
const loading = ref(false);
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(0);

const createFilter = (filter: string) => {
  currentFilter.value = filter;
  questionCurrentPage.value = 1;
  loadQuestions();
};

// 处理标签切换
const handleTabChange = (tabKey: string) => {
  activeTab.value = tabKey;
  // 切换到美业问答标签时，如果问题列表为空则加载
  if (tabKey === 'qa' && filterQuestion.value.length === 0) {
    loadQuestions();
  }
};

const loadQuestions = async () => {
  try {
    questionLoading.value = true;
    
    const params: any = {
      pageNumber: questionCurrentPage.value,
      pageSize: questionPageSize.value
    };
    
    // 根据筛选条件设置 status 参数
    // 0:待回答, 2:已解决
    if (currentFilter.value === '全部问题') {
      params.status = -1;
    } 
    else if (currentFilter.value === '待回答') {
      params.status = 0;
    } else if (currentFilter.value === '已解决') {
      params.status = 2;
    }
    // 全部问题时不传 status 参数

    //console.log('getQuestionsByPage params:', params);
    const response = await getQuestionsByPage(params);
    //console.log('getQuestionsByPage response:', response);
    
    if (response.sign === '1' && response.data) {
      filterQuestion.value = response.data.lists || [];
      questionTotal.value = response.data.total || 0;
    } else {
      ElMessage.error(response.msg || '获取问题失败');
    }
  } catch (error) {
    console.error('获取问题失败:', error);
    ElMessage.error('获取问题失败，请稍后重试');
  } finally {
    questionLoading.value = false;
  }
};

// 跳转到话题详情页
const goToDetail = (id: number) => {
  router.push(`/topic/${id}`);
};

// 跳转到问题详情页
const goToQuestionDetail = (id: number) => {
  router.push(`/question/${id}`);
};

// 跳转到标签管理页面
const goToTagManage = () => {
  router.push('/tag-manage');
};

// 加载话题数据
const loadTopics = async () => {
  try {
    loading.value = true;
    const params = {
      pageNumber: currentPage.value,
      pageSize: pageSize.value
    };

    // console.log("params:",params)
    const response = await getTopicsByPage(params);
    // console.log("response:",response)
    
    if (response.sign === '1' && response.data) {
      hotTopics.value = response.data.lists || [];
      total.value = response.data.total || 0;
    } else {
      ElMessage.error(response.msg || '获取话题失败');
    }
  } catch (error) {
    console.error('获取话题失败:', error);
    ElMessage.error('获取话题失败，请稍后重试');
  } finally {
    loading.value = false;
  }
};

// 分页事件处理
const handleSizeChange = (val: number) => {
  pageSize.value = val;
  currentPage.value = 1;
  loadTopics();
};

const handleCurrentChange = (val: number) => {
  currentPage.value = val;
  loadTopics();
};

// 发布话题
const handlePostTopic = async () => {
  if (!postFormRef.value) return;
  try {
    await postFormRef.value.validate();
    postLoading.value = true;

    const userInfo = localStorage.getItem('userInfo');
    if (!userInfo) {
      ElMessage.error('请先登录');
      postLoading.value = false;
      return;
    }

    const parsedUserInfo = JSON.parse(userInfo);
    const uId = parsedUserInfo.id;

    if (!uId) {
      ElMessage.error('用户信息不完整');
      postLoading.value = false;
      return;
    }

    const params = {
      title: postForm.value.title,
      content: postForm.value.content,
      uId: uId
    };

    const response = await addTopic(params);
    
    if (response.sign === '1') {
      ElMessage.success('话题发布成功！');
      showPostDialog.value = false;
      // 重置表单
      postForm.value.title = '';
      postForm.value.content = '';
      postFormRef.value.resetFields();
      // 刷新话题列表
      loadTopics();
    } else {
      ElMessage.error(response.msg || '话题发布失败，请稍后重试');
    }
    postLoading.value = false;
  } catch (error) {
    console.error('发布话题失败:', error);
    ElMessage.error('发布话题失败，请稍后重试');
    postLoading.value = false;
  }
};

// 发布问答
const handlePostQuestion = async () => {
  if (!questionFormRef.value) return;
  try {
    await questionFormRef.value.validate();
    questionPosting.value = true;

    const userInfo = localStorage.getItem('userInfo');
    if (!userInfo) {
      ElMessage.error('请先登录');
      questionPosting.value = false;
      return;
    }

    const parsedUserInfo = JSON.parse(userInfo);
    const uId = parsedUserInfo.id;

    if (!uId) {
      ElMessage.error('用户信息不完整');
      questionPosting.value = false;
      return;
    }

    // 将选中的标签ID数组转换为逗号隔开的字符串
    const tagIdsStr = selectedTagIds.value.join(',');
    
    const params = {
      title: questionForm.value.title,
      content: questionForm.value.content,
      uId: uId,
      tagIds: tagIdsStr
    };

    const response = await addQuestion(params);
    
    if (response.sign === '1') {
      ElMessage.success('问题发布成功！');
      showQuestionDialog.value = false;
      // 重置表单
      questionForm.value.title = '';
      questionForm.value.content = '';
      questionForm.value.tagIds = '';
      selectedTagIds.value = [];
      questionFormRef.value.resetFields();
      // 刷新问题列表
      loadQuestions();
    } else {
      ElMessage.error(response.msg || '问题发布失败，请稍后重试');
    }
    questionPosting.value = false;
  } catch (error) {
    console.error('发布问题失败:', error);
    ElMessage.error('发布问题失败，请稍后重试');
    questionPosting.value = false;
  }
};

onMounted(() => {
   
    loadTopics();
  
  // 默认显示热门话题，不加载问题列表
  // 问题列表会在切换到美业问答标签时加载
});
</script>

<style lang="scss" scoped>
.beauty-circle {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f8f8;
}

/* 发帖按钮容器 */
.post-button-container {
  margin-bottom: 20px;
  text-align: right;
  width: 100%;
  grid-column: 1 / -1;

  .post-btn {
    background-color: #ff6b6b;
    border-color: #ff6b6b;
    border-radius: 25px;
    padding: 10px 24px;
    font-size: 14px;
    font-weight: 500;
    transition: all 0.3s ease;

    &:hover {
      background-color: #ff5252;
      border-color: #ff5252;
      transform: translateY(-2px);
    }
  }
}

/* 对话框样式 */
:deep(.el-dialog) {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

:deep(.el-dialog__header) {
  border-bottom: 1px solid #f0f0f0;
  padding: 20px;
  background-color: #fff;

  .el-dialog__title {
    font-size: 18px;
    font-weight: 500;
    color: #333;
  }
}

:deep(.el-dialog__body) {
  padding: 20px;
  background-color: #fff;
}

:deep(.el-dialog__footer) {
  border-top: 1px solid #f0f0f0;
  padding: 20px;
  background-color: #fff;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

/* 表单样式 */
:deep(.el-form-item__label) {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

:deep(.el-input__wrapper) {
  border-radius: 8px;
  box-shadow: 0 0 0 1px #e0e0e0 inset;
  transition: all 0.3s ease;
  background-color: #fff;

  &.is-focus {
    box-shadow: 0 0 0 1px #ff6b6b inset;
    background-color: #fff;
  }
}

:deep(.el-input__inner:focus) {
  box-shadow: none;
}

:deep(.el-input__inner) {
  font-size: 14px;
  color: #333;
}

:deep(.el-textarea__inner) {
  border-radius: 8px;
  font-size: 14px;
  color: #333;
  resize: vertical;
}

:deep(.el-button) {
  border-radius: 8px;
  padding: 8px 16px;
  font-size: 14px;
  transition: all 0.3s ease;
}

:deep(.el-button--primary) {
  background-color: #ff6b6b;
  border-color: #ff6b6b;

  &:hover {
    background-color: #ff5252;
    border-color: #ff5252;
  }
}

:deep(.el-button--default) {
  color: #666;
  border-color: #e0e0e0;

  &:hover {
    color: #ff6b6b;
    border-color: #ff6b6b;
  }
}

:deep(.el-form-item__error) {
  font-size: 12px;
  color: #ff4d4f;
}

:deep(.el-input__count) {
  font-size: 12px;
  color: #999;
}

/* 加载和空状态 */
.loading-container,
.empty-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 0;
  text-align: center;

  .is-loading {
    font-size: 48px;
    color: #ff6b6b;
    margin-bottom: 16px;
    animation: rotate 2s linear infinite;
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

/* 导航栏样式（与首页相同） */
.navbar {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  padding: 16px 0;

  .container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;

    a {
      color: inherit;
      text-decoration: none;
    }
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .nav-link {
    color: #666;
    text-decoration: none;
    padding: 8px 16px;
    transition: all 0.3s ease;
    position: relative;
    cursor: pointer;

    &:hover,
    &.active {
      color: #ff6b6b;
    }

    &.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 20px;
      height: 3px;
      background-color: #ff6b6b;
      border-radius: 2px;
    }
  }

  .category-dropdown {
    position: relative;
  }

  .dropdown-menu {
    position: absolute;
    top: 100%;
    left: 0;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    border-radius: 4px;
    padding: 8px 0;
    min-width: 120px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.3s ease;
    z-index: 1001;

    .dropdown-item {
      display: block;
      padding: 8px 16px;
      color: #666;
      text-decoration: none;
      transition: all 0.2s ease;

      &:hover {
        background-color: #f5f5f5;
        color: #ff6b6b;
      }
    }
  }

  .category-dropdown:hover .dropdown-menu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
  }

  .login-btn {
    padding: 8px 20px;
    background-color: #ff6b6b;
    color: #fff;
    border-radius: 20px;
    text-decoration: none;
    transition: all 0.3s ease;

    &:hover {
      background-color: #ff5252;
      transform: translateY(-2px);
    }
  }
}

/* 主要内容样式 */
.main-content {
  flex: 1;
  padding: 20px 0;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .page-title {
    font-size: 32px;
    margin-bottom: 24px;
    color: #333;
  }

  .circle-tabs {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
    background-color: #fff;
    padding: 12px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .tab {
      flex: 1;
      padding: 12px 24px;
      border: none;
      background: none;
      font-size: 16px;
      color: #666;
      cursor: pointer;
      transition: all 0.3s ease;
      border-radius: 6px;

      &:hover {
        background-color: #f0f0f0;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
      }
    }
  }

  .circle-content {
    /* 热门话题样式 */
    .hot-topics {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
      gap: 24px;

      .topic-card {
        background-color: #fff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        cursor: pointer;

        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .topic-header {
          display: flex;
          align-items: center;
          margin-bottom: 16px;

          .topic-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 12px;

            img {
              width: 100%;
              height: 100%;
              object-fit: cover;
            }
          }

          .topic-author {
            flex: 1;

            .author-name {
              font-weight: 500;
              color: #333;
              margin-bottom: 4px;
            }

            .author-title {
              font-size: 14px;
              color: #999;
            }
          }

          .topic-time {
            font-size: 14px;
            color: #999;
          }
        }

        .topic-content {
          .topic-title {
            font-size: 18px;
            margin-bottom: 12px;
            color: #333;
            line-height: 1.4;
          }

          .topic-description {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 16px;
          }

          .topic-images {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 16px;

            img {
              width: 100%;
              aspect-ratio: 1;
              object-fit: cover;
              border-radius: 4px;
            }
          }
        }

        .topic-stats {
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

            .stat-icon {
              font-size: 18px;
            }

            .stat-count {
              font-size: 14px;
            }
          }
        }
      }

      .pagination-wrapper {
        grid-column: 1 / -1;
        display: flex;
        justify-content: center;
        margin-top: 30px;
        padding: 20px 0;

        :deep(.el-pagination) {
          .el-pagination__total,
          .el-pagination__sizes,
          .el-pagination__jump {
            color: #666;
          }

          .el-pager li {
            color: #666;
            border-radius: 4px;
            transition: all 0.3s ease;

            &:hover {
              color: #ff6b6b;
            }

            &.is-active {
              background-color: #ff6b6b;
              color: #fff;
            }
          }

          .btn-prev,
          .btn-next {
            color: #666;
            border-radius: 4px;

            &:hover {
              color: #ff6b6b;
            }

            &:disabled {
              color: #ccc;
            }
          }

          .el-input__wrapper {
            border-radius: 4px;

            &.is-focus {
              box-shadow: 0 0 0 1px #ff6b6b inset;
            }
          }
        }
      }
    }

    /* 问答区域样式 */
    .qa-section {
      background-color: #fff;
      border-radius: 8px;
      padding: 24px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

      .qa-filters {
        display: flex;
        gap: 12px;
        margin-bottom: 24px;

        .filter-btn {
          padding: 8px 20px;
          border: 1px solid #e0e0e0;
          background-color: #fff;
          border-radius: 20px;
          cursor: pointer;
          transition: all 0.3s ease;

          &:hover {
            border-color: #ff6b6b;
            color: #ff6b6b;
          }

          &.active {
            background-color: #ff6b6b;
            border-color: #ff6b6b;
            color: #fff;
          }
        }
      }

      .qa-list {
        .question-card {
          padding: 16px 0;
          border-bottom: 1px solid #f0f0f0;

          &:last-child {
            border-bottom: none;
          }

          .question-header {
            margin-bottom: 12px;

            .question-title {
              font-size: 18px;
              color: #333;
              margin-bottom: 8px;
              cursor: pointer;
              transition: color 0.2s ease;

              &:hover {
                color: #ff6b6b;
              }
            }

            .question-tags {
              display: flex;
              gap: 8px;

              .tag {
                padding: 4px 12px;
                border-radius: 12px;
                font-size: 12px;
                
                &.pending {
                  background-color: #fff3e0;
                  color: #ff9800;
                }
                
                &.solved {
                  background-color: #e8f5e9;
                  color: #4caf50;
                }
              }
            }
          }

          .question-content {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 12px;
          }

          .question-tag-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 12px;

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
            display: flex;
            gap: 24px;
            font-size: 14px;
            color: #999;
          }
        }
      }
    }

    /* 交流区域样式 */
    .exchange-section {
      .exchange-groups {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 24px;

        .group-card {
          background-color: #fff;
          border-radius: 8px;
          padding: 24px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
          transition: all 0.3s ease;

          &:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
          }

          .group-info {
            .group-name {
              font-size: 20px;
              margin-bottom: 12px;
              color: #333;
            }

            .group-description {
              font-size: 14px;
              color: #666;
              line-height: 1.6;
              margin-bottom: 16px;
            }

            .group-stats {
              display: flex;
              gap: 24px;
              margin-bottom: 20px;
              font-size: 14px;
              color: #999;
            }

            .join-btn {
              width: 100%;
              padding: 10px;
              background-color: #ff6b6b;
              color: #fff;
              border: none;
              border-radius: 6px;
              font-size: 16px;
              cursor: pointer;
              transition: all 0.3s ease;

              &:hover {
                background-color: #ff5252;
              }
            }
          }
        }
      }
    }
  }
}

/* 页脚样式（与首页相同） */
.footer {
  background-color: #333;
  color: #fff;
  padding: 40px 0;
  margin-top: auto;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .footer-content {
    display: flex;
    justify-content: space-between;
    margin-bottom: 40px;

    .footer-logo {
      flex: 0 0 250px;

      h2 {
        font-size: 24px;
        margin-bottom: 12px;
      }

      p {
        color: #ccc;
        font-size: 14px;
      }
    }

    .footer-links {
      display: flex;
      gap: 60px;

      .link-group {
        h3 {
          font-size: 16px;
          margin-bottom: 16px;
          color: #fff;
        }

        a {
          display: block;
          color: #ccc;
          text-decoration: none;
          margin-bottom: 8px;
          font-size: 14px;
          transition: color 0.2s ease;

          &:hover {
            color: #ff6b6b;
          }
        }
      }
    }
  }

  .footer-bottom {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #555;
    color: #999;
    font-size: 14px;
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .navbar .container {
    flex-direction: column;
    gap: 16px;
  }

  .nav-links {
    flex-wrap: wrap;
    justify-content: center;
  }

  .page-title {
    font-size: 24px;
  }

  .circle-tabs {
    flex-direction: column;
  }

  .hot-topics,
  .exchange-groups {
    grid-template-columns: 1fr;
  }

  .footer-content {
    flex-direction: column;
    gap: 30px;

    .footer-links {
      flex-wrap: wrap;
      gap: 30px;
    }
  }
}

/* 标签选择样式 */
.tag-select-wrapper {
  display: flex;
  align-items: center;
  gap: 12px;

  .tag-select {
    width: 360px;
    flex: none;
  }

  .tag-manage-btn {
    white-space: nowrap;
    color: #fff;
    background-color: #ff6b6b;
    border-color: #ff6b6b;
    padding: 8px 16px;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s ease;

    &:hover {
      background-color: #ff5252;
      border-color: #ff5252;
      transform: translateY(-2px);
      color: #fff;
    }
  }
}
</style>