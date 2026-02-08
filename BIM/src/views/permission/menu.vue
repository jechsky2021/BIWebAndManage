<template>
  <div class="menu-container">
    <!-- 筛选条件 -->
    <el-card shadow="hover" class="filter-card">
      <div class="filter-header">
        <h3>菜单管理</h3>
        <el-button type="primary" @click="addMenu">
          <el-icon><Plus /></el-icon>
          新增菜单
        </el-button>
      </div>
    </el-card>

    <!-- 菜单树 -->
    <el-card shadow="hover" class="menu-card">
      <el-tree
        v-if="menuTree.length > 0"
        :data="menuTree"
        :props="treeProps"
        :expand-on-click-node="false"
        node-key="id"
        default-expand-all
        highlight-current
      >
        <template #default="{ node, data }">
          <div class="tree-node-content">
            <span>{{ node.label }}</span>
            <div class="tree-node-actions">
              <el-button type="primary" size="small" @click.stop="editMenu(data)">
                编辑
              </el-button>
              <el-button type="danger" size="small" @click.stop="deleteMenu(data)">
                删除
              </el-button>
            </div>
          </div>
        </template>
      </el-tree>
      <div v-else class="empty-tip">
        <el-empty description="暂无菜单数据" />
      </div>
    </el-card>

    <!-- 新增/编辑菜单对话框 -->
    <el-dialog
      v-model="menuDialogVisible"
      :title="isEditMode ? '编辑菜单' : '新增菜单'"
      width="500px"
      destroy-on-close
    >
      <el-form
        ref="menuFormRef"
        :model="menuForm"
        :rules="menuFormRules"
        label-width="100px"
      >
        <el-form-item label="菜单名称" prop="mName" required>
          <el-input v-model="menuForm.mName" placeholder="请输入菜单名称" />
        </el-form-item>
        
        <el-form-item label="上级菜单" prop="mParentId">
          <el-select v-model="menuForm.mParentId" placeholder="请选择上级菜单">
            <el-option label="顶级菜单" :value="0" />
            <el-option
              v-for="menu in menuOptions"
              :key="menu.id"
              :label="menu.mName"
              :value="menu.id"
              :disabled="isEditMode && menu.id === menuForm.id"
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="菜单图标" prop="mIcon">
          <div class="icon-select-wrapper">
            <el-input v-model="menuForm.mIcon" placeholder="请输入菜单图标">
              <template #append>
                <div class="icon-preview">
                  <el-icon v-if="menuForm.mIcon">
                    <component :is="getIconComponent(menuForm.mIcon)" />
                  </el-icon>
                </div>
              </template>
            </el-input>
            <el-button type="primary" @click="openIconPicker">选择图标</el-button>
          </div>
        </el-form-item>
        
        <el-form-item label="路由路径" prop="mRoute">
          <el-input v-model="menuForm.mRoute" placeholder="请输入路由路径" />
        </el-form-item>
        
        <el-form-item label="排序" prop="mSort">
          <el-input-number v-model="menuForm.mSort" :min="0" :step="1" placeholder="请输入排序" />
        </el-form-item>
        
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="cancelMenu">取消</el-button>
          <el-button type="primary" @click="saveMenu">确定</el-button>
        </div>
      </template>
    </el-dialog>

    <!-- 图标选择对话框 -->
    <el-dialog
      v-model="iconPickerVisible"
      title="选择图标"
      width="600px"
      destroy-on-close
    >
      <div class="icon-picker-container">
        <div class="icon-search">
          <el-input v-model="iconSearch" placeholder="搜索图标名称" />
        </div>
        <div class="icon-list">
          <div
            v-for="icon in filteredIcons"
            :key="icon.name"
            class="icon-item"
            :class="{ 'icon-item-selected': menuForm.mIcon === icon.name }"
            @click="selectIcon(icon)"
          >
            <el-icon><component :is="icon.component" /></el-icon>
            <span>{{ icon.name }}</span>
          </div>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox, FormInstance, FormItemRule } from 'element-plus'
