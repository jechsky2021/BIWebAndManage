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
import { uploadFiles,saveGoodsPic } from '../../api/files'
import { pictureServerBaseUrl } from '../../utils/axios'
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css'

const route = useRoute()
const router = useRouter()

const formRef = ref()
const loading = ref(false)
const editorRef = ref(null)
const fileInput = ref(null)


const baseImgFolder = 'article'


// 将文件转换为 base64 字符串
const getBase64 = (file) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.onload = (e) => {
      const result = e.target.result
      resolve(result)
    }
    reader.onerror = reject
    reader.readAsDataURL(file)
  })
}

// 自定义图片处理器
const imageHandler = () => {
  // 触发隐藏的 file input
  fileInput.value.click()
}

// 图片缩放功能（点选后滚轮缩放）
let imageZoomInitialized = false
let selectedImage = null

const setupImageZoom = () => {
  if (imageZoomInitialized) return
  
  imageZoomInitialized = true
  
  setTimeout(() => {
    const quill = editorRef.value.getQuill()
    const editor = quill.root
    
    // 为所有图片添加点击事件（用于选择）
    editor.addEventListener('click', (e) => {
      if (e.target.tagName === 'IMG') {
        // 移除之前选中图片的样式
        if (selectedImage) {
          selectedImage.classList.remove('image-selected')
        }
        // 选中当前图片
        selectedImage = e.target
        selectedImage.classList.add('image-selected')
        e.stopPropagation()
      } else {
        // 点击其他地方取消选择
        if (selectedImage) {
          selectedImage.classList.remove('image-selected')
          selectedImage = null
        }
      }
    })
    
    // 为编辑器添加滚轮事件
    editor.addEventListener('wheel', (e) => {
      if (selectedImage) {
        e.preventDefault()
        handleImageZoom(selectedImage, e.deltaY)
      }
    })
  }, 100)
}

// 处理图片滚轮缩放
const handleImageZoom = (img, deltaY) => {
  // 获取当前宽度（默认为100%）
  let currentWidth = img.style.width
  let widthPercent = 100
  
  if (currentWidth) {
    widthPercent = parseFloat(currentWidth)
  }
  
  // 根据滚轮方向调整大小（每次5%）
  if (deltaY < 0) {
    // 向上滚动，放大
    widthPercent = Math.min(widthPercent + 5, 200) // 最大200%
  } else {
    // 向下滚动，缩小
    widthPercent = Math.max(widthPercent - 5, 30) // 最小30%
  }
  
  // 应用新宽度
  img.style.width = widthPercent + '%'
  img.style.height = 'auto'
  
  // 添加缩放动画
  img.style.transition = 'width 0.2s ease'
}

// 监听编辑器内容变化，为新插入的图片添加点击事件
const setupImageZoomObserver = () => {
  const quill = editorRef.value.getQuill()
  const editor = quill.root
  
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      mutation.addedNodes.forEach((node) => {
        if (node.tagName === 'IMG') {
          // 为新插入的图片添加点击事件
          node.addEventListener('click', (e) => {
            // 移除之前选中图片的样式
            if (selectedImage) {
              selectedImage.classList.remove('image-selected')
            }
            // 选中当前图片
            selectedImage = node
            selectedImage.classList.add('image-selected')
            e.stopPropagation()
          })
        } else if (node.children && node.children.length > 0) {
          // 检查子节点
          Array.from(node.children).forEach((child) => {
            if (child.tagName === 'IMG') {
              child.addEventListener('click', (e) => {
                // 移除之前选中图片的样式
                if (selectedImage) {
                  selectedImage.classList.remove('image-selected')
                }
                // 选中当前图片
                selectedImage = child
                selectedImage.classList.add('image-selected')
                e.stopPropagation()
              })
            }
          })
        }
      })
    })
  })
  
  observer.observe(editor, {
    childList: true,
    subtree: true
  })
}

// 图片操作功能通过工具栏现有选项实现
// 对齐功能已在工具栏中提供
// 尺寸调整通过选择图片后使用工具栏的大小选项实现

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
console.log("uploadImage");
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
    const request = {
      fileName: `${baseImgFolder}\/${Date.now().toString()}`,
      base64Str:  await getBase64(file)
    }
    console.log("request",request)
    const response = await saveGoodsPic(request)
    console.log("response",response)
    
    if(response.data.code === '0'){
      ElMessage.success('图片上传成功')
      // 删除 loading 图片，获取图片原始尺寸后插入真实图片
      const imagePath = response.data.data
      const imageUrl = `${pictureServerBaseUrl}${imagePath}`
      console.log('图片完整URL:', imageUrl)
      
      // 获取图片原始尺寸
      const img = new Image()
      img.src = imageUrl
      img.onload = () => {
        const width = img.naturalWidth
        const height = img.naturalHeight
        console.log('图片原始尺寸:', width, 'x', height)
        
        // 计算显示尺寸（最大宽度限制为100%，保持比例）
        const maxWidth = 500
        let displayWidth = width
        let displayHeight = height
        
        if (width > maxWidth) {
          const ratio = maxWidth / width
          displayWidth = maxWidth
          displayHeight = height * ratio
        }
        
        // 删除 loading 图片，插入带尺寸的图片
        quill.deleteText(range.index, 1)
        
        // 使用自定义方式插入图片，带有宽度和高度样式，支持对齐和调整大小
        const imgHTML = `<img src="${imageUrl}" style="width: ${displayWidth}px; height: ${displayHeight}px; max-width: 100%;" width="${displayWidth}" height="${displayHeight}" class="quill-image"/>`
        quill.clipboard.dangerouslyPasteHTML(range.index, imgHTML)
        
        // 确保新上传的图片也能立即支持缩放功能
        setupImageZoom()
       
      }
    }else{
      ElMessage.error('图片上传失败')
    }
    
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
  
  // 初始化图片缩放功能
  setTimeout(() => {
    setupImageZoom()
    setupImageZoomObserver()
  }, 500)
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
  
  /* 图片样式 */
  img {
    max-width: 100%;
    height: auto;
  }
  
  /* 块级元素对齐 */
  p.ql-align-center,
  div.ql-align-center,
  li.ql-align-center {
    text-align: center;
  }
  
  p.ql-align-right,
  div.ql-align-right,
  li.ql-align-right {
    text-align: right;
  }
  
  p.ql-align-left,
  div.ql-align-left,
  li.ql-align-left {
    text-align: left;
  }
  
  /* 图片对齐 */
  p.ql-align-center img,
  div.ql-align-center img,
  li.ql-align-center img {
    display: block;
    margin: 0 auto;
  }
  
  p.ql-align-right img,
  div.ql-align-right img,
  li.ql-align-right img {
    display: block;
    margin-left: auto;
  }
  
  p.ql-align-left img,
  div.ql-align-left img,
  li.ql-align-left img {
    display: block;
    margin-right: auto;
  }
  
  /* 图片尺寸控制 */
  .quill-image {
    cursor: pointer;
  }
  
  /* 选中图片样式 */
  .image-selected {
    outline: 2px solid #409EFF;
    cursor: zoom-in;
  }
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