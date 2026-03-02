<template>
  <div class="user-center">
    <main class="main-content">
      <div class="container">
        <div class="user-center-layout">
          <!-- 左侧导航 -->
          <aside class="user-sidebar">
            <div class="sidebar-header">
              <h2>个人中心</h2>
            </div>
            <nav class="sidebar-nav">
              <ul>
                <li :class="{ active: activeTab === 'profile' }" @click="handleTabClick('profile')">
                  <span class="nav-text">个人资料</span>
                </li>
                <li :class="{ active: activeTab === 'topics' }" @click="handleTabClick('topics')">
                  <span class="nav-text">我的话题</span>
                </li>
                <li :class="{ active: activeTab === 'questions' }" @click="handleTabClick('questions')">
                  <span class="nav-text">我的问答</span>
                </li>
                <li :class="{ active: activeTab === 'favorites' }" @click="handleTabClick('favorites')">
                  <span class="nav-text">我喜欢的话题</span>
                </li>
                <li :class="{ active: activeTab === 'question-likes' }" @click="handleTabClick('question-likes')">
                  <span class="nav-text">我喜欢的问答</span>
                </li>
              </ul>
            </nav>
          </aside>

          <!-- 右侧内容 -->
          <div class="user-content">
            <!-- 个人资料 -->
            <div v-if="activeTab === 'profile'" class="profile-section">
              <!-- 用户信息卡片 -->
              <div class="user-info-card">
                <div class="avatar-section">
                  <div class="avatar-wrapper">
                    <img v-if="userInfo.uAvatar" :src="avatarUrl" alt="头像" class="avatar" />
                    <div v-else class="avatar-placeholder">{{ userInfo.uName?.charAt(0) || 'U' }}</div>
                    <el-upload
                      class="avatar-upload"
                      action="#"
                      :auto-upload="true"
                      :show-file-list="false"
                      :before-upload="beforeUploadAvatar"
                    >
                      <span>更换头像</span>
                    </el-upload>
                  </div>
                </div>

                <div class="info-section">
                  <h2 class="user-name">{{ userInfo.uName || '未设置用户名' }}</h2>
                  <p class="user-phone">{{ userInfo.uPhone || '未设置手机号' }}</p>
                  <p class="user-profession">{{ userInfo.uOccupation || '未设置职业' }}</p>
                </div>
              </div>

              <!-- 编辑资料表单 -->
              <div class="edit-section">
                <h3 class="section-title">编辑资料</h3>
                <el-form :model="editForm" :rules="editRules" ref="editFormRef" label-width="100px">
                  <el-form-item label="用户名" prop="username">
                    <el-input v-model="editForm.username" placeholder="请输入用户名" />
                  </el-form-item>

                  <el-form-item label="手机号" prop="phone">
                    <el-input v-model="editForm.phone" placeholder="请输入手机号" />
                  </el-form-item>

                  <el-form-item label="职业" prop="profession">
                    <el-input v-model="editForm.profession" placeholder="请输入职业" />
                  </el-form-item>

                  <el-form-item>
                    <el-button type="primary" @click="handleSaveInfo" :loading="loading">保存资料</el-button>
                  </el-form-item>
                </el-form>
              </div>

              <!-- 修改密码 -->
              <div class="password-section">
                <h3 class="section-title">修改密码</h3>
                <el-form :model="passwordForm" :rules="passwordRules" ref="passwordFormRef" label-width="100px">
                  <el-form-item label="原密码" prop="oldPassword">
                    <el-input v-model="passwordForm.oldPassword" type="password" placeholder="请输入原密码" show-password />
                  </el-form-item>

                  <el-form-item label="新密码" prop="newPassword">
                    <el-input v-model="passwordForm.newPassword" type="password" placeholder="请输入新密码" show-password />
                  </el-form-item>

                  <el-form-item label="确认密码" prop="confirmPassword">
                    <el-input v-model="passwordForm.confirmPassword" type="password" placeholder="请再次输入新密码" show-password />
                  </el-form-item>

                  <el-form-item>
                    <el-button type="primary" @click="handleUpdatePassword" :loading="passwordLoading">修改密码</el-button>
                  </el-form-item>
                </el-form>
              </div>
            </div>

            <!-- 我的话题 -->
            <ContentList 
              v-if="activeTab === 'topics'"
              :title="'我的话题'"
              :items="myTopics"
              :loading="loadingTopics"
              type="topic"
              :empty-text="'暂无话题'"
              :total="topicsTotal"
              :current-page="topicsPage"
              :page-size="topicsPageSize"
              @page-change="handleTopicsPageChange"
            />

            <!-- 我喜欢的话题 -->
            <ContentList 
              v-if="activeTab === 'favorites'"
              :title="'我喜欢的话题'"
              :items="myFavorites"
              :loading="loadingFavorites"
              type="topic-like"
              :empty-text="'暂无喜欢'"
              :total="favoritesTotal"
              :current-page="favoritesPage"
              :page-size="favoritesPageSize"
              @page-change="handleFavoritesPageChange"
            />

            <!-- 我的问答 -->
            <ContentList 
              v-if="activeTab === 'questions'"
              :title="'我的问答'"
              :items="myQuestions"
              :loading="loadingQuestions"
              type="question"
              :empty-text="'暂无问答'"
              :total="questionsTotal"
              :current-page="questionsPage"
              :page-size="questionsPageSize"
              @page-change="handleQuestionsPageChange"
            />

            <!-- 我喜欢的问答 -->
            <ContentList 
              v-if="activeTab === 'question-likes'"
              :title="'我喜欢的问答'"
              :items="myQuestionLikes"
              :loading="loadingQuestionLikes"
              type="question-like"
              :empty-text="'暂无喜欢的问答'"
              :total="questionLikesTotal"
              :current-page="questionLikesPage"
              :page-size="questionLikesPageSize"
              @page-change="handleQuestionLikesPageChange"
            />
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import { aesCbcEncrypt } from '../../utils/crypto'
import { getUserInfo, updateUserApi, updatePWD, UpdateWebUserAvatar } from '../../api/user'
import { saveGoodsPic } from '../../api/files'
import { getAvatarUrl } from '../../utils/helpers'
import { getMyTopics, getMyLikes } from '../../api/topics'
import { getMyQuestions, getMyQuestionLikes } from '../../api/questions'
import ContentList from '../../components/ContentList.vue'