import { 
  Plus, PieChart, Document, RefreshRight, Goods, Setting, Key, Printer, 
  Tickets, User, Menu as MenuIcon, List, Folder, ArrowRight, 
  ArrowDown, ArrowUp, Edit, Delete, Search, Check, Close, 
  InfoFilled, WarningFilled, SuccessFilled, Star, StarFilled, Monitor, Phone, Message, Bell, Lock, Unlock, ZoomIn, ZoomOut,
  FullScreen, Refresh, Download, Upload, UserFilled, DocumentCopy, DocumentRemove, DocumentAdd,
  FolderOpened, FolderAdd, FolderRemove
} from '@element-plus/icons-vue'
import { MenuItem, getAllMenus, addMenuApi, updateMenuApi, deleteMenuInfo, convertToTree } from '../../api/menu'


// 搜索表单
const searchForm = reactive({
  mName: ''
})

// 菜单列表数据
const menuList = ref<MenuItem[]>([])

// 菜单树数据
const menuTree = ref<MenuItem[]>([])

// 菜单选择器选项
const menuOptions = ref<MenuItem[]>([])

// 树形结构配置
const treeProps = {
  label: 'mName',
  children: 'children'
}

// 新增/编辑菜单对话框
const menuDialogVisible = ref(false)
const isEditMode = ref(false)

// 菜单表单数据
const menuForm = reactive({
  id: 0,
  mName: '',
  mParentId: 0,
  mRoute: '',
  mIcon: '',
  mSort: 1
})

// 图标选择器状态
const iconPickerVisible = ref(false)

// 图标搜索
const iconSearch = ref('')

// 图标列表
const iconList = [
  { name: 'PieChart', component: PieChart },
  { name: 'Document', component: Document },
  { name: 'DocumentAdd', component: DocumentAdd },
  { name: 'DocumentRemove', component: DocumentRemove },
  { name: 'DocumentCopy', component: DocumentCopy },
  { name: 'RefreshRight', component: RefreshRight },
  { name: 'Goods', component: Goods },
  { name: 'Setting', component: Setting },
  { name: 'Key', component: Key },
  { name: 'Printer', component: Printer },
  { name: 'Tickets', component: Tickets },
  { name: 'User', component: User },
  { name: 'UserFilled', component: UserFilled },
  { name: 'Menu', component: MenuIcon },
  { name: 'List', component: List },
  { name: 'Folder', component: Folder },
  { name: 'FolderOpened', component: FolderOpened },
  { name: 'FolderAdd', component: FolderAdd },
  { name: 'FolderRemove', component: FolderRemove },
  { name: 'ArrowRight', component: ArrowRight },
  { name: 'ArrowDown', component: ArrowDown },
  { name: 'ArrowUp', component: ArrowUp },
  { name: 'Edit', component: Edit },
  { name: 'Delete', component: Delete },
  { name: 'Search', component: Search },
  { name: 'Check', component: Check },
  { name: 'Close', component: Close },
  { name: 'InfoFilled', component: InfoFilled },
  { name: 'WarningFilled', component: WarningFilled },
  { name: 'SuccessFilled', component: SuccessFilled },
  { name: 'Star', component: Star },
  { name: 'StarFilled', component: StarFilled },
  { name: 'Monitor', component: Monitor },
  { name: 'Phone', component: Phone },
  { name: 'Message', component: Message },
  { name: 'Bell', component: Bell },
  { name: 'Lock', component: Lock },
  { name: 'Unlock', component: Unlock },
  { name: 'ZoomIn', component: ZoomIn },
  { name: 'ZoomOut', component: ZoomOut },
  { name: 'FullScreen', component: FullScreen },
  { name: 'Refresh', component: Refresh },
  { name: 'Download', component: Download },
  { name: 'Upload', component: Upload }
]

// 表单实例引用
const menuFormRef = ref<FormInstance>()

