<template>
  <div class="article-form">
    <div class="page-header">
      <h2 class="page-title">{{ isEditMode ? '编辑文章' : '新增文章' }}</h2>
      <el-button @click="$router.back()">返回</el-button>
    </div>

    <div class="form-container">
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="80px"
        v-loading="loading"
      >
        <el-form-item label="文章标题" prop="title">
          <el-input 
            v-model="form.title" 
            placeholder="请输入文章标题"
            maxlength="100"
            show-word-limit
          />
        </el-form-item>
        
        <el-form-item label="状态" prop="statuss">
          <el-radio-group v-model="form.statuss">
            <el-radio value="0">草稿</el-radio>
            <el-radio value="1">已发布</el-radio>
            <el-radio value="2">已下架</el-radio>
          </el-radio-group>
        </el-form-item>
        
        <el-form-item label="作者" prop="author">
          <el-input 
            v-model="form.author" 
            placeholder="请输入作者"
            maxlength="50"
          />
        </el-form-item>
        
        <el-form-item label="分类" prop="articleType">
          <el-select v-model="form.articleType" placeholder="请选择分类" style="width: 300px">
            <el-option 
              v-for="category in hierarchicalCategories" 
              :key="category.id" 
              :label="category.indentName" 
              :value="category.id" 
            />
          </el-select>
        </el-form-item>
        
        <el-form-item label="是否推荐" prop="isRecommend">
          <el-checkbox v-model="form.isRecommend">推荐文章</el-checkbox>
        </el-form-item>
        
        <el-form-item label="摘要" prop="introduce">
          <el-input
            v-model="form.introduce"
            type="textarea"
            :rows="3"
            placeholder="请输入文章摘要"
            maxlength="200"
            show-word-limit
          />
        </el-form-item>
        
        <el-form-item label="内容" prop="content">
          <div class="quill-editor-wrapper">
            <QuillEditor
              ref="editorRef"
              v-model="form.content"
              placeholder="请输入文章内容"
              :options="editorOptions"
            />
          </div>
          <input type="file" ref="fileInput" style="display: none" accept="image/*" @change="uploadImage" />
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="handleSubmit" :loading="loading">
            {{ isEditMode ? '更新' : '提交' }}
          </el-button>
          <el-button @click="$router.back()">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getArticleByPage,getDetailById, addArticle,updateArticle } from '../../api/articles'
import { getArticleTypeByPage } from '../../api/articleType'
import { uploadFiles } from '../../api/files'
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'

const route = useRoute()
const router = useRouter()

const formRef = ref()
const loading = ref(false)
const editorRef = ref(null)
const fileInput = ref(null)

// 自定义图片处理器
const imageHandler = () => {
  // 触发隐藏的 file input
  fileInput.value.click()
}

const editorOptions = ref({
  theme: 'snow',
  modules: {
    toolbar: {
      container: [
        ['bold', 'italic', 'underline', 'strike'],
        ['blockquote', 'code-block'],
        [{ 'header': 1 }, { 'header': 2 }],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        [{ 'script': 'sub' }, { 'script': 'super' }],
        [{ 'indent': '-1' }, { 'indent': '+1' }],
        [{ 'direction': 'rtl' }],
        [{ 'size': ['small', false, 'large', 'huge'] }],
        [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
        [{ 'color': [] }, { 'background': [] }],
        [{ 'font': [] }],
        [{ 'align': [] }],
        ['clean'],
        ['link', 'image', 'video']
      ],
      handlers: {
        image: imageHandler
      }
    }
  }
})

// 上传图片
const uploadImage = async (event) => {
  const file = event.target.files[0]
  if (!file) return
  
  // 检查文件类型
  if (!file.type.match('image.*')) {
    alert('请选择图片文件')
    return
  }
  
  // 检查文件大小（限制2MB）
  if (file.size > 2 * 1024 * 1024) {
    alert('图片大小不能超过2MB')
    return
  }
  
  try {
    // 创建 FormData
    const formData = new FormData()
    formData.append('image', file)
    
    // 显示上传中提示
    const quill = editorRef.value.getQuill()
    const range = quill.getSelection()
    quill.insertEmbed(range.index, 'image', '/loading.gif')
    
    // 这里替换为你的上传API
    const response = await uploadFiles(formData)
    const imageUrl = response.url
    
    // 删除 loading 图片，插入真实图片
    quill.deleteText(range.index, 1)
    quill.insertEmbed(range.index, 'image', imageUrl)
    
  } catch (error) {
    console.error('上传失败:', error)
    alert('图片上传失败，请重试')
    // 删除 loading 图片
    const quill = editorRef.value.getQuill()
    const range = quill.getSelection()
    quill.deleteText(range.index, 1)
  } finally {
    // 清空 input，以便再次选择同一文件
    event.target.value = ''
  }
}

// 判断是编辑模式还是新增模式
const isEditMode = computed(() => !!route.params.id)

// 分类列表
const categories = ref([])
const hierarchicalCategories = ref([])

const form = reactive({
  title: '',
  statuss: "0",
  author: '',
  articleType: '',
  isRecommend: false,
  introduce: '',
  content: ''
})

// 获取分类列表
const fetchCategories = async () => {
  try {
    const data = await getArticleTypeByPage({ pageNumber: 1, pageSize: 100 })
    const categoriesList = data.data.lists || []
    categories.value = categoriesList
    
    // 构建层级分类（带显示名称）
    hierarchicalCategories.value = buildHierarchicalCategories(categoriesList)
  } catch (error) {
    console.error('获取分类列表失败:', error)
  }
}

// 构建层级分类结构（带缩进名称）
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
  
  // 构建层级关系并生成缩进名称
  categoriesList.forEach(category => {
    const parentId = category.parentId || '0'
    if (parentId === '0' || parentId === 0) {
      // 顶级分类
      categoryMap[category.id].indentName = category.atName
      result.push(categoryMap[category.id])
    } else if (categoryMap[parentId]) {
      // 子分类
      const indent = ' '.repeat(categoryMap[parentId].depth * 2) + '└─ '
      categoryMap[category.id].indentName = indent + category.atName
      categoryMap[category.id].depth = categoryMap[parentId].depth + 1
      result.push(categoryMap[category.id])
    } else {
      // 找不到父级，显示为顶级
      categoryMap[category.id].indentName = category.atName
      result.push(categoryMap[category.id])
    }
  })
  
  return result
}

