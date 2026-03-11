<template>
  <div class="login-page">
    <div class="login-container">
      <div class="login-logo">
        <h1>美业资讯</h1>
        <p>专业的美业行业信息平台</p>
      </div>
      
      <div class="login-form">
        <div class="form-tabs">
          <button 
            :class="['tab', { active: activeTab === 'login' }]"
            @click="activeTab = 'login'"
          >
            登录
          </button>
          <button 
            :class="['tab', { active: activeTab === 'register' }]"
            @click="activeTab = 'register'"
          >
            注册
          </button>
        </div>

        <!-- 登录表单 -->
        <el-form 
          v-if="activeTab === 'login'" 
          :model="loginForm" 
          :rules="loginRules" 
          ref="loginFormRef"
          label-width="0"
          @submit.prevent="handleLogin"
        >
          <el-form-item prop="phone">
            <el-input 
              v-model="loginForm.phone"
              placeholder="请输入手机号"
              prefix-icon="Phone"
              size="large"
            />
          </el-form-item>
          
          <el-form-item prop="password">
            <el-input 
              v-model="loginForm.password"
              type="password"
              placeholder="请输入密码"
              prefix-icon="Lock"
              show-password
              size="large"
            />
          </el-form-item>

          <div class="form-options">
            <a href="#" class="forgot-password">忘记密码？</a>
          </div>

          <el-button 
            type="primary" 
            @click="handleLogin"
            :loading="loading"
            size="large"
            class="submit-btn"
            round
          >
            登录
          </el-button>
        </el-form>

        <!-- 注册表单 -->
        <el-form 
          v-else-if="activeTab === 'register'" 
          :model="registerForm" 
          :rules="registerRules" 
          ref="registerFormRef"
          label-width="0"
          @submit.prevent="handleRegister"
        >
          <el-form-item prop="phone">
            <el-input 
              v-model="registerForm.phone"
              placeholder="请输入手机号"
              prefix-icon="Phone"
              size="large"
            />
          </el-form-item>

          <el-form-item prop="password">
            <el-input 
              v-model="registerForm.password"
              type="password"
              placeholder="密码长度为6-20位"
              prefix-icon="Lock"
              show-password
              size="large"
            />
          </el-form-item>

          <el-form-item prop="agreement">
            <div class="form-agreement">
              <el-checkbox v-model="registerForm.agreement">
                我已阅读并同意 <a href="#">用户协议</a> 和 <a href="#">隐私政策</a>
              </el-checkbox>
            </div>
          </el-form-item>

          <el-button 
            type="primary" 
            @click="handleRegister"
            :loading="loading"
            size="large"
            class="submit-btn"
            round
          >
            注册
          </el-button>
        </el-form>

        <div class="login-other">
          <div class="other-title">
            <span>其他登录方式</span>
          </div>
          
          <div class="other-methods">
            <button class="method-btn" title="微信登录">
              <span class="wechat-icon">💚</span>
            </button>
            <button class="method-btn" title="QQ登录">
              <span class="qq-icon">💙</span>
            </button>
            <button class="method-btn" title="微博登录">
              <span class="weibo-icon">❤️</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import { aesCbcEncrypt } from '../utils/crypto'
import { register, login } from '../api/user'

const router = useRouter();
const activeTab = ref('login');
const registerFormRef = ref<FormInstance>();
const loginFormRef = ref<FormInstance>();
const loading = ref(false);

// const countdown = ref(0);
const loginForm = reactive({
  phone: '',
  password: ''
});

// 登录表单验证规则
const loginRules = reactive<FormRules>({
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ]
});

const registerForm = reactive({
  phone: '',
  code: '',
  password: '',
  agreement: false
});

// 注册表单验证规则
const registerRules = reactive<FormRules>({
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  agreement: [
    { 
      validator: (_rule: any, value: boolean, callback: (error?: string | Error) => void) => {
        if (!value) {
          callback(new Error('请同意用户协议和隐私政策'))
        } else {
          callback()
        }
      }, 
      trigger: 'change' 
    }
  ]
});

const handleLogin = async () => {
  if (!loginFormRef.value) return
  try {
    await loginFormRef.value.validate()
    loading.value = true
    
    // 使用CBC模式加密密码
    const encryptedPassword = aesCbcEncrypt(loginForm.password)

    const params = {
      uPhone: loginForm.phone,
      uPasswords: encryptedPassword
    }
    
    // 调用登录API
    // console.log("登录参数:", params)
    const response = await login(params)
   // console.log("登录响应:", response)
    
    if (response.sign === "1") {
      ElMessage.success('登录成功！')
      // 保存登录状态到本地存储
      localStorage.setItem('token', response.data?.token || '')
      localStorage.setItem('userInfo', JSON.stringify(response.data?.webUserInfo || {}))
      loading.value = false
      // 触发 localStorage 变化事件，通知 NavBar 更新
      window.dispatchEvent(new Event('storage'))
      router.push('/user-center')
    } else {
      ElMessage.error(response.msg || '登录失败，请检查账号密码')
      loading.value = false
    }
  } catch (error) {
    console.error('登录失败:', error)
    ElMessage.error('登录失败，请稍后重试')
    loading.value = false
  }
};

