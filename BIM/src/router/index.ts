import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue'),
    meta: { title: '登录' }
  },
  {
    path: '/403',
    name: 'Forbidden',
    component: () => import('../views/403.vue'),
    meta: { title: '权限不足' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('../views/Register.vue'),
    meta: { title: '注册' }
  },
  {
    path: '/',
    name: 'Layout',
    component: () => import('../components/Layout.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('../views/Dashboard.vue'),
        meta: { title: '数据概览', requiresAuth: true }
      },
      {
        path: 'users',
        name: 'Users',
        component: () => import('../views/permission/Users.vue'),
        meta: { title: '用户管理', requiresAuth: true }
      },
      {
        path: 'roles',
        name: 'Roles',
        component: () => import('../views/permission/Roles.vue'),
        meta: { title: '角色权限管理', requiresAuth: true }
      },
      {
        path: 'menus',
        name: 'menus',
        component: () => import('../views/permission/menu.vue'),
        meta: { title: '菜单管理', requiresAuth: true }
      },
      {
        path: 'articles/list',
        name: 'ArticlesList',
        component: () => import('../views/articles/list.vue'),
        meta: { title: '文章管理', requiresAuth: true }
      },
      {
        path: 'articles/form',
        name: 'ArticlesForm',
        component: () => import('../views/articles/form.vue'),
        meta: { title: '新增文章', requiresAuth: true }
      },
      {
        path: 'articles/form/:id',
        name: 'ArticlesFormEdit',
        component: () => import('../views/articles/form.vue'),
        meta: { title: '编辑文章', requiresAuth: true }
      },
      {
        path: 'articleTypes/list',
        name: 'ArticleTypesList',
        component: () => import('../views/articleTypes/list.vue'),
        meta: { title: '分类管理', requiresAuth: true }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 导入用户状态管理
import { useUserStore } from '../stores'
// 导入权限工具函数
import { hasPermission } from '../utils/permission'

// 路由守卫
router.beforeEach((to, _from, next) => {
  // 设置页面标题
  if (to.meta.title) {
    document.title = `${to.meta.title} - 美业网站后台管理系统`
  } else {
    document.title = '美业网站后台管理系统'
  }

  // 权限验证
  const token = localStorage.getItem('token')
  
  // 如果路由需要认证
  if (to.meta.requiresAuth) {
    // 检查是否登录
    if (!token) {
      next('/login')
      return
    }
    
    // 检查是否有权限访问该路径
    // 排除登录、注册和403页面
    if (to.path !== '/login' && to.path !== '/register' && to.path !== '/403') {
      const userStore = useUserStore()
      const permissions = userStore.permissions
      
      if (permissions.length === 0) {
        // 菜单数据还没有加载完成，暂时允许访问
        // 后续会在Layout组件中重新加载菜单并更新权限
        next()
        return
      }
 
      if(!hasPermission(to.path,permissions)){
        next('/403')
        return
      }

    }
  }
  
  next()
})

export default router