const rules = {
  title: [
    { required: true, message: '请输入文章标题', trigger: 'blur' }
  ],
  author: [
    { required: true, message: '请输入作者', trigger: 'blur' }
  ],
  articleType: [
    { required: true, message: '请选择分类', trigger: 'change' }
  ],
  content: [
    { required: true, message: '请输入文章内容', trigger: ['blur', 'change'] }
  ]
}

// 加载文章数据（编辑模式）
const loadArticle = async () => {
  if (!isEditMode.value) return
  
  const articleId = route.params.id
  if (!articleId) {
    ElMessage.error('文章ID不存在')
    router.push('/articles/list')
    return
  }

  loading.value = true
  try {
    console.log('articleId:', articleId)
    const response = await getDetailById({id:articleId})
    console.log('response:', response)
    if (response.sign === '1') {
      const data = response.data[0];
      Object.assign(form, data)
      form.statuss = data.statuss.toString()
      form.isRecommend = data.isRecommend === 1

      setTimeout(() => {
        if (editorRef.value && editorRef.value.getQuill) {
          const quill = editorRef.value.getQuill()
          // 清空编辑器
          quill.root.innerHTML = ''
          // 使用编辑器API设置内容
          if (data.content) {
            quill.clipboard.dangerouslyPasteHTML(data.content)
          }
          console.log('Editor content set successfully')
        }
      }, 100)

      
    }
  } catch (error) {
    ElMessage.error('加载文章失败')
    console.error('Load article error:', error)
  } finally {
    loading.value = false
  }
}

// 提交表单
const handleSubmit = async () => {
  console.log('form before submit:', form)
  try {
    // 确保富文本编辑器内容已同步
    if (editorRef.value && editorRef.value.getQuill) {
      const quill = editorRef.value.getQuill()
      const content = quill.root.innerHTML
      if (content && content !== '<p><br></p>') {
        form.content = content
      }
    }
    
    console.log('form before validate:', form)
    await formRef.value.validate()
    loading.value = true
    
    console.log('form after validate:', JSON.stringify(form))
    const params = {
      ...form,
      statuss: Number(form.statuss),
      isRecommend: form.isRecommend ? 1 : 0
    }

    if (isEditMode.value) {
      params.id = route.params.id
      console.log('params:', params)
      const response = await updateArticle(params)
      console.log('response:', response)
      if(response.sign !== '1'){
        ElMessage.error(`文章操作失败: ${response.msg || '未知错误'}`)
        return
      }
    }
    else{
      delete params.id
      console.log("params:",params)
      const response = await addArticle(params)
      console.log('response:', response)
      if(response.sign !== '1'){
        ElMessage.error(`文章操作失败: ${response.msg || '未知错误'}`)
        return
      }
    }
   
    ElMessage.success(isEditMode.value ? '更新成功' : '创建成功')

    router.push('/articles/list')
  } catch (error) {
    console.error('Submit error:', error)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchCategories()
  loadArticle()
})

</script>

<style lang="scss" scoped>
.article-form {
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
  
  .form-container {
    background-color: #fff;
    padding: 20px;
    border-radius: 4px;
  }
}

.quill-editor-wrapper {
  position: relative;
  width: 100%;
  min-height: 400px;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  overflow: hidden;
}

:deep(.ql-container) {
  font-size: 14px;
  border: none;
  border-radius: 0 0 4px 4px;
  min-height: 400px;
  overflow-y: auto;
}

:deep(.ql-toolbar) {
  border: none;
  border-bottom: 1px solid #dcdfe6;
  border-radius: 4px 4px 0 0;
  background-color: #f5f7fa;
}

:deep(.ql-editor) {
  min-height: 300px;
  padding: 12px;
}

:deep(.ql-snow .ql-statusbar) {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: #f5f7fa;
  border-top: 1px solid #dcdfe6;
  padding: 4px 8px;
  font-size: 12px;
  color: #909399;
}
</style>