// 表单验证规则
const menuFormRules = reactive<Record<string, Array<FormItemRule>>>({
  mName: [
    { required: true, message: '请输入菜单名称', trigger: 'blur' },
    { min: 2, max: 50, message: '菜单名称长度在 2 到 50 个字符', trigger: 'blur' }
  ],
  mParentId: [
    { required: true, message: '请选择上级菜单', trigger: 'change' }
  ],
  mRoute: [
    { required: true, message: '请输入路由路径', trigger: 'blur' },
    { min: 1, max: 100, message: '路由路径长度在 1 到 100 个字符', trigger: 'blur' }
  ],
  mSort: [
    { type: 'number', message: '排序必须为数字', trigger: 'change' }
  ]
})

// 将树形菜单转换为带有层级的下拉选项
const convertTreeToOptions = (tree: MenuItem[], level: number = 0, prefix: string = ''): MenuItem[] => {
  const options: MenuItem[] = []
  const indent = level > 0 ? '└─' + '──'.repeat(level - 1) + ' ' : ''
  
  tree.forEach(menu => {
    // 创建带有层级前缀的选项
    options.push({
      ...menu,
      mName: prefix + indent + menu.mName
    })
    
    // 递归处理子菜单
    if (menu.children && menu.children.length > 0) {
      options.push(...convertTreeToOptions(menu.children, level + 1, prefix))
    }
  })
  
  return options
}

// 获取菜单列表
const fetchMenuList = async () => {
  try {
    // 构建请求参数
    const params = {
      ...searchForm,
      pageSize: 1000, // 假设获取所有菜单
      pageNumber: 1
    }
    
    // 调用API获取菜单列表
    const response = await getAllMenus(params)
    console.log('获取菜单列表响应11:', response)
    // 更新菜单列表数据
    if (response && response.sign === '1') {
      menuList.value = Array.isArray(response.data) ? response.data : []
      
      // 转换为树形结构
      menuTree.value = convertToTree(menuList.value)
      
      // 构建带有层级的菜单选择器选项
      menuOptions.value = convertTreeToOptions(menuTree.value)
    } else {
      ElMessage.error('获取菜单列表失败')
      menuList.value = []
      menuTree.value = []
      menuOptions.value = []
    }
  } catch (error: any) {
    console.error('获取菜单列表失败:', error)
    ElMessage.error('获取菜单列表失败，请稍后重试')
    menuList.value = []
    menuTree.value = []
    menuOptions.value = []
  }
}

// 新增菜单
const addMenu = () => {
  // 设置为新增模式
  isEditMode.value = false
  
  // 重置表单数据
  Object.assign(menuForm, {
    id: 0,
    mName: '',
    mParentId: 0,
    mRoute: '',
    mIcon: '',
    miSort: 0
  })
  
  // 重置表单验证状态
  if (menuFormRef.value) {
    menuFormRef.value.resetFields()
  }
  
  // 打开对话框
  menuDialogVisible.value = true
}

// 编辑菜单
const editMenu = (data: MenuItem) => {
  // 设置为编辑模式
  isEditMode.value = true
  
  // 填充表单数据
  Object.assign(menuForm, {
    id: data.id || 0,
    mName: data.mName || '',
    mParentId: data.mParentId,
    mIcon: data.mIcon || '',
    mRoute: data.mRoute || '',
    mSort: data.mSort || 0
  })
  
  // 重置表单验证状态
  if (menuFormRef.value) {
    menuFormRef.value.resetFields()
  }
  
  // 打开对话框
  menuDialogVisible.value = true
}

