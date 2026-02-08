<template>
  <div class="error-container">
    <div class="error-content">
      <h1 class="error-code">403</h1>
      <h2 class="error-message">权限不足</h2>
      <p class="error-description">
        您没有访问该页面的权限，请联系管理员获取相应权限。
      </p>
      <el-button type="primary" @click="goHome">返回首页</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/index'

const router = useRouter()

const goHome = () => {
  const userStore = useUserStore()
  const permissions = userStore.permissions
  console.log('权限列表:', permissions)
  router.push(`${permissions[0]}`)
}
</script>

<style scoped>
.error-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #f5f7fa;
}

.error-content {
  text-align: center;
  padding: 40px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.error-code {
  font-size: 120px;
  font-weight: bold;
  color: #f56c6c;
  margin: 0;
}

.error-message {
  font-size: 24px;
  color: #303133;
  margin: 20px 0;
}

.error-description {
  font-size: 16px;
  color: #606266;
  margin: 0 0 30px;
}
</style>