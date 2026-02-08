<template>
  <div class="roles-container">
    <!-- 筛选条件 -->
    <el-card shadow="hover" class="filter-card">
      <div class="filter-header">
        <h3>角色权限管理</h3>
        <el-button type="primary" @click="addRole">
          <el-icon><Plus /></el-icon>
          新增角色
        </el-button>
      </div>
      <el-form :model="searchForm" inline>
        <el-form-item label="角色名称">
          <el-input v-model="searchForm.rName" placeholder="请输入角色名称" style="width: 200px" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 角色列表 -->
    <el-card shadow="hover" class="roles-card">
      <div class="table-container">
        <el-table :data="rolesList" stripe style="width: 100%">
          <el-table-column type="index" label="序号" width="80" />
          <el-table-column prop="rName" label="角色名称" />
          <el-table-column prop="rRemark" label="角色描述" />
          <!--   <el-table-column prop="status" label="状态" >
            <template #default="scope">
              <el-tag v-if="scope.row.status === 'normal'" type="success">正常</el-tag>
            </template>
          </el-table-column> -->
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
              <!-- <el-button type="primary" size="small" @click="viewRole(scope.row)">查看</el-button> -->
              <el-button size="small" @click="editRole(scope.row)">编辑</el-button>
              <el-button type="success" size="small" @click="assignPermissions(scope.row)">分配权限</el-button>
              <el-button type="danger" size="small" @click="deleteRole(scope.row)">删除</el-button>
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

    <!-- 权限分配对话框 -->
    <el-dialog
      v-model="permissionDialogVisible"
      title="分配权限"
      width="50%"
      @close="closePermissionDialog"
    >
      <el-tree
          ref="treeRef"
          :data="permissionTree"
          show-checkbox
          node-key="id"
          :props="permissionTreeProps"
          default-expand-all
          highlight-current
          @check-change="handleCheckChange"
        />
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="closePermissionDialog">取消</el-button>
          <el-button type="primary" @click="savePermissions">保存</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 新增/编辑角色对话框 -->
    <el-dialog
      v-model="roleDialogVisible"
      :title="isEditMode ? '编辑角色' : '新增角色'"
      width="500px"
      destroy-on-close
    >
      <el-form
        ref="roleFormRef"
        :model="roleForm"
        :rules="roleFormRules"
        label-width="100px"
      >
        <el-form-item label="角色名称" prop="rName" required>
          <el-input v-model="roleForm.rName" placeholder="请输入角色名称" />
        </el-form-item>
        <el-form-item label="角色描述" prop="rRemark">
          <el-input v-model="roleForm.rRemark" placeholder="请输入角色描述" type="textarea" :rows="3" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="cancelRole">取消</el-button>
          <el-button type="primary" @click="saveRole">确定</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, nextTick } from 'vue'
import { ElMessage, ElMessageBox, FormInstance, FormItemRule } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { getRoleList,addRoleApi,updateRoleApi,deleteRoleInfo,addRoleMenuInfo,getMenuByRoleId } from '../../api/role'
import { getAllMenus, convertToTree } from '../../api/menu'

import dayjs from 'dayjs'

// 搜索表单
const searchForm = reactive({
  rName: '',
  status: ''
})

// 角色列表数据
const rolesList = ref([
])

// 分页信息
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 30
})

// 权限分配对话框
const permissionDialogVisible = ref(false)
const selectedRole = ref<any>(null)
const selectedPermissions = ref<(string | number)[]>([])


// 递归查找权限树中的节点
const findPermissionInTree = (tree: any[], permissionId: string | number): boolean => {
  for (const node of tree) {
    if (node.id === String(permissionId)) {
      return true
    }
    if (node.children && node.children.length > 0) {
      if (findPermissionInTree(node.children, permissionId)) {
        return true
      }
    }
  }
  return false
}

