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
        <form v-if="activeTab === 'login'" @submit.prevent="handleLogin">
          <div class="form-group">
            <label for="login-phone">手机号</label>
            <input 
              type="tel" 
              id="login-phone" 
              v-model="loginForm.phone"
              placeholder="请输入手机号"
              required
            />
          </div>
          
          <div class="form-group">
            <label for="login-password">密码</label>
            <input 
              type="password" 
              id="login-password" 
              v-model="loginForm.password"
              placeholder="请输入密码"
              required
            />
          </div>

          <div class="form-options">
            <label class="remember-me">
              <input type="checkbox" v-model="loginForm.remember" />
              记住登录状态
            </label>
            <a href="#" class="forgot-password">忘记密码？</a>
          </div>

          <button type="submit" class="submit-btn">登录</button>
        </form>

        <!-- 注册表单 -->
        <form v-else-if="activeTab === 'register'" @submit.prevent="handleRegister">
          <div class="form-group">
            <label for="register-phone">手机号</label>
            <input 
              type="tel" 
              id="register-phone" 
              v-model="registerForm.phone"
              placeholder="请输入手机号"
              required
            />
          </div>

          <div class="form-group">
            <label for="register-code">验证码</label>
            <div class="code-input">
              <input 
                type="text" 
                id="register-code" 
                v-model="registerForm.code"
                placeholder="请输入验证码"
                required
              />
              <button 
                type="button" 
                class="get-code-btn"
                :disabled="countdown > 0"
                @click="getCode"
              >
                {{ countdown > 0 ? `${countdown}秒后重试` : '获取验证码' }}
              </button>
            </div>
          </div>

          <div class="form-group">
            <label for="register-password">设置密码</label>
            <input 
              type="password" 
              id="register-password" 
              v-model="registerForm.password"
              placeholder="密码长度为6-20位，包含字母和数字"
              required
            />
          </div>

          <div class="form-agreement">
            <label>
              <input type="checkbox" v-model="registerForm.agreement" required />
              我已阅读并同意 <a href="#">用户协议</a> 和 <a href="#">隐私政策</a>
            </label>
          </div>

          <button type="submit" class="submit-btn">注册</button>
        </form>

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
import { ref } from 'vue';
import { useRouter } from 'vue-router';

interface LoginForm {
  phone: string;
  password: string;
  remember: boolean;
}

interface RegisterForm {
  phone: string;
  code: string;
  password: string;
  agreement: boolean;
}

const router = useRouter();
const activeTab = ref('login');
const countdown = ref(0);
const loginForm = ref<LoginForm>({
  phone: '',
  password: '',
  remember: false
});
const registerForm = ref<RegisterForm>({
  phone: '',
  code: '',
  password: '',
  agreement: false
});

const handleLogin = () => {
  // 模拟登录逻辑
  console.log('登录信息:', loginForm.value);
  alert('登录成功！');
  router.push('/');
};

const handleRegister = () => {
  // 模拟注册逻辑
  console.log('注册信息:', registerForm.value);
  alert('注册成功！');
  activeTab.value = 'login';
};

const getCode = () => {
  if (!validatePhone(registerForm.value.phone)) {
    alert('请输入正确的手机号');
    return;
  }
  
  // 模拟发送验证码
  console.log('发送验证码到:', registerForm.value.phone);
  
  // 开始倒计时
  countdown.value = 60;
  const timer = setInterval(() => {
    countdown.value--;
    if (countdown.value <= 0) {
      clearInterval(timer);
    }
  }, 1000);
};

const validatePhone = (phone: string): boolean => {
  const phoneRegex = /^1[3-9]\d{9}$/;
  return phoneRegex.test(phone);
};
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