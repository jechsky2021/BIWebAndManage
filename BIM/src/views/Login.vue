<template>
  <div class="login-container">
    <div class="login-form-wrapper">
      <div class="login-header">
        <h1 class="login-title">美业网站后台管理</h1>
        <p class="login-subtitle">欢迎回来，请登录</p>
      </div>
      <el-form :model="loginForm" :rules="loginRules" ref="loginFormRef" label-width="0">
        <el-form-item prop="uName">
          <el-input
            v-model="loginForm.uName"
            placeholder="用户名"
            prefix-icon="User"
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="uPasswords">
          <el-input
            v-model="loginForm.uPasswords"
            type="password"
            placeholder="密码"
            prefix-icon="Lock"
            show-Passwords
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button
            type="primary"
            @click="handleLogin"
            :loading="loading"
            size="large"
            class="login-btn"
            round
          >
            登录
          </el-button>
        </el-form-item>
        <div class="register-link">
          <span>还没有账户？</span>
          <el-button link @click="goToRegister">立即注册</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores'
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus'
import { aesCbcEncrypt } from '../utils/crypto'
import { login } from '../api/user'
import { getMenuList } from '../api/menu'
import { extractPermissions, getFirstAccessiblePath } from '../utils/permission'

const router = useRouter()
const userStore = useUserStore()
const loginFormRef = ref<FormInstance>()
const loading = ref(false)

const loginForm = reactive({
  uName: '',
  uPasswords: ''
})

const loginRules = reactive<FormRules>({
  uName: [
    { required: true, message: '请输入用户名', trigger: 'blur' }
  ],
  uPasswords: [
    { required: true, message: '请输入密码', trigger: 'blur' }
  ]
})

const handleLogin = async () => {
  if (!loginFormRef.value) return
  try {
    await loginFormRef.value.validate()
    loading.value = true
    
    // 对uName和密码进行加密，但不修改原始表单字段
    const encrypteduPasswords = aesCbcEncrypt(loginForm.uPasswords)

    const params = {
      uName: loginForm.uName,
      uPasswords: encrypteduPasswords
    }
    // 调用登录API
    console.log("登录参数:", params)
    const response = await login(params)
    console.log("登录响应:", response)
    
    if (response.sign === "1") {
      userStore.setToken(response.data.token || '')
      userStore.setUserInfo({
        uid: response.data.userInfo.id || '',
        username: response.data.userInfo.uName || '',
        userphone: response.data.userInfo.uPhone || ''
      })
      
      // 获取菜单列表并提取权限路由
      try {
        const menuList = await getMenuList()
        console.log('获取到的菜单列表:', menuList)
        
        // 从菜单中提取所有有效的路由路径作为权限
        const permissions = extractPermissions(menuList)
        console.log('提取的权限列表:', permissions)
        
        // 设置权限到store
        userStore.setPermissions(permissions)
        
        // 找到第一个可访问的路由路径
        const firstAccessiblePath = getFirstAccessiblePath(permissions)
        console.log('第一个可访问路径:', firstAccessiblePath)
        
        loading.value = false
        router.push(firstAccessiblePath)
      } catch (error) {
        console.error('获取菜单权限失败:', error)
        loading.value = false
        ElMessage.error('获取权限失败，请重试')
      }
    }
    else {
      ElMessage.error(`登录失败: ${response.msg || '未知错误'}`)
      loading.value = false
      return
    }

  } catch (error) {
    console.error('登录失败:', error)
    loading.value = false
  }
}

// 跳转到注册页面
const goToRegister = () => {
  router.push('/register')
}
</script>

<style scoped>
.login-container {
  width: 100%;
  height: 100vh;
  background-color: #f5f7fa;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.login-form-wrapper {
  width: 100%;
  max-width: 450px;
  background-color: #fff;
  border-radius: 8px;
  padding: 40px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.09);
  border: 1px solid #e8e8e8;
}

.login-header {
  text-align: center;
  margin-bottom: 30px;
}

.login-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 8px;
}

.login-subtitle {
  font-size: 14px;
  color: #666;
}

.login-btn {
  width: 100%;
  height: 48px;
  font-size: 16px;
  font-weight: 600;
  background-color: #409EFF;
}

.register-link {
  text-align: center;
  margin-top: 20px;
  font-size: 14px;
  color: #666;
}

.register-link span {
  margin-right: 8px;
}

/* 响应式设计 */
@media (max-width: 576px) {
  .login-form-wrapper {
    padding: 30px 20px;
  }
  
  .login-title {
    font-size: 24px;
  }
}
</style>
