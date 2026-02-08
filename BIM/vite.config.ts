import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 3000,
    open: true,
    proxy: {
      // 配置API代理
      '/api': {
        target: 'http://localhost:5247', //http://106.14.20.120', // 后端服务器地址 https://tevv37568542.vicp.fun
        changeOrigin: true, // 允许跨域
        rewrite: (path) => path.replace(/^\/api/, ''), // 移除/api前缀
        secure: false, // 忽略HTTPS证书验证（如果目标服务器使用HTTPS）
        timeout: 50000 // 增加代理超时时间
      }
    }
  }
})