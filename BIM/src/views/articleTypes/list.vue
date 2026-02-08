<template>
  <div class="article-types-list">
    <div class="page-header">
      <h2 class="page-title">分类管理</h2>
      <el-button type="primary" @click="openFormDialog">新增分类</el-button>
    </div>

    <!-- 搜索栏 -->
    <div class="search-bar">
      <el-form :inline="true" :model="searchForm" class="mb-4">
        <el-form-item label="分类名称">
          <el-input
            v-model="searchForm.atName"
            placeholder="请输入分类名称"
            style="width: 200px"
          />
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 分类列表 -->
    <div class="list-container">
      <el-table
        v-loading="loading"
        :data="articleTypes"
        style="width: 100%"
        border
      >
        <el-table-column type="index" label="序号" width="80" />
        <el-table-column prop="atName" label="分类名称" />
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="openFormDialog(scope.row)">编辑</el-button>
            <!-- <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button> -->
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="pagination.page"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </div>

    <!-- 分类表单对话框 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEditMode ? '编辑分类' : '新增分类'"
      width="400px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="80px"
      >
        <el-form-item label="分类名称" prop="atName">
          <el-input 
            v-model="form.atName" 
            placeholder="请输入分类名称"
            maxlength="50"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="排序" prop="atSort">
          <el-input-number 
            v-model="form.atSort" 
            :min="0" 
            :max="9999" 
            placeholder="请输入排序值"
            style="width: 100%"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit" :loading="dialogLoading">
            {{ isEditMode ? '更新' : '提交' }}
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getArticleTypeByPage,addArT, updateArT,deleteById } from '../../api/articleType'

// 搜索表单
const searchForm = reactive({
  atName: ''
})

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 10
})

// 状态
const loading = ref(false)
const articleTypes = ref([])
const total = ref(0)

// 对话框状态
const dialogVisible = ref(false)
const dialogLoading = ref(false)
const formRef = ref()

// 表单数据
const form = reactive({
  id: '',
  atName: '',
  atSort: 0
})

// 表单验证规则
const rules = {
  atName: [
    { required: true, message: '请输入分类名称', trigger: 'blur' }
  ],
  atSort: [
    { required: true, message: '请输入排序值', trigger: 'blur' },
    { type: 'number', message: '排序值必须是数字', trigger: 'blur' }
  ]
}

// 是否编辑模式
const isEditMode = computed(() => !!form.id)

// 打开表单对话框
const openFormDialog = (row) => {
  if (row) {
    // 编辑模式
    form.id = row.id
    form.atName = row.atName
    form.atSort = row.atSort || 0
  } else {
    // 新增模式
    form.id = ''
    form.atName = ''
    form.atSort = 0
  }
  dialogVisible.value = true
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  fetchArticleTypes()
}

// 重置搜索
const resetSearch = () => {
  searchForm.atName = ''
  pagination.page = 1
  fetchArticleTypes()
}

// 删除分类
const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定要删除这个分类吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    loading.value = true
    
    console.log('id:', id)
    const response = await deleteById({ id })
    console.log('response:', response)
    if (response.sign !== '1') {
      ElMessage.error(response.msg || '删除失败')
      return
    }
    ElMessage.success('删除成功')
    fetchArticleTypes() // 重新获取列表
  } catch (error) {
    // 取消删除
  } finally {
    loading.value = false
  }
}

// 提交表单
const handleSubmit = async () => {
  try {
    await formRef.value.validate()
    dialogLoading.value = true

    if (isEditMode.value) {
      form.id = route.params.id
      console.log('form:', form)
      const response = await updateArT(form)
      console.log('response:', response)
      if (response.sign !== '1') {
        ElMessage.error(response.msg || '操作失败')
        return
      }
    }
    else {
      delete form.id
      console.log("form:", form)
      const response = await addArT(form)
      console.log('response:', response)
      if (response.sign !== '1') {
        ElMessage.error(response.msg || '操作失败')
        return
      }
    }

    
    ElMessage.success(isEditMode.value ? '更新成功' : '创建成功')
    dialogVisible.value = false
    fetchArticleTypes() // 重新获取列表
  } catch (error) {
    console.error('Submit error:', error)
  } finally {
    dialogLoading.value = false
  }
}

// 分页处理
const handleSizeChange = (size) => {
  pagination.pageSize = size
  fetchArticleTypes()
}

const handleCurrentChange = (current) => {
  pagination.page = current
  fetchArticleTypes()
}

// 获取分类列表
const fetchArticleTypes = async () => {
  console.log('fetchArticleTypes')
  loading.value = true
  try {
    const params = {
      pageNumber: pagination.page,
      pageSize: pagination.pageSize,
      atName: searchForm.atName
    }
    console.log('params:', params)
    const response = await getArticleTypeByPage(params)
    console.log('response:', response)
    const data = response.data || {}

    articleTypes.value = data.lists || []
    total.value = data.total || 0
  } catch (error) {
    ElMessage.error('获取分类列表失败')
  } finally {
    loading.value = false
  }
}

// 初始化
onMounted(() => {
  console.log('onMounted')
  fetchArticleTypes()
})
</script>

<style lang="scss" scoped>
.article-types-list {
  .page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    
    .page-title {
      margin: 0;
      color: #303133;
      font-size: 18px;
    }
  }
  
  .search-bar {
    background-color: #f5f7fa;
    padding: 16px;
    border-radius: 4px;
    margin-bottom: 20px;
  }
  
  .list-container {
    background-color: #fff;
    border-radius: 4px;
    padding: 20px;
    min-height: 600px;
  }
  
  .pagination-container {
    margin-top: 20px;
    display: flex;
    justify-content: flex-end;
  }
}
</style>