const handleRegister = async () => {
  if (!registerFormRef.value) return
  try {
    await registerFormRef.value.validate()
    loading.value = true
    
    // 使用封装的AES-ECB加密函数加密密码
    const encryptedPassword = aesCbcEncrypt(registerForm.password)
    
    // 准备注册请求参数
    const params = {
      uPhone: registerForm.phone,
      uPasswords: encryptedPassword // 发送加密后的密码
    }

    // 调用注册API
    // console.log("注册参数:", params)
    const response = await register(params);
    // console.log("注册响应:", response)
    
    if(response.sign === "1"){
      ElMessage.success('注册成功！')
      activeTab.value = 'login';
    }else{
      ElMessage.error(response.msg || '注册失败，请稍后重试')
    }
    loading.value = false
  } catch (error: any) {
    console.error('注册失败:', error)
    ElMessage.error(error.message || '注册失败，请稍后重试')
    loading.value = false
  }
};

// const getCode = () => {
//   if (!validatePhone(registerForm.value.phone)) {
//     alert('请输入正确的手机号');
//     return;
//   }
  
//   // 模拟发送验证码
//   console.log('发送验证码到:', registerForm.value.phone);
  
//   // 开始倒计时
//   countdown.value = 60;
//   const timer = setInterval(() => {
//     countdown.value--;
//     if (countdown.value <= 0) {
//       clearInterval(timer);
//     }
//   }, 1000);
// };

// const validatePhone = (phone: string): boolean => {
//   const phoneRegex = /^1[3-9]\d{9}$/;
//   return phoneRegex.test(phone);
// };

</script>

<style lang="scss" scoped>
.login-page {
  min-height: 100vh;
  background-color: #f8f8f8;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
}

.login-container {
  background-color: #fff;
  border-radius: 12px;
  padding: 40px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 500px;
}

.login-logo {
  text-align: center;
  margin-bottom: 32px;

  h1 {
    font-size: 32px;
    color: #333;
    margin-bottom: 8px;
  }

  p {
    font-size: 16px;
    color: #999;
  }
}

.login-form {
  .form-tabs {
    display: flex;
    margin-bottom: 32px;
    border-bottom: 2px solid #f0f0f0;

    .tab {
      flex: 1;
      padding: 12px 0;
      border: none;
      background: none;
      font-size: 18px;
      color: #666;
      cursor: pointer;
      transition: all 0.3s ease;
      position: relative;

      &:hover {
        color: #ff6b6b;
      }

      &.active {
        color: #ff6b6b;
        font-weight: 500;
      }

      &.active::after {
        content: '';
        position: absolute;
        bottom: -2px;
        left: 0;
        width: 100%;
        height: 3px;
        background-color: #ff6b6b;
        border-radius: 2px;
      }
    }
  }

  form {
    .form-group {
      margin-bottom: 24px;

      label {
        display: block;
        margin-bottom: 8px;
        font-size: 16px;
        color: #333;
        font-weight: 500;
      }

      input {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        font-size: 16px;
        transition: all 0.3s ease;

        &:focus {
          outline: none;
          border-color: #ff6b6b;
          box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
        }

        &::placeholder {
          color: #999;
        }
      }

      .code-input {
        display: flex;
        gap: 12px;

        input {
          flex: 1;
        }

        .get-code-btn {
          padding: 12px 20px;
          background-color: #fff;
          border: 1px solid #ff6b6b;
          color: #ff6b6b;
          border-radius: 8px;
          font-size: 16px;
          cursor: pointer;
          transition: all 0.3s ease;
          white-space: nowrap;

          &:hover:not(:disabled) {
            background-color: #ff6b6b;
            color: #fff;
          }

          &:disabled {
            opacity: 0.6;
            cursor: not-allowed;
          }
        }
      }
    }

    .form-options {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;

      .remember-me {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #666;
        cursor: pointer;

        input[type="checkbox"] {
          width: auto;
          margin: 0;
        }
      }

      .forgot-password {
        font-size: 14px;
        color: #ff6b6b;
        text-decoration: none;
        transition: opacity 0.2s ease;

        &:hover {
          opacity: 0.8;
        }
      }
    }

    .form-agreement {
      margin-bottom: 24px;
      font-size: 14px;
      color: #666;

      input[type="checkbox"] {
        width: auto;
        margin-right: 8px;
      }

      a {
        color: #ff6b6b;
        text-decoration: none;

        &:hover {
          text-decoration: underline;
        }
      }
    }

    .submit-btn {
      width: 100%;
      padding: 14px;
      background-color: #ff6b6b;
      color: #fff;
      border: none;
      border-radius: 8px;
      font-size: 18px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        background-color: #ff5252;
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
      }

      &:active {
        transform: translateY(0);
      }
    }
  }

  :deep(.el-input__wrapper) {
  box-shadow: 0 0 0 1px #dcdfe6 inset;
  
  &.is-focus {
    box-shadow: 0 0 0 1px #ff6b6b inset;
  }
}

:deep(.el-input__inner:focus) {
  box-shadow: none;
}

.login-other {
    margin-top: 32px;

    .other-title {
      display: flex;
      align-items: center;
      margin-bottom: 24px;

      &::before,
      &::after {
        content: '';
        flex: 1;
        height: 1px;
        background-color: #f0f0f0;
      }

      span {
        padding: 0 20px;
        color: #999;
        font-size: 14px;
      }
    }

    .other-methods {
      display: flex;
      justify-content: center;
      gap: 32px;

      .method-btn {
        width: 50px;
        height: 50px;
        border: 1px solid #e0e0e0;
        background-color: #fff;
        border-radius: 50%;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;

        &:hover {
          transform: translateY(-3px);
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        span {
          font-size: 24px;
        }
      }
    }
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .login-container {
    padding: 24px;
    margin: 10px;
  }

  .login-logo h1 {
    font-size: 24px;
  }

  .form-tabs .tab {
    font-size: 16px;
  }

  .other-methods {
    gap: 24px;

    .method-btn {
      width: 44px;
      height: 44px;

      span {
        font-size: 20px;
      }
    }
  }
}
</style>