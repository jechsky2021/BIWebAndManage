<template>
  <div class="articles-list">
    <div class="page-header">
      <h2 class="page-title">文章管理</h2>
      <el-button type="primary" @click="navigateToForm()">新增文章</el-button>
    </div>

    <!-- 搜索栏 -->
    <div class="search-bar">
      <el-form :inline="true" :model="searchForm" class="mb-4">
        <el-form-item label="文章标题">
          <el-input
            v-model="searchForm.title"
            placeholder="请输入文章标题"
            style="width: 200px"
          />
        </el-form-item>
        
        <el-form-item label="状态">
          <el-select
            v-model="searchForm.statuss"
            placeholder="请选择状态"
            style="width: 150px"
          >
            <el-option label="全部" value="-1" />
            <el-option label="草稿" value="0" />
            <el-option label="已发布" value="1" />
            <el-option label="已下架" value="2" />
          </el-select>
        </el-form-item>
        
        <el-form-item label="分类">
          <el-select
            v-model="searchForm.articleType"
            placeholder="请选择分类"
            style="width: 250px"
          >
            <el-option label="全部" value="-1" />
            <el-option 
              v-for="category in hierarchicalCategories" 
              :key="category.id" 
              :label="category.displayName" 
              :value="category.id" 
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="日期范围">
          <el-date-picker
            v-model="searchForm.dateRange"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            style="width: 300px"
          />
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </div>

    <!-- 文章列表 -->
    <div class="list-container">
      <el-table
        v-loading="loading"
        :data="articles"
        style="width: 100%"
        border
      >
        <el-table-column prop="title" label="文章标题" width="250">
          <template #default="scope">
            <div class="article-title">
              <span :class="{ 'font-bold': scope.row.isRecommend }">{{ scope.row.title }}</span>
              <el-tag v-if="scope.row.isRecommend" size="small" type="primary" effect="light" class="ml-2">推荐</el-tag>
            </div>
          </template>
        </el-table-column>
        
        <el-table-column label="分类" width="250">
          <template #default="scope">
            {{ getCategoryWithParentName(scope.row.articleType) }}
          </template>
        </el-table-column>
        
        <el-table-column prop="statuss" label="状态" width="120">
          <template #default="scope">
            <el-tag
              :type="scope.row.statuss === 1 ? 'success' : scope.row.statuss === 0 ? 'info' : 'warning'"
              size="small"
            >
              {{ scope.row.statuss === 1 ? '已发布' : scope.row.statuss === 0 ? '草稿' : '已下架' }}
            </el-tag>
          </template>
        </el-table-column>
        
        <el-table-column prop="author" label="作者" width="120" />
        
        <el-table-column prop="createTime" label="创建时间" width="180">
          <template #default="scope">
            {{ formatDateDisplay(scope.row.createTime) }}
          </template>
        </el-table-column>
        
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="scope">
            <el-button size="small" @click="navigateToForm(scope.row.id)">编辑</el-button>
            <el-button
          size="small"
          :type="scope.row.statuss === 1 ? 'warning' : 'success'"
          @click="handleToggleStatus(scope.row)"
        >
          {{ scope.row.statuss === 1 ? '下架' : '发布' }}
        </el-button>
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
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getArticleByPage,getDetailById,updateStatus } from '../../api/articles'
import {getArticleTypeByPage} from '../../api/articleType'
import dayjs from 'dayjs'

const router = useRouter()

// 搜索表单
const searchForm = reactive({
  title: '',
  statuss: '-1',
  articleType: '-1',
  dateRange: null
})

// 分页
const pagination = reactive({
  page: 1,
  pageSize: 10
})

// 状态
const loading = ref(false)
const articles = ref([])
const total = ref(0)
const categories = ref([])
const hierarchicalCategories = ref([])

// 格式化日期（返回日期对象，用于API参数）
const formatDate = (date) => {
  return dayjs(date).add(8, 'hour').toDate()
}

// 格式化日期显示（用于表格显示）
const formatDateDisplay = (date) => {
  return dayjs(date).format('YYYY-MM-DD HH:mm:ss')
}

// 根据分类ID获取分类名称
const getCategoryName = (categoryId) => {
  const category = categories.value.find(cat => cat.id === categoryId)
  return category ? category.atName : categoryId || '未分类'
}

