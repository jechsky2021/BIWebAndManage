import axios from '../utils/axios'

// 获取角色信息API
export const getRoleList = (params: any): Promise<any> => {
  return axios.post('/Role/GetByPage', params)
}

// 添加角色信息API
export const addRoleApi = (params: any): Promise<any> => {
  return axios.post('/Role/AddRole', params)
}

export const updateRoleApi = (params: any): Promise<any> => {
  return axios.post('/Role/UpdateRole', params)
}

// 删除角色信息API
export const deleteRoleInfo = (params: any): Promise<any> => {
  return axios.post('/Role/DeleteRoleById', params)
}

// 分配菜单权限API
export const addRoleMenuInfo = (params: any): Promise<any> => {
  return axios.post('/Role/AssignMenus', params)
}

// 添加角色菜单信息API
export const getMenuByRoleId = (params: any): Promise<any> => {
  return axios.post('/Role/GetMenuByRoleId', params)
}
