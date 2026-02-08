// 从菜单列表中提取权限路由的公共方法

export interface MenuItem {
  id: string | number
  mName: string
  mParentId: number | null |string
  mRoute?: string
  mIcon?: string
  mSort: number
  children?: MenuItem[]
}

/**
 * 从菜单列表中提取所有有效的路由路径作为权限
 * @param menus 菜单列表
 * @returns 权限列表（路由路径数组）
 */
export const extractPermissions = (menus: MenuItem[]): string[] => {
  let permissions: string[] = []
  menus.forEach(menu => {
    if (menu.mRoute ) {
      permissions.push(menu.mRoute)
    }
    if (menu.children && menu.children.length > 0) {
      permissions = permissions.concat(extractPermissions(menu.children))
    }
  })
  return permissions
}

/**
 * 检查用户是否有权限访问指定路径
 * @param path 要检查的路径
 * @param permissions 用户权限列表
 * @returns 是否有权限
 */
export const hasPermission = (path: string, permissions: string[]): boolean => {
  // 首页默认允许访问
  if (path === '/') return true
  
  // 2. 然后尝试路径模式匹配（支持动态路由）
  for (const permission of permissions) {
    console.log('检查模式:', permission)
    if (matchPathPattern(permission, path)) {
      return true
    }
  }

  //  // 1. 首先尝试精确匹配
  // if (permissions.includes(path)) {
  //   return true
  // }
  
  return false
}

/**
 * 路径模式匹配（支持动态路由和父路径匹配）
 * @param pattern 路径模式（如 /articles/form 或 /articles/form/:id）
 * @param path 实际路径（如 /articles/form/5）
 * @returns 是否匹配
 */
const matchPathPattern = (pattern: string, path: string): boolean => {
  // 1. 精确匹配
  if (pattern === path) {
    return true
  }
  
  // 2. 父路径匹配：如果模式是实际路径的前缀，且模式是完整的路径段
  const normalizedPattern = pattern.endsWith('/') ? pattern : pattern + '/'
  if (path.startsWith(normalizedPattern)) {
    return true
  }
  
  // 3. 动态路由匹配
  if (pattern.includes(':')) {
    // 将路径模式转换为正则表达式
    // 例如：/articles/form/:id 转换为 /^\/articles\/form\/[^\/]+$
    const regexPattern = pattern
      .replace(/\//g, '\\/')  // 转义斜杠
      .replace(/:\w+/g, '[^\\/]+')  // 替换动态参数为正则表达式
    
    const regex = new RegExp(`^${regexPattern} $`)
    return regex.test(path)
  }
  
  return false
}



/**
 * 获取第一个可访问的路由路径
 * @param permissions 用户权限列表
 * @returns 第一个可访问的路径
 */
export const getFirstAccessiblePath = (permissions: string[]): string => {
  return permissions.length > 0 ? permissions[0] : '/'
}