// 处理权限树复选框变化事件
const handleCheckChange = (_node: any, _isChecked: boolean, _indeterminate: boolean) => {  
  // 使用treeRef获取当前所有选中的节点，确保状态一致性
  if (treeRef.value) {
    // 获取所有选中的节点（包括半选节点的父节点）
    const checkedNodes = treeRef.value.getCheckedNodes(true, true)
    
    // 提取所有选中节点的id，转换为字符串类型
    const checkedIds = checkedNodes.map((item: any) => String(item.id))
    
    // 更新selectedPermissions，创建新数组引用确保响应式更新
    selectedPermissions.value = [...checkedIds]
  }
}

// 权限树数据
const permissionTree = ref<any[]>([])

// 权限树ref实例
const treeRef = ref<any>(null)

// 权限树配置
const permissionTreeProps = {
  value: 'id', // Element Plus使用value而不是id来指定节点的唯一标识
  label: 'label',
  children: 'children'
}

// 获取权限树数据
const fetchPermissionTree = async () => {
  try {
    const params = {
      pageSize: 1000,
      pageNumber: 1
    }
    
    const response = await getAllMenus(params)
    
    if (response.sign === '1' && Array.isArray(response.data)) {
      // 使用convertToTree将扁平数据转换为树形结构
      // 将miName映射为label，并统一id和mParentId类型为字符串
      const menuData = response.data.map((item: any) => ({
        ...item,
        id: String(item.id), // 统一转换为字符串类型
        mParentId: item.mParentId === null ? null : String(item.mParentId), // 统一转换为字符串类型
        label: item.mName
      }))
    
      // 构建树形结构
      const treeData = convertToTree(menuData)

      permissionTree.value = treeData
    } else {
      permissionTree.value = []
      ElMessage.error('获取菜单树数据失败：' + response.msg)
    }
  } catch (error: any) {
    console.error('获取权限树失败:', error)
    ElMessage.error('获取菜单树数据失败：' + error.message)
    permissionTree.value = []
  }
}

// 新增角色
const addRole = () => {
  // 设置为新增模式
  isEditMode.value = false
  
  // 重置表单数据
  Object.assign(roleForm, {
    id: '',
    rName: '',
    rRemark: ''
  })
  
  // 重置表单验证状态
  if (roleFormRef.value) {
    roleFormRef.value.resetFields()
  }
  
  // 打开对话框
  roleDialogVisible.value = true
}

// 查询
const handleSearch = () => {
  // 重置当前页为第1页
  pagination.currentPage = 1
  // 调用获取角色列表函数
  fetchRolesList()
}

// 重置表单
const resetForm = () => {
  Object.assign(searchForm, {
    rName: '',
    status: ''
  })
  ElMessage.info('表单已重置')
}


// 编辑角色
const editRole = (row: any) => {
  // 设置为编辑模式
  isEditMode.value = true
  
  // 填充表单数据
  Object.assign(roleForm, {
    id: row.id || '',
    rName: row.rName || '',
    rRemark: row.rRemark || ''
  })
  
  // 重置表单验证状态
  if (roleFormRef.value) {
    roleFormRef.value.resetFields()
  }
  
  // 打开对话框
  roleDialogVisible.value = true
}

