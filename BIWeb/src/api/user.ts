import axios from '../utils/axios'

// 注册API
export const register = (params: any): Promise<any> => {
  return axios.post('/WebUser/AddUser', params)
}

// 登录API
export const login = (params: any): Promise<any> => {
  return axios.post('/auth/login', params)
}

// 修改密码
export const updatePWD = (params: any): Promise<any> => {
  return axios.post('/WebUser/UpdateWebUserPWD', params)
}

// 获取用户信息API
export const getUserInfo = (params: any): Promise<any> => {
  return axios.post('/WebUser/GetUserById', params)
}

export const updateUserApi = (params: any): Promise<any> => {
  return axios.post('/WebUser/UpdateWebUser', params)
}

export const UpdateWebUserAvatar = (params: any): Promise<any> => {
  return axios.post('/WebUser/UpdateWebUserAvatar', params)
}

