<template>
  <div class="users-container">
    <!-- 筛选条件 -->
    <el-card shadow="hover" class="filter-card">
      <div class="filter-header">
        <h3>用户管理</h3>
        <el-button type="primary" @click="addUser">
          <el-icon><Plus /></el-icon>
          新增用户
        </el-button>
      </div>
      <el-form :model="searchForm" inline>
        <el-form-item label="用户名">
          <el-input v-model="searchForm.uName" placeholder="请输入用户名" style="width: 200px" />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="searchForm.uPhone" placeholder="请输入手机号" style="width: 200px" />
        </el-form-item>
       
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 用户列表 -->
    <el-card shadow="hover" class="users-card">
      <div class="table-container">
        <el-table :data="usersList" stripe style="width: 100%">
          <el-table-column type="index" label="序号" width="80" />
          <el-table-column prop="uName" label="用户名" />
          <el-table-column prop="uPhone" label="手机号" />
          <el-table-column prop="createTime" label="创建时间" >
            <template #default="scope">
              <span v-if="scope.row.createTime">
                {{ dayjs(scope.row.createTime).format('YYYY-MM-DD HH:mm:ss') }}
              </span>
              <span v-else>--</span>
            </template>
          </el-table-column>
          <el-table-column label="操作" fixed="right" width="300">
            <template #default="scope">
              <el-button type="primary" size="small" @click="viewUser(scope.row)">查看</el-button>
              <el-button size="small" @click="editUser(scope.row)">编辑</el-button>
              <el-button size="small" @click="resetPassword(scope.row)">重置密码</el-button>
              <el-button size="small" @click="assignRoles(scope.row)">分配角色</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 新增/编辑用户对话框 -->
    <el-dialog
      v-model="addUserDialogVisible"
      :title="isEditMode ? '编辑用户' : '新增用户'"
      width="500px"
      destroy-on-close
    >
      <el-form
        ref="addUserFormRef"
        :model="addUserForm"
        :rules="addUserFormRules"
        label-width="100px"
      >
        <el-form-item label="用户名" prop="uName" required>
          <el-input v-model="addUserForm.uName" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="手机号" prop="uPhone" required>
          <el-input v-model="addUserForm.uPhone" placeholder="请输入手机号" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="cancelAddUser">取消</el-button>
          <el-button type="primary" @click="submitAddUser">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 重置密码对话框 -->
    <el-dialog
      v-model="resetPasswordDialogVisible"
      title="重置密码"
      width="400px"
      destroy-on-close
    >
      <el-form
        ref="resetPasswordFormRef"
        :model="resetPasswordForm"
        :rules="resetPasswordFormRules"
        label-width="80px"
      >
        <el-form-item label="新密码" prop="uPassword" required>
          <el-input v-model="resetPasswordForm.uPassword" type="password" placeholder="请输入新密码" autocomplete="new-password" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="cancelResetPassword">取消</el-button>
          <el-button type="primary" @click="submitResetPassword">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看用户详情对话框 -->
    <el-dialog
      v-model="viewUserDialogVisible"
      title="查看用户详情"
      width="500px"
      destroy-on-close
    >
      <div v-if="currentViewUser" class="user-details">
        <el-descriptions border :column="1" class="details-container">
          <el-descriptions-item label="用户名">{{ currentViewUser.uName || '-' }}</el-descriptions-item>
          <el-descriptions-item label="手机号">{{ currentViewUser.uPhone || '-' }}</el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ currentViewUser.createTime ? dayjs(currentViewUser.createTime).format('YYYY-MM-DD HH:mm:ss') : '-' }}</el-descriptions-item>
        </el-descriptions>
      </div>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="closeViewUser">关闭</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 分配角色对话框 -->
    <el-dialog
      v-model="roleDialogVisible"
      title="分配角色"
      width="400px"
      destroy-on-close
    >
      <el-tree
          ref="treeRef"
          :data="roleTree"
          show-checkbox
          node-key="id"
          default-expand-all
          :props="roleTreeProps"
          @check-change="handleCheckChange"
        />
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="cancelAssignRoles">取消</el-button>
          <el-button type="primary" @click="saveAssignRoles">保存</el-button>
        </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, nextTick } from 'vue'
