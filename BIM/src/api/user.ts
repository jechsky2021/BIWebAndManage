import axios from '../utils/axios'

// 注册API
export const register = (params: any): Promise<any> => {
  return axios.post('/user/userRegister', params)
}

// 登录API
export const login = (params: any): Promise<any> => {
  return axios.post('/auth/login', params)
}

// 修改密码
export const updatePWD = (params: any): Promise<any> => {
  return axios.post('/user/UpdatePWD', params)
}

// 获取用户信息API
export const getUserInfo = (params: any): Promise<any> => {
  return axios.post('/user/GetByPage', params)
}

// 添加用户信息API
export const addUserApi = (params: any): Promise<any> => {
  return axios.post('/user/AddUser', params)
}

export const updateUserApi = (params: any): Promise<any> => {
  return axios.post('/user/UpdateUser', params)
}

// 选择用户角色API
export const selectUserRole = (params: any): Promise<any> => {
  return axios.post('/user/GetRolesByUid', params)
}

// 添加用户角色API
export const addUserRole = (params: any): Promise<any> => {
  return axios.post('/user/AssignRoleIds', params)
}