const editFormRef = ref<FormInstance>();
const passwordFormRef = ref<FormInstance>();
const loading = ref(false);
const passwordLoading = ref(false);
const loadingTopics = ref(false);
const loadingFavorites = ref(false);
const activeTab = ref('profile');

// 点击标签时加载对应数据
const handleTabClick = (tab: string) => {
  activeTab.value = tab;
  switch (tab) {
    case 'topics':
      if (myTopics.value.length === 0) {
        loadMyTopics();
      }
      break;
    case 'questions':
      if (myQuestions.value.length === 0) {
        loadMyQuestions();
      }
      break;
    case 'favorites':
      if (myFavorites.value.length === 0) {
        loadMyFavorites();
      }
      break;
    case 'question-likes':
      if (myQuestionLikes.value.length === 0) {
        loadMyQuestionLikes();
      }
      break;
  }
};

const userInfo = ref<any>({
  id: '',
  uName: '',
  uPhone: '',
  uOccupation: '',
  uAvatar: ''
});

const editForm = reactive({
  username: '',
  phone: '',
  profession: ''
});

const passwordForm = reactive({
  oldPassword: '',
  newPassword: '',
  confirmPassword: ''
});

const myTopics = ref<any[]>([]);
const myFavorites = ref<any[]>([]);
const myQuestions = ref<any[]>([]);
const myQuestionLikes = ref<any[]>([]);
const loadingQuestions = ref(false);
const loadingQuestionLikes = ref(false);

const topicsTotal = ref(0);
const favoritesTotal = ref(0);
const questionsTotal = ref(0);
const questionLikesTotal = ref(0);

const topicsPage = ref(1);
const favoritesPage = ref(1);
const questionsPage = ref(1);
const questionLikesPage = ref(1);