import { ElMessage, FormInstance, FormItemRule } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { getUserInfo, addUserApi, updateUserApi, updatePWD,selectUserRole,addUserRole } from '../../api/user'
import {getRoleList} from '../../api/role'
import { aesCbcEncrypt } from '../../utils/crypto'
import dayjs from 'dayjs'
import { el } from 'element-plus/es/locales.mjs'

// 搜索表单
const searchForm = reactive({
  uName: '',
  uPhone: '',
})

// 用户列表数据
const usersList = ref([])

// 新增/编辑用户对话框
const addUserDialogVisible = ref(false)
const isEditMode = ref(false)

// 新增/编辑用户表单数据
const addUserForm = reactive({
  id: '',
  uName: '',
  uPhone: ''
})

// 表单实例引用
const addUserFormRef = ref<FormInstance>()

// 表单验证规则
const addUserFormRules = reactive<Record<string, Array<FormItemRule>>>({
  uName: [
    { required: true, message: '请输入名称', trigger: 'blur' },
    { min: 3, max: 20, message: '名称长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  uPhone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号格式', trigger: 'blur' }
  ]
})

// 分页信息
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 50
})

// 新增用户
const addUser = () => {
  // 设置为新增模式
  isEditMode.value = false
  
  // 重置表单
  Object.assign(addUserForm, {
    id: '',
    uName: '',
    uPhone: '',
    password: '',
    confirmPassword: ''
  })
  // 打开对话框
  addUserDialogVisible.value = true
}

// 查询
const handleSearch = () => {
  // 重置当前页为1
  pagination.currentPage = 1
  // 调用获取用户列表函数
  fetchUsers()
}

// 重置表单
const resetForm = () => {
  Object.assign(searchForm, {
    uName: '',
    uPhone: ''
  })
  ElMessage.info('表单已重置')
}

// 查看用户
const viewUser = (row: any) => {
  // 复制用户数据到当前查看用户
  currentViewUser.value = { ...row }
  // 打开查看对话框
  viewUserDialogVisible.value = true
}

// 编辑用户
const editUser = (row: any) => {
  // 设置为编辑模式
  isEditMode.value = true
  
  // 填充表单数据
  Object.assign(addUserForm, {
    id: row.id || '',
    uName: row.uName || '',
    uPhone: row.uPhone || ''
  })
  
  // 打开对话框
  addUserDialogVisible.value = true
}

// 重置密码对话框
const resetPasswordDialogVisible = ref(false)
const resetPasswordForm = reactive({ 
  uPassword: '' 
})
const resetPasswordFormRef = ref<FormInstance>()

// 重置密码表单验证规则
const resetPasswordFormRules = reactive<Record<string, Array<FormItemRule>>>({
  uPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ]
})

// 当前要重置密码的用户
const currentResetUser = ref<any>(null)

// 查看用户详情对话框
const viewUserDialogVisible = ref(false)
const currentViewUser = ref<any>(null)


// 分配角色对话框
const roleDialogVisible = ref(false)
const roleTree = ref<any[]>([])
const selectedRoles = ref<string[]>([])
const currentAssignUser = ref<any>(null)
const roleTreeProps = {
  value: 'rId',
  label: 'rName',
  children: 'children'
}
const treeRef = ref<any>(null)

// 关闭查看用户对话框
const closeViewUser = () => {
  // 关闭对话框
  viewUserDialogVisible.value = false
  // 清空当前查看用户数据
  currentViewUser.value = null
}


// 打开重置密码对话框
const resetPassword = (row: any) => {
  currentResetUser.value = row
  resetPasswordForm.uPassword = ''
  resetPasswordDialogVisible.value = true
}

