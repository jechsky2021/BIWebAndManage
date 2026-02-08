import axios from '../utils/axios'

// 菜单数据结构接口
export interface MenuItem {
  id: string | number
  mName: string
  mParentId: number | null |string
  mRoute?: string
  mIcon?: string
  mSort: number
  children?: MenuItem[]
}

// 获取菜单列表API
export const getMenuList = (): Promise<MenuItem[]> => {
  return axios.post('/menu/GetMenuByUid').then(response => {
    if (Array.isArray(response)) {
      return response
    } else  {
      // 如果响应是对象且包含data字段，检查data是否为数组
      if (response && typeof response === 'object' && 'data' in response) {
        return Array.isArray(response.data) ? response.data : []
      }
      return []
    }
    return []
  })
}

// 将扁平菜单数据转换为树形结构
export const convertToTree = (menuList: MenuItem[]): MenuItem[] => {
  // 确保输入是数组
  if (!Array.isArray(menuList)) {
    return []
  }
  
  const tree: MenuItem[] = []
  const map: Map<string, MenuItem> = new Map() // 只接受字符串类型的键

  // 构建ID到菜单的映射
  menuList.forEach(menu => {
    const id = String(menu.id) // 确保键是字符串类型
    // 确保每个节点都有children数组
    map.set(id, { ...menu, id, children: menu.children || [] })
  })

  // 构建树形结构
  menuList.forEach(menu => {
    const id = String(menu.id) // 确保键是字符串类型
    // 统一处理父ID，转换为字符串进行比较
    const fatherId = menu.mParentId === null ? null : String(menu.mParentId)
    
    if (fatherId === null || fatherId === "0"|| fatherId === "null") {
      // 根节点
      tree.push(map.get(id)!)
    } else {
      // 子节点
      const parent = map.get(fatherId)
      const currentMenu = map.get(id)
      
      if (parent && currentMenu) {
        // 确保父节点有children数组
        if (!parent.children) {
          parent.children = []
        }
        // 检查是否已存在相同ID的子节点，避免重复添加
        const alreadyExists = parent.children.some(child => String(child.id) === id)
        if (!alreadyExists) {
          parent.children.push(currentMenu)
        }
      } else if (!parent) {
        // 父节点不存在时添加调试日志
        console.log(`Parent not found for menu ${id} with fatherId ${fatherId}`)
      }
    }
  })

  return tree
}


// 获取菜单管理列表信息API
export const getAllMenus = (params: any): Promise<any> => {
  return axios.post('/menu/GetMenuAll', params)
}

// 保存菜单信息API
export const addMenuApi = (params: any): Promise<any> => {
  return axios.post('/menu/AddMenu', params)
}

// 保存菜单信息API
export const updateMenuApi = (params: any): Promise<any> => {
  return axios.post('/menu/UpdateMenu', params)
}

// 删除菜单信息API
export const deleteMenuInfo = (params: any): Promise<any> => {
  return axios.post('/menu/DeleteMenuById', params)
}