// 获取带父级分类名称的完整分类名称
const getCategoryWithParentName = (categoryId) => {
  const category = hierarchicalCategories.value.find(cat => cat.id === categoryId)
  return category ? category.displayName : getCategoryName(categoryId)
}

// 构建层级分类结构（带显示名称）
const buildHierarchicalCategories = (categoriesList) => {
  const categoryMap = {}
  const result = []
  
  // 首先创建所有分类的映射
  categoriesList.forEach(category => {
    categoryMap[category.id] = {
      ...category,
      depth: 0
    }
  })
  
  // 构建层级关系并生成显示名称
  categoriesList.forEach(category => {
    const parentId = category.parentId || '0'
    if (parentId === '0' || parentId === 0) {
      // 顶级分类
      categoryMap[category.id].displayName = category.atName
      result.push(categoryMap[category.id])
    } else if (categoryMap[parentId]) {
      // 子分类
      categoryMap[category.id].displayName = `${categoryMap[parentId].displayName} > ${category.atName}`
      categoryMap[category.id].depth = categoryMap[parentId].depth + 1
      result.push(categoryMap[category.id])
    } else {
      // 找不到父级，显示为顶级
      categoryMap[category.id].displayName = category.atName
      result.push(categoryMap[category.id])
    }
  })
  
  return result
}

// 导航到表单页
const navigateToForm = (id) => {
  console.log("id:",id)
  if (id) {
    router.push(`/articles/form/${id}`)
  } else {
    router.push('/articles/form')
  }
}

// 搜索
const handleSearch = () => {
  pagination.page = 1
  fetchArticles()
}

// 重置搜索
const resetSearch = () => {
  searchForm.title = ''
  searchForm.status = ''
  searchForm.dateRange = null
  pagination.page = 1
  fetchArticles()
}

// 切换状态
const handleToggleStatus = async (article) => {
  const newStatus = article.statuss === 1 ? 2 : 1
  loading.value = true
  try {
    // 这里需要实现状态切换API调用
    const response = await updateStatus({
      id: article.id,
      statuss: newStatus
    })
    console.log("response:",response)
    if (response.sign !== '1') {
      ElMessage.error(response.msg || '状态切换失败')
      return
    }
    article.statuss = newStatus
    ElMessage.success('状态切换成功')
    fetchArticles() // 重新获取列表
  } catch (error) {
    ElMessage.error('状态切换失败')
  } finally {
    loading.value = false
  }
}

// 删除文章
const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确定要删除这篇文章吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    loading.value = true
    await deleteArticle(id)
    ElMessage.success('删除成功')
    fetchArticles() // 重新获取列表
  } catch (error) {
    // 取消删除
  } finally {
    loading.value = false
  }
}

// 分页处理
const handleSizeChange = (size) => {
  pagination.pageSize = size
  fetchArticles()
}

const handleCurrentChange = (current) => {
  pagination.page = current
  fetchArticles()
}

// 获取分类列表
const fetchCategories = async () => {
  try {
    console.log("获取分类列表")
    const data = await getArticleTypeByPage({ pageNumber: 1, pageSize: 100 })
    console.log("data:",data)
    const categoriesList = data.data.lists || []
    categories.value = categoriesList
    
    // 构建层级分类（带显示名称）
    hierarchicalCategories.value = buildHierarchicalCategories(categoriesList)
  } catch (error) {
    console.error('获取分类列表失败:', error)
  }
}

// 获取文章列表
const fetchArticles = async () => {
  loading.value = true
  try {
    const params = {
      pageNumber: pagination.page,
      pageSize: pagination.pageSize,
      title: searchForm.title,
      statuss: Number(searchForm.statuss),
      articleType: Number(searchForm.articleType)
    }
    
    if (searchForm.dateRange) {
      params.startTime = formatDate(searchForm.dateRange[0])
      params.endTime = formatDate(searchForm.dateRange[1])
    }
    console.log("params:",params)
    const data = await getArticleByPage(params)
    console.log("data:",data)
    articles.value = data.data.lists || []
    total.value = data.data.total || 0
  } catch (error) {
    ElMessage.error('获取文章列表失败')
  } finally {
    loading.value = false
  }
}

// 初始化
onMounted(() => {
  fetchCategories()
  fetchArticles()
})
</script>

<style lang="scss" scoped>
.articles-list {
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
  
  .article-title {
    display: flex;
    align-items: center;
    gap: 8px;
  }
}
</style>