// 删除菜单
const deleteMenu = async (data: MenuItem) => {
  try {
    await ElMessageBox.confirm(`确定要删除菜单 ${data.mName} 吗？`, '删除确认', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    // 调用删除菜单API
    const response = await deleteMenuInfo({ id: data.id })
    
    // 检查响应状态
    if (response.sign !== '1') {
      ElMessage.error(`删除菜单失败: ${response.msg || '未知错误'}`)
      return
    }
    
    // 刷新菜单列表
    fetchMenuList()
    
    // 显示成功消息
    ElMessage.success('菜单已删除')
  } catch (error: any) {
    // 取消删除或发生错误
    if (error.name !== 'ElMessageBoxCancel') {
      ElMessage.error('删除菜单失败，请稍后重试')
      console.error('删除菜单失败:', error)
    }
  }
}

// 保存菜单
const saveMenu = async () => {
  if (!menuFormRef.value) return
  
  try {
    // 验证表单
    await menuFormRef.value.validate()
    
    // 准备请求参数
    const params: any = {
      ...menuForm
    }
    if(!isEditMode.value) {
      delete params.id
      console.log('params:', params)
      const response = await addMenuApi(params)
      console.log('response:', response);
      if(response.sign !== '1'){
        ElMessage.error(`菜单操作失败: ${response.msg || '未知错误'}`)
        return
      }
    }
    else{
      console.log('params:', params)
      const response = await updateMenuApi(params)
      console.log('response:', response);
      if(response.sign !== '1'){
        ElMessage.error(`菜单操作失败: ${response.msg || '未知错误'}`)
        return
      }
    }
    
    // 关闭对话框
    menuDialogVisible.value = false
    
    // 刷新菜单列表
    fetchMenuList()
    
    // 显示成功消息
    ElMessage.success(isEditMode.value ? '菜单编辑成功' : '菜单添加成功')
  } catch (error: any) {
    // 验证失败或API调用失败
    if (error.name === 'ValidationError') {
      ElMessage.error('表单验证失败，请检查输入')
    } else {
      ElMessage.error(isEditMode.value ? '编辑菜单失败，请稍后重试' : '添加菜单失败，请稍后重试')
      console.error('菜单操作失败:', error)
    }
  }
}

// 取消菜单操作
const cancelMenu = () => {
  // 关闭对话框
  menuDialogVisible.value = false
  
  // 重置表单验证状态
  if (menuFormRef.value) {
    menuFormRef.value.resetFields()
  }
  
  // 重置为新增模式
  isEditMode.value = false
}

// 过滤后的图标列表
const filteredIcons = computed(() => {
  if (!iconSearch.value) {
    return iconList
  }
  return iconList.filter(icon => 
    icon.name.toLowerCase().includes(iconSearch.value.toLowerCase())
  )
})

// 打开图标选择器
const openIconPicker = () => {
  iconPickerVisible.value = true
}

// 获取图标组件
const getIconComponent = (iconName: string) => {
  const icon = iconList.find(icon => icon.name === iconName)
  return icon?.component || ''
}

// 选择图标
const selectIcon = (icon: { name: string; component: any }) => {
  menuForm.mIcon = icon.name
  iconPickerVisible.value = false
}

// 组件加载时调用获取菜单列表函数
onMounted(() => {
  fetchMenuList()
})
</script>

<style scoped>
.menu-container {
  display: flex;
  flex-direction: column;
  gap: 20px;
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

.tree-node-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.tree-node-actions {
  display: flex;
  gap: 5px;
}

.empty-tip {
  padding: 40px 0;
  text-align: center;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}

/* 图标选择器样式 */
.icon-select-wrapper {
  display: flex;
  gap: 10px;
  align-items: center;
}

.icon-preview {
  display: flex;
  align-items: center;
  padding: 0 10px;
  height: 100%;
  border-left: 1px solid #dcdfe6;
  font-size: 18px;
}

/* 图标选择对话框样式 */
.icon-picker-container {
  padding: 10px;
}

.icon-search {
  margin-bottom: 20px;
}

.icon-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
  gap: 10px;
  max-height: 400px;
  overflow-y: auto;
}

.icon-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 15px 10px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.icon-item:hover {
  border-color: #409eff;
  background-color: #ecf5ff;
}

.icon-item-selected {
  border-color: #409eff;
  background-color: #ecf5ff;
  color: #409eff;
}

.icon-item el-icon {
  font-size: 24px;
  margin-bottom: 5px;
}

.icon-item span {
  font-size: 12px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  width: 100%;
  text-align: center;
}
</style>