const topicsPageSize = ref(2);
const favoritesPageSize = ref(2);
const questionsPageSize = ref(2);
const questionLikesPageSize = ref(2);

// 获取基础图片文件夹路径
const baseImgFolder = 'WebSiteAvatars'

// 计算头像完整URL
const avatarUrl = computed(() => {
  return getAvatarUrl(userInfo.value.uAvatar)
})

const editRules = reactive<FormRules>({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
  ],
  profession: [
    { max: 50, message: '职业长度不能超过 50 个字符', trigger: 'blur' }
  ]
});

const passwordRules = reactive<FormRules>({
  oldPassword: [
    { required: true, message: '请输入原密码', trigger: 'blur' }
  ],
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { 
      validator: (_rule, value, callback) => {
        if (value !== passwordForm.newPassword) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      }, 
      trigger: 'blur' 
    }
  ]
});

// 加载用户信息
const loadUserInfo = async () => {
  try {
    const storedUserInfo = localStorage.getItem('userInfo');
    if (storedUserInfo) {
      const parsedInfo = JSON.parse(storedUserInfo);
      userInfo.value.id = parsedInfo.id || '';
      
      // 调用接口获取最新用户信息
      if (userInfo.value.id) {
        const response = await getUserInfo({ id: userInfo.value.id });
        console.log("response:",response);
        if (response.sign === '1' && response.data[0]) {
          userInfo.value = { ...userInfo.value, ...response.data[0] };
        }
      }
      
      editForm.username = userInfo.value.uName || '';
      editForm.phone = userInfo.value.uPhone || '';
      editForm.profession = userInfo.value.uOccupation || '';
    }
  } catch (error) {
    console.error('加载用户信息失败:', error);
  }
};

// 上传头像前的处理
const beforeUploadAvatar = (file: any) => {
  // 验证文件类型和大小
  const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/jpg'
  const isLt2M = file.size / 1024 / 1024 < 2
  
  if (!isJPG) {
    ElMessage.error('只能上传 JPG/PNG 格式的图片')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('图片大小不能超过 2MB')
    return false
  }
  
  // 使用FileReader将图片转换为base64
  const reader = new FileReader()
  reader.onload = async (e) => {
    const base64Image = (e.target?.result as string) || ''
    
    try {
      // 调用上传接口
      const request = {
        fileName: `${baseImgFolder}/${Date.now().toString()}_avatar`,
        base64Str: base64Image
      }
      console.log("request:",request)
      const response = await saveGoodsPic(request)
      console.log("response:",response)
      
      if (response.code === '0' || response.sign === '1') {
        const imagePath = response.data || ''
        
        // 更新用户头像（保存相对路径）
        const updateResponse = await UpdateWebUserAvatar({
          id: userInfo.value.id,
          uAvatar: imagePath
        })
        
        if (updateResponse.sign === '1') {
          userInfo.value.uAvatar = imagePath
          localStorage.setItem('userInfo', JSON.stringify(userInfo.value))
          ElMessage.success('头像上传成功')
        } else {
          ElMessage.error(updateResponse.msg || '头像更新失败')
        }
      } else {
        ElMessage.error(response.msg || '图片上传失败')
      }
    } catch (error) {
      console.error('上传头像失败:', error)
      ElMessage.error('头像上传失败，请稍后重试')
    }
  }
  reader.readAsDataURL(file)
  return false // 阻止默认上传行为
}

const handleSaveInfo = async () => {
  if (!editFormRef.value) return;
  try {
    await editFormRef.value.validate();
    loading.value = true;

    const params = {
      id: userInfo.value.id,
      uName: editForm.username,
      uPhone: editForm.phone,
      uOccupation: editForm.profession
    };

    const response = await updateUserApi(params);
    
    if (response.sign === '1') {
      ElMessage.success('保存成功！');
      userInfo.value.uName = editForm.username;
      userInfo.value.uPhone = editForm.phone;
      userInfo.value.uOccupation = editForm.profession;
      localStorage.setItem('userInfo', JSON.stringify(userInfo.value));
    } else {
      ElMessage.error(response.msg || '保存失败，请稍后重试');
    }
    loading.value = false;
  } catch (error) {
    console.error('保存资料失败:', error);
    ElMessage.error('保存失败，请稍后重试');
    loading.value = false;
  }
};

