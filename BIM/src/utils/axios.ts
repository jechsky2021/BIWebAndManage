import axios from 'axios'
import { ElMessage } from 'element-plus'
import { useUserStore } from '../stores'

console.log('VITE_API_BASE_URL:', (import.meta as any).env.VITE_API_BASE_URL)
const service = axios.create({
  baseURL: `${(import.meta as any).env.VITE_API_BASE_URL || '/api'}`,
  timeout: 50000,
  headers: {
    'Content-Type': 'application/json;charset=utf-8'
  }
})

// 请求拦截器
service.interceptors.request.use(
  (config) => {
    const userStore = useUserStore()
    console.log('token:', userStore.token)
    if (userStore.token) {
      //config.headers["x-auth-token"] = userStore.token
      config.headers.Authorization = `Bearer ${userStore.token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 响应拦截器
service.interceptors.response.use(
  (response) => {
    console.log("respose:",response)
    if (response.code === 401) {
      ElMessage({ message: '会话过期，请重新登录', type: 'warning' })
      const userStore = useUserStore()
      userStore.logout()
      window.location.href = '/login'
      return Promise.reject(new Error('会话过期'))
    }

     return response.data
  },
  (error) => {
    ElMessage({ message: error.message || '网络错误', type: 'error' })
    return Promise.reject(error)
  }
)

// 文件服务的API路径前缀
const FILES_BASE_PREFIX = '/v1.0/pictureServer'

// 文件服务的基础URL
const FILE_SERVER_BASE_URL = (import.meta as any).env.VITE_FILE_SERVER_BASE_URL || 'https://www.hairpa.com'

// 文件服务的axios实例
const fileService = axios.create({
  baseURL: `${FILE_SERVER_BASE_URL}${FILES_BASE_PREFIX}`,
  timeout: 50000,
  headers: {
    'Content-Type': 'application/json;charset=utf-8'
  }
})

// 文件服务的请求拦截器
fileService.interceptors.request.use(
  (config) => {
    const userStore = useUserStore()
    if (userStore.token) {
      // config.headers["x-auth-token"] = userStore.token
      // config.headers.Authorization = `Bearer ${userStore.token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// 文件服务的响应拦截器
fileService.interceptors.response.use(
  (response) => {
     return response
  },
  (error) => {
    ElMessage({ message: error.message || '网络错误', type: 'error' })
    return Promise.reject(error)
  }
)

// 图片服务基础URL
const pictureServerBaseUrl = `${(import.meta as any).env.VITE_FILE_SERVER_BASE_URL || 'https://www.hairpa.com'}${FILES_BASE_PREFIX}`


export default service
export { fileService,pictureServerBaseUrl }
