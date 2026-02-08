<template>
  <div class="register-container">
    <div class="register-form-wrapper">
      <div class="register-header">
        <h1 class="register-title">小程序后台管理</h1>
        <p class="register-subtitle">创建新账户</p>
      </div>
      <el-form :model="registerForm" :rules="registerRules" ref="registerFormRef" label-width="0">
        <el-form-item prop="userName">
          <el-input
            v-model="registerForm.userName"
            placeholder="名称"
            prefix-icon="User"
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="loginCode">
          <el-input
            v-model="registerForm.loginCode"
            placeholder="登录账号"
            prefix-icon="User"
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="wechatCode">
          <el-input
            v-model="registerForm.wechatCode"
            placeholder="租户code"
            prefix-icon="User"
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="phone">
          <el-input
            v-model="registerForm.phone"
            placeholder="手机号"
            prefix-icon="Phone"
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            v-model="registerForm.password"
            type="password"
            placeholder="密码"
            prefix-icon="Lock"
            show-password
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input
            v-model="registerForm.confirmPassword"
            type="password"
            placeholder="确认密码"
            prefix-icon="Lock"
            show-password
            size="large"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button
            type="primary"
            @click="handleRegister"
            :loading="loading"
            size="large"
            class="register-btn"
            round
          >
            注册
          </el-button>
        </el-form-item>
        <div class="login-link">
          <span>已有账户？</span>
          <el-button link @click="goToLogin">立即登录</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import { aesEncrypt } from '../utils/crypto'
import { register } from '../api/user'

const router = useRouter()
const registerFormRef = ref<FormInstance>()
const loading = ref(false)

const registerForm = reactive({
  userName: '',
  loginCode: '',
  phone: '',
  password: '',
  confirmPassword: '',
  wechatCode: ''
})

const registerRules = reactive<FormRules>({
  userName: [
    { required: true, message: '请输入名称', trigger: 'blur' },
    { min: 3, max: 20, message: '名称长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  loginCode: [
    { required: true, message: '请输入登录账号', trigger: 'blur' },
    { min: 3, max: 20, message: '登录账号长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  wechatCode: [
    { required: true, message: '请输入租户code', trigger: 'blur' },
    { pattern: /^[a-zA-Z0-9]+$/, message: '租户code只能包含数字或英文', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 30, message: '密码长度在 6 到 30 个字符', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认密码', trigger: 'blur' },
    { validator: (_rule, value, callback) => {
        if (value !== registerForm.password) {
          callback(new Error('两次输入的密码不一致'))
        } else {
          callback()
        }
      }, trigger: 'blur' }
  ]
})

const handleRegister = async () => {
  if (!registerFormRef.value) return
  try {
    await registerFormRef.value.validate()
    loading.value = true
    
    // 使用封装的AES-ECB加密函数加密密码
    const encryptedPassword = aesEncrypt(registerForm.password)
    
    // 准备注册请求参数
    const params: any = {
      ...registerForm,
      password: encryptedPassword // 发送加密后的密码
    }
    
    // 删除不需要的字段
    delete params.confirmPassword

    // 调用注册API
    const response = await register(params);
    
    if(response.code === "0"){
      ElMessage.success('注册成功！')
    }else{
      ElMessage.error(response.message || '注册失败，请稍后重试')
    }
    loading.value = false
    router.push('/login')
  } catch (error: any) {
    console.error('注册失败:', error)
    ElMessage.error(error.message || '注册失败，请稍后重试')
    loading.value = false
  }
}

const goToLogin = () => {
  router.push('/login')
}
</script>

<style scoped>
.register-container {
  width: 100%;
  height: 100vh;
  background-color: #f5f7fa;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.register-form-wrapper {
  width: 100%;
  max-width: 450px;
  background-color: #fff;
  border-radius: 8px;
  padding: 40px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.09);
  border: 1px solid #e8e8e8;
}

.register-header {
  text-align: center;
  margin-bottom: 30px;
}

.register-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  margin-bottom: 8px;
}

.register-subtitle {
  font-size: 14px;
  color: #666;
}

.register-btn {
  width: 100%;
  height: 48px;
  font-size: 16px;
  font-weight: 600;
  background-color: #409EFF;
}

.login-link {
  text-align: center;
  margin-top: 20px;
  font-size: 14px;
  color: #666;
}

.login-link span {
  margin-right: 8px;
}

/* 响应式设计 */
@media (max-width: 576px) {
  .register-form-wrapper {
    padding: 30px 20px;
  }
  
  .register-title {
    font-size: 24px;
  }
}
</style>