// 提交重置密码
const submitResetPassword = async () => {
  if (!resetPasswordFormRef.value) return
  
  try {
    await resetPasswordFormRef.value.validate()
    
    const params = {
      id: currentResetUser.value.id,
      uPasswords: aesCbcEncrypt(resetPasswordForm.uPassword)
    }
    console.log("重置密码参数:", params)
    const response = await updatePWD(params)
    console.log("重置密码响应:", response)
    
    if (response.sign === '1') {
      ElMessage.success('密码重置成功')
      resetPasswordDialogVisible.value = false
    } else {
      ElMessage.error(`密码重置失败: ${response.msg || '未知错误'}`)
    }
  } catch (error: any) {
    if (error.name === 'ValidationError') {
      ElMessage.error('请输入有效的新密码')
    } else {
      ElMessage.error('密码重置失败，请稍后重试')
      console.error('重置密码失败:', error)
    }
  }
}

// 取消重置密码
const cancelResetPassword = () => {
  resetPasswordDialogVisible.value = false
  if (resetPasswordFormRef.value) {
    resetPasswordFormRef.value.resetFields()
  }
}

// 处理角色选择变化
const handleCheckChange = () => {
  if (treeRef.value) {
    const checkedNodes = treeRef.value.getCheckedNodes(false, true)
    selectedRoles.value = checkedNodes.map((item: any) => Number(item.id))
  }
}

// 打开分配角色对话框
const assignRoles = async (row: any) => {
  currentAssignUser.value = row
  selectedRoles.value = []
  try {
    console.log('当前用户:', currentAssignUser.value)
    // 加载所有角色
    const response = await selectUserRole({id: currentAssignUser.value.id})
    console.log('获取用户角色响应:', response)
    if (response.sign === '1' && response.data) {

      const roleList = response.data || []
      // 构建角色树数据
      const formattedRoles = roleList.map((item: any) => ({
        ...item,
        id: Number(item.id), 
        rName: item.rName
      }))
      console.log('格式化后的角色数据:', formattedRoles);

      roleTree.value = formattedRoles
      
      // 获取用户已有的角色ID
      const existingRoleIds = formattedRoles
        .filter((item: { isChecked: boolean }) => item.isChecked === true)
        .map((item: any) => item.id)
      console.log('用户已有的角色ID:', existingRoleIds)
      
      selectedRoles.value = existingRoleIds
      
      // 打开对话框
      roleDialogVisible.value = true
      
      // 使用nextTick确保对话框渲染完成后设置选中状态
      await nextTick()
      if (treeRef.value) {
        treeRef.value.setCheckedKeys(existingRoleIds)
      }
    }
  } catch (error) {
    ElMessage.error('加载角色失败，请稍后重试')
    console.error('加载角色失败:', error)
  }
}

// 取消分配角色
const cancelAssignRoles = () => {
  roleDialogVisible.value = false
  selectedRoles.value = []
  currentAssignUser.value = null
}

// 保存分配角色
const saveAssignRoles = async () => {
  if (!currentAssignUser.value) return
  
  try {
    // 确保获取最新的选中状态
    if (treeRef.value) {
      const checkedNodes = treeRef.value.getCheckedNodes(false, true)
      selectedRoles.value = checkedNodes.map((item: any) => Number(item.id))
    }
    console.log('当前用户:', currentAssignUser.value);
    console.log('选中的角色ID:', selectedRoles.value);
    // 调用API保存角色分配
    const response = await addUserRole({
      id: currentAssignUser.value.id,
      roleIds: selectedRoles.value
    })
    console.log("角色分配响应:", response);
    
    if (response.sign === '1') {
      ElMessage.success('角色分配成功')
      roleDialogVisible.value = false
      selectedRoles.value = []
      currentAssignUser.value = null
    } else {
      ElMessage.error(`角色分配失败: ${response.msg || '未知错误'}`)
    }
  } catch (error) {
    ElMessage.error('角色分配失败，请稍后重试')
    console.error('角色分配失败:', error)
  }
}

