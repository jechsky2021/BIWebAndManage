import axios, { AxiosInstance, AxiosResponse } from 'axios';
import { ElMessage } from 'element-plus';
import router from '../router';

// 标记是否正在跳转到登录页，防止重复跳转
let isRedirectingToLogin = false;

// 创建axios实例
const service: AxiosInstance = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api', // 使用环境变量中的API基础URL
  timeout: 10000, // 请求超时时间
  headers: {
    'Content-Type': 'application/json'
  }
});

// 请求拦截器
service.interceptors.request.use(
  (config: any): any => {
    // 可以在这里添加token等认证信息
    const token = localStorage.getItem('token');
   // console.log('token:', token)
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error): Promise<never> => {
    console.error('请求错误:', error);
    return Promise.reject(error);
  }
);

// 响应拦截器
service.interceptors.response.use(
  (response: AxiosResponse): any => {
    // 可以在这里统一处理响应数据
    return response.data;
  },
  (error): Promise<never> => {

    if (error.response && error.response.status === 401) {
      // 检查本地是否有token
      const token = localStorage.getItem('token');
      
      // 只有当本地有token（已登录）但收到401时才跳转到登录页
      if (token) {
        // 防止重复跳转
        if (!isRedirectingToLogin) {
          isRedirectingToLogin = true;
          ElMessage({ message: '会话已过期，请重新登录', type: 'warning' });
          localStorage.clear();
          router.push('/login').then(() => {
            // 跳转完成后重置标记
            setTimeout(() => {
              isRedirectingToLogin = false;
            }, 1000);
          });
        }
      }
      // 未登录时收到401不做任何处理，静默返回错误，让前端业务逻辑处理
      return Promise.reject(new Error('未授权'));
    }

    // 非401错误才显示错误消息
    ElMessage({ message: error.message || '网络错误', type: 'error' });

    // 可以在这里统一处理错误
    return Promise.reject(error);
  }
);


// 文件服务的API路径前缀
const FILES_BASE_PREFIX = '/v1.0/pictureServer' //'/pictureServer'

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
    if (localStorage.getItem('token')) {
      config.headers["x-auth-token"] = localStorage.getItem('token') || ''
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

    // 处理Session-Status头
    const sessionStatus = response.headers['Session-Status'] || response.headers['session-status']
    if (sessionStatus === 'timeout') {
      // 检查本地是否有token
      const token = localStorage.getItem('token');
      
      // 只有当本地有token（已登录）时才跳转到登录页
      if (token) {
        // 防止重复跳转
        if (!isRedirectingToLogin) {
          isRedirectingToLogin = true;
          ElMessage({ message: '会话已过期，请重新登录', type: 'warning' });
          localStorage.clear();
          router.push('/login').then(() => {
            setTimeout(() => {
              isRedirectingToLogin = false;
            }, 1000);
          });
        }
      }
      return Promise.reject(new Error('会话过期'));
    }

    return response.data
  },
  (error) => {
    ElMessage({ message: error.message || '网络错误', type: 'error' })
    return Promise.reject(error)
  }
)

// 图片服务基础URL
const pictureServerBaseUrl = `${(import.meta as any).env.VITE_FILE_SERVER_BASE_URL || 'https://www.hairpa.com'}${FILES_BASE_PREFIX}`

export default service
export { fileService, pictureServerBaseUrl }