const handleUpdatePassword = async () => {
  if (!passwordFormRef.value) return;
  try {
    await passwordFormRef.value.validate();
    passwordLoading.value = true;

    const encryptedOldPassword = aesCbcEncrypt(passwordForm.oldPassword);
    const encryptedNewPassword = aesCbcEncrypt(passwordForm.newPassword);

    const params = {
      id: userInfo.value.id,
      oldUPasswords: encryptedOldPassword,
      uPasswords: encryptedNewPassword
    };

    const response = await updatePWD(params);
    
    if (response.sign === '1') {
      ElMessage.success('密码修改成功！');
      passwordForm.oldPassword = '';
      passwordForm.newPassword = '';
      passwordForm.confirmPassword = '';
      passwordFormRef.value?.resetFields();
    } else {
      ElMessage.error(response.msg || '密码修改失败，请稍后重试');
    }
    passwordLoading.value = false;
  } catch (error) {
    console.error('修改密码失败:', error);
    ElMessage.error('修改密码失败，请稍后重试');
    passwordLoading.value = false;
  }
};

const loadMyTopics = async () => {
  try {
    loadingTopics.value = true;
    const params = {
      uId: userInfo.value.id,
      pageNumber: topicsPage.value,
      pageSize: topicsPageSize.value
    }
    console.log("loadMyTopics params:",params)
    const response = await getMyTopics(params);
    console.log("loadMyTopics response:",response)
    
    if (response.sign === '1' && response.data) {
      myTopics.value = response.data.lists || [];
      topicsTotal.value = response.data.total || 0;
    }
    loadingTopics.value = false;
  } catch (error) {
    console.error('加载话题失败:', error);
    loadingTopics.value = false;
  }
};

const loadMyFavorites = async () => {
  try {
    loadingFavorites.value = true;
    const response = await getMyLikes({
      uId: userInfo.value.id,
      pageNumber: favoritesPage.value,
      pageSize: favoritesPageSize.value
    });
    console.log("responselikes:",response)
    if (response.sign === '1' && response.data) {
      myFavorites.value = response.data.lists || [];
      favoritesTotal.value = response.data.total || 0;
    }
    loadingFavorites.value = false;
  } catch (error) {
    console.error('加载喜欢失败:', error);
    loadingFavorites.value = false;
  }
};

const loadMyQuestions = async () => {
  try {
    loadingQuestions.value = true;
    const params = {
      uid: userInfo.value.id,
      pageNumber: questionsPage.value,
      pageSize: questionsPageSize.value
    }
    const response = await getMyQuestions(params);
    console.log("response questions:", response)
    if (response.sign === '1' && response.data) {
      myQuestions.value = response.data.lists || [];
      questionsTotal.value = response.data.total || 0;
    }
    loadingQuestions.value = false;
  } catch (error) {
    console.error('加载我的问答失败:', error);
    loadingQuestions.value = false;
  }
};

const loadMyQuestionLikes = async () => {
  try {
    loadingQuestionLikes.value = true;
    const params = {
      uid: userInfo.value.id,
      pageNumber: questionLikesPage.value,
      pageSize: questionLikesPageSize.value
    }
    const response = await getMyQuestionLikes(params);
    console.log("response question likes:", response)
    if (response.sign === '1' && response.data) {
      myQuestionLikes.value = response.data.lists || [];
      questionLikesTotal.value = response.data.total || 0;
    }
    loadingQuestionLikes.value = false;
  } catch (error) {
    console.error('加载我喜欢的问答失败:', error);
    loadingQuestionLikes.value = false;
  }
};

const handleTopicsPageChange = (page: number, size: number) => {
  topicsPage.value = page;
  topicsPageSize.value = size;
  loadMyTopics();
};