// 分页大小变化
const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  // 调用获取用户列表函数
  fetchUsers()
}

// 获取用户列表
const fetchUsers = async () => {
  try {
    // 构建请求参数
    const params = {
      ...searchForm,
      pageNumber: pagination.currentPage,
      pageSize: pagination.pageSize
    }
    const response = await getUserInfo(params)
    console.log("response:", response)
    // 更新用户列表和分页信息
    if(response.sign==="1"){
      usersList.value = Array.isArray(response.data.lists) ? response.data.lists : []
      pagination.total = typeof response.data.total === 'number' ? response.data.total : 0
    }
    
    ElMessage.success('获取用户列表成功')
  } catch (error) {
    ElMessage.error('获取用户列表失败，请稍后重试')
    console.error('获取用户列表失败:', error)
  }
}

// 页面加载时获取用户列表
onMounted(() => {
  fetchUsers()
})

// 当前页变化
const handleCurrentChange = (current: number) => {
  pagination.currentPage = current
  fetchUsers()
}

// 提交新增/编辑用户表单
const submitAddUser = async () => {
  if (!addUserFormRef.value) return
  
  try {
    // 验证表单
    await addUserFormRef.value.validate()
    
    // 准备请求参数
    const params: any = {
      ...addUserForm
    }
    
    // 如果是新增操作，删除uiId字段
    if (!isEditMode.value) {
      delete params.id

      console.log("新增用户参数:", params)
      const response = await addUserApi(params)
      console.log("新增用户响应:", response)
      if(response.sign!=="1"){
         ElMessage.error(`用户添加失败: ${response.msg || '未知错误'}`);
         return;
      }
    }
    else{
      console.log("更新用户参数:", params)
      const response = await updateUserApi(params)
      console.log("更新用户响应:", response)
      if(response.sign!=="1"){
         ElMessage.error(`用户更新失败: ${response.msg || '未知错误'}`);
         return;
      }
    }
  
    // 显示成功消息
    ElMessage.success(isEditMode.value ? '用户编辑成功' : '用户添加成功')

    // 关闭对话框
    addUserDialogVisible.value = false
    // 刷新用户列表
    fetchUsers()
  } catch (error: any) {
    // 验证失败或API调用失败
    if (error.name === 'ValidationError') {
      ElMessage.error('表单验证失败，请检查输入')
    } else {
      ElMessage.error(isEditMode.value ? '编辑用户失败，请稍后重试' : '添加用户失败，请稍后重试')
      console.error('用户操作失败:', error)
    }
  }
}

// 取消新增/编辑用户
const cancelAddUser = () => {
  // 重置表单验证状态
  if (addUserFormRef.value) {
    addUserFormRef.value.resetFields()
  }
  
  // 关闭对话框
  addUserDialogVisible.value = false
  
  // 重置为新增模式
  isEditMode.value = false
  
  // 重置表单数据
  Object.assign(addUserForm, {
    uiId: '',
    uName: '',
    loginCode: '',
    wechatCode: '',
    phone: '',
    password: '',
    confirmPassword: '',
    uiType: ''
  })
}
</script>

<style scoped>
.users-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.filter-card {
  margin-bottom: 20px;
}

.filter-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.filter-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
}

.users-card {
  display: flex;
  flex-direction: column;
}

.table-container {
  overflow-x: auto;
  margin-bottom: 20px;
}

.pagination-container {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  padding-top: 20px;
}

/* 用户状态容器样式 */
.status-container {
  display: flex;
  align-items: center;
  gap: 10px;
}

.status-text {
  font-size: 14px;
}

/* 用户详情样式 */
.user-details {
  padding: 10px;
}

.details-container {
  margin-top: 10px;
}

.details-container .el-descriptions-item__label {
  font-weight: 600;
  color: #303133;
}

.details-container .el-descriptions-item__content {
  color: #606266;
}
</style>