// 分配权限
const  assignPermissions =async (row: any) => {
  selectedRole.value = row
  // 加载真实菜单树数据
  await fetchPermissionTree()

  console.log("角色ID:", selectedRole.value.id)
  const response = await getMenuByRoleId({id: selectedRole.value.id});

  // 检查响应状态并设置选中权限
  if (response.sign === '1' && Array.isArray(response.data)) {
    // 获取所有选中的权限项
    const allCheckedItems = response.data.filter((item: { isChecked: boolean }) => item.isChecked === true)
    
    // 收集所有权限项的id和mParentId
    //const allids = new Set(allCheckedItems.map((item: { id: string | number }) => String(item.id)))
    const allFatherIds = new Set(allCheckedItems.map((item: { mParentId: string | number | null }) => 
      item.mParentId === null ? null : String(item.mParentId)
    ).filter((id: string | null) => id !== null))
    
    // 过滤掉是父节点的数据（即id存在于mParentId集合中的节点）
    const leafNodes = allCheckedItems.filter((item: { id: string | number }) => {
      const idStr = String(item.id)
      return !allFatherIds.has(idStr)
    })
    
    // 设置选中权限为过滤后的叶子节点
    selectedPermissions.value = leafNodes.map((item: { id: string | number }) => String(item.id))
  } else {
    selectedPermissions.value = []
    ElMessage.warning('获取角色权限失败')
  }

  // 打开权限对话框
  permissionDialogVisible.value = true
  
  // 使用nextTick确保树组件渲染完成
  await nextTick()
  
  // 设置选中的权限
  if (treeRef.value) {
    treeRef.value.setCheckedKeys(selectedPermissions.value)
  } else {
    // 如果树组件未就绪，使用setTimeout再试一次
    setTimeout(() => {
      if (treeRef.value) {
        treeRef.value.setCheckedKeys(selectedPermissions.value)
      }
    }, 100)
  }
}

// 保存权限
const savePermissions = async () => {
  if (!selectedRole.value) return
  
  try {
    // 使用treeRef获取当前所有选中的节点，确保与界面状态一致
    let checkedIds: Number[] = []
    if (treeRef.value) {
      // 获取所有选中的节点（包括父子节点）
      // 第一个参数false表示获取所有选中节点，而不仅是叶子节点
      // 第二个参数true表示包括半选节点
      const checkedNodes = treeRef.value.getCheckedNodes(false, true)
      console.log("所有选中的节点:", checkedNodes)
        
      checkedIds = checkedNodes.map((item: any) => Number(item.id))
    } else {
      // 如果treeRef不可用，使用selectedPermissions作为备选，并确保所有元素都是字符串类型
      checkedIds = selectedPermissions.value.map(id => Number(id))
    }
    
    // 检查是否至少选择了一个权限
    if (checkedIds.length === 0) {
      ElMessage.warning('请至少选择一个权限')
      return
    }
    
    // 构建请求参数
    // const menuInfoList = checkedIds.map(id => ({
    //   id: selectedRole.value.id
    // }))
    const params ={
      roleId: selectedRole.value.id,
      menuIds: checkedIds
    }
    
    console.log("分配的权限ID列表:", checkedIds)
    console.log("请求参数:", params);
    // 调用API保存权限分配
    const response = await addRoleMenuInfo(params)
    console.log("分配权限响应:", response)
    
    // 检查响应状态
    if (response.sign === '1') {
      ElMessage.success(`已为角色 ${selectedRole.value.rName} 分配权限`)
      permissionDialogVisible.value = false
    } else {
      ElMessage.error(`权限分配失败: ${response.msg || '未知错误'}`)
    }
  } catch (error: any) {
    console.error('权限分配失败:', error)
    ElMessage.error('权限分配失败，请稍后重试')
  }
}

// 关闭权限分配对话框
const closePermissionDialog = () => {
  permissionDialogVisible.value = false
  selectedRole.value = null
  selectedPermissions.value = []
}

// 新增/编辑角色对话框
const roleDialogVisible = ref(false)
const isEditMode = ref(false)

// 角色表单数据
const roleForm = reactive({
  id: '',
  rName: '',
  rRemark: ''
})

// 表单实例引用
const roleFormRef = ref<FormInstance>()