const handleFavoritesPageChange = (page: number, size: number) => {
  favoritesPage.value = page;
  favoritesPageSize.value = size;
  loadMyFavorites();
};

const handleQuestionsPageChange = (page: number, size: number) => {
  questionsPage.value = page;
  questionsPageSize.value = size;
  loadMyQuestions();
};

const handleQuestionLikesPageChange = (page: number, size: number) => {
  questionLikesPage.value = page;
  questionLikesPageSize.value = size;
  loadMyQuestionLikes();
};

onMounted(() => {
  loadUserInfo();
});
</script>

<style lang="scss" scoped>
.user-center {
  min-height: 100%;
}

.main-content {
  flex: 1;
  padding: 20px 0;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }
}

.user-center-layout {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 30px;
  align-items: start;

  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
}

.user-sidebar {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  padding: 30px 0;
  position: sticky;
  top: 20px;
  height: fit-content;

  .sidebar-header {
    padding: 0 30px 20px;
    border-bottom: 2px solid #f0f0f0;

    h2 {
      font-size: 20px;
      font-weight: bold;
      color: #333;
      margin: 0;
    }
  }

  .sidebar-nav {
    ul {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        display: flex;
        align-items: center;
        padding: 16px 30px;
        cursor: pointer;
        transition: all 0.3s ease;
        border-left: 3px solid transparent;

        &:hover {
          background-color: #f8f9fa;
        }

        &.active {
          background-color: #fff0f0;
          border-left-color: #ff6b6b;

          .nav-text {
            color: #ff6b6b;
            font-weight: 500;
          }
        }

        .nav-icon {
          font-size: 20px;
          margin-right: 12px;
        }

        .nav-text {
          font-size: 16px;
          color: #333;
          transition: color 0.3s ease;
        }
      }
    }
  }
}

.user-content {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.user-info-card {
  background-color: #fff;
  border-radius: 8px;
  padding: 30px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
  display: flex;
  gap: 30px;

  .avatar-section {
    flex-shrink: 0;

    .avatar-wrapper {
      position: relative;
      width: 120px;
      height: 120px;

      .avatar {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover;
      }

      .avatar-placeholder {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background-color: #ff6b6b;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 48px;
        font-weight: bold;
        color: white;
      }

      .avatar-upload {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        background-color: rgba(0, 0, 0, 0.6);
        color: white;
        padding: 8px;
        text-align: center;
        border-radius: 0 0 60px 60px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s ease;

        &:hover {
          background-color: rgba(0, 0, 0, 0.8);
        }

        :deep(.el-upload) {
          display: block;
          width: 100%;
          height: 100%;
        }
      }
    }
  }

  .info-section {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;

    .user-name {
      font-size: 28px;
      font-weight: bold;
      color: #333;
      margin-bottom: 10px;
    }

    .user-phone {
      font-size: 16px;
      color: #666;
      margin-bottom: 8px;
    }

    .user-profession {
      font-size: 16px;
      color: #666;
    }
  }
}

.edit-section {
background-color: #fff;
  border-radius: 8px;
  padding: 30px;
  margin: 20px 0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

  .section-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 2px solid #f0f0f0;
  }
}



.loading-state,
.empty-state {
  text-align: center;
  padding: 40px 20px;
  color: #999;
  font-size: 14px;
}



// 覆盖 Element Plus 输入框聚焦样式
:deep(.el-input__wrapper) {
  box-shadow: 0 0 0 1px #dcdfe6 inset;
  
  &.is-focus {
    box-shadow: 0 0 0 1px #ff6b6b inset;
  }
}

:deep(.el-input__inner:focus) {
  box-shadow: none;
}

@media (max-width: 768px) {
  .user-info-card {
    flex-direction: column;
    text-align: center;

    .avatar-wrapper {
      margin: 0 auto;
    }
  }

  .user-center-layout {
    gap: 20px;
  }

  .user-sidebar {
    position: relative;
    top: 0;
  }

  .user-content {
    gap: 20px;
  }

  .edit-section,
  .password-section {
    padding: 20px;
  }
}
</style>