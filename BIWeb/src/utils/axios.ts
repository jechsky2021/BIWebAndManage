import axios, { AxiosInstance, AxiosResponse } from 'axios';

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
    console.error('响应错误:', error);
    // 可以在这里统一处理错误
    return Promise.reject(error);
  }
);

export default service;