// 表单验证规则
const roleFormRules = reactive<Record<string, Array<FormItemRule>>>({
  rName: [
    { required: true, message: '请输入角色名称', trigger: 'blur' },
    { min: 2, max: 20, message: '角色名称长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  rRemark: [
    { max: 100, message: '角色描述不能超过 100 个字符', trigger: 'blur' }
  ]
})

// 保存角色
const saveRole = async () => {
  if (!roleFormRef.value) return
  
  try {
    // 验证表单
    await roleFormRef.value.validate()
    
    // 准备请求参数
    const params: any = {
      ...roleForm
    }
    
    // 如果是新增操作，删除id字段
    if (!isEditMode.value) {
      delete params.id
      console.log("新增参数:", params)
      const Response = await addRoleApi(params)
      console.log("新增响应:", Response)
      // 检查响应状态
      if (Response.sign !== '1') {
        ElMessage.error(`角色添加失败: ${Response.msg || '未知错误'}`)
        return
      }
    } else {
      console.log("编辑参数:", params)
      const Response = await updateRoleApi(params)
      console.log("编辑响应:", Response)
      // 检查响应状态
      if (Response.sign !== '1') {
        ElMessage.error(`角色编辑失败: ${Response.msg || '未知错误'}`)
        return
      }
    }
    
     // 显示成功消息
    ElMessage.success(isEditMode.value ? '角色编辑成功' : '角色添加成功')

    // 关闭对话框
    roleDialogVisible.value = false
    
    // 刷新角色列表
    fetchRolesList()
   
  } catch (error: any) {
    // 验证失败或API调用失败
    if (error.name === 'ValidationError') {
      ElMessage.error('表单验证失败，请检查输入')
    } else {
      ElMessage.error(isEditMode.value ? '编辑角色失败，请稍后重试' : '添加角色失败，请稍后重试')
      console.error('角色操作失败:', error)
    }
  }
}

// 取消角色操作
const cancelRole = () => {
  // 关闭对话框
  roleDialogVisible.value = false
  
  // 重置表单验证状态
  if (roleFormRef.value) {
    roleFormRef.value.resetFields()
  }
  
  // 重置为新增模式
  isEditMode.value = false
}

// 删除角色
const deleteRole = async (row: any) => {
  try {
    await ElMessageBox.confirm(`确定要删除角色 ${row.rName} 吗？`, '删除确认', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // 调用删除角色API
    const response = await deleteRoleInfo({ id: row.id })
    
    // 检查响应状态
    if (response.sign !== '1') {
      ElMessage.error(`删除角色失败: ${response.msg || '未知错误'}`)
      return
    }
    
    // 刷新角色列表
    fetchRolesList()
    
    // 显示成功消息
    ElMessage.success('角色已删除')
  } catch (error: any) {
    // 取消删除或发生错误
    if (error.name !== 'ElMessageBoxCancel') {
      ElMessage.error('删除角色失败，请稍后重试')
      console.error('删除角色失败:', error)
    }
  }
}

// 分页大小变化
const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  fetchRolesList()
}

// 获取角色列表
const fetchRolesList = async () => {
  try {
    // 构建请求参数
    const params = {
      pageSize: pagination.pageSize,
      pageNumber: pagination.currentPage,
      rName: searchForm.rName
    }
    
    // 调用API获取角色列表
    const response = await getRoleList(params)
    console.log('获取角色列表响应:', response)
    
    // 更新角色列表数据
    if (response.sign === '1') {
      rolesList.value = Array.isArray(response.data.lists) ? response.data.lists : []
      pagination.total = typeof response.data.total === 'number' ? response.data.total : 0
      ElMessage.success('角色列表获取成功')
    } else {
      ElMessage.error(`角色列表获取失败: ${response.msg || '未知错误'}`)
    }
  } catch (error: any) {
    console.error('获取角色列表失败:', error)
    ElMessage.error('角色列表获取失败，请稍后重试')
  }
}

// 当前页变化
const handleCurrentChange = (current: number) => {
  pagination.currentPage = current
  fetchRolesList()
}

// 组件加载时调用获取角色列表函数
onMounted(() => {
  fetchRolesList()
})
</script>

<style scoped>
.roles-container {
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

.roles-card {
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

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>
