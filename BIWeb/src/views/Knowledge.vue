<template>
  <div class="knowledge">
   
    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <!-- <h1 class="page-title">美业知识库</h1> -->

        <!-- 分类导航 -->
        <div class="app-categories">
          <button v-for="category in categories" :key="category.articleType"
            :class="['category-btn', { active: activeCategory === category.articleType }]"
            @click="activeCategory = category.articleType">
            {{ category.atName }}
          </button>
        </div>

        <!-- 知识模块 - 使用统一组件，通过不同数据渲染 -->
        <div class="knowledge-section">
          <knowledge-module 
            :knowledge-data="knowledgeData"
            :active-filter="activeFilter"
            :tags="getCurrentTags()"
            @update:activeFilter="activeFilter = $event"
            @tag-click="handleTagClick"
          />
        </div>

      </div>
    </main>
 
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted } from 'vue';
import KnowledgeModule from '../components/KnowledgeModule.vue';
import { getArticlesByPage } from '../api/articles';
import { getArticleTypeByPage } from '../api/articleTypes';


const activeCategory = ref<any>(''); // 默认显示烫发分类
const activeFilter = ref<string>('latest'); // 默认显示最新
const loading = ref(false);

const categories = ref<any[]>([]);
const knowledgeData = ref<any[]>([]);
 
const fetchCategories = async ()=>{
  try {
    const response = await getArticleTypeByPage({
      parentId:9,
      pageNumber: 1,
      pageSize: 20
    });

    console.log('获取分类数据响应:', response);

    if (response.data) {
      // 尝试不同的响应结构
      const items = response.data.lists || response.data.items || [];
      console.log('分类数据:', items);
      
      if (items.length > 0) {
        categories.value = items.map((item: any) => ({
          articleType: item.articleType || item.id || item.ArticleType || item.ID,
          atName: item.atName || item.AtName || item.name || item.Name || '未分类'
        })).filter((item: any) => item.articleType); // 过滤掉没有articleType的项
        
        console.log('处理后的分类:', categories.value);
      }
    }
  } catch (error) {
    console.error('获取分类数据失败:', error);
  }
}

// 获取分类知识数据
const fetchKnowledgeData = async (categoryKey: string) => {
  try {
    loading.value = true;
    console.log(`获取${categoryKey}知识数据:`, categoryKey);
    const response = await getArticlesByPage({
      articleType: categoryKey || -1,
      statuss: 1,
      isRecommend: 1,
      parentId:9,
      pageNumber: 1,
      pageSize: 20
    });
    
    console.log(`获取${categoryKey}知识数据:`, response);
    
    if (response.data && response.data.lists) {
      const articles = response.data.lists.map((item: any) => ({
        id: item.id,
        articleType: item.articleType,
        atName : item.atName,
        title: item.title || '暂无标题',
        introduce: item.introduce || (item.content ? item.content.substring(0, 100) : '暂无简介'),
        createTime: item.createTime ? new Date(item.createTime).toISOString().split('T')[0] : new Date().toISOString().split('T')[0],
        pageViews: item.pageViews || 0
      }));
      
      console.log('处理后的文章数据:', articles);
      knowledgeData.value = articles;
      console.log(`categories:`, categories.value);

    }
  } catch (error) {
    console.error(`获取${categoryKey}知识数据失败:`, error);
  } finally {
    loading.value = false;
  }
};

// 烫发标签
const permTags = ['冷烫', '热烫', '数码烫', '陶瓷烫', '离子烫', '烫发护理', '烫发设计', '烫发药水'];

// 染发标签
const hairDyeingTags = ['漂染', '染发色彩', '白发覆盖', '染发护理', '渐变染', '挑染', '染发工具', '染发产品'];

// 洗发标签
const shampooTags = ['洗发水选择', '护发素', '头皮护理', '干性发质', '油性发质', '受损发质', '洗发频率', '深层清洁'];

// 剪发标签
const haircutTags = ['发型设计', '剪发技巧', '层次剪发', '男士发型', '儿童剪发', '工具使用', '流行趋势', '艺术造型'];

// 吹发标签
const blowDryTags = ['吹风机使用', '卷发造型', '直发造型', '热损伤防护', '造型产品', '专业手法', '吹干技巧', '持久造型'];
 

// 监听分类变化，获取对应数据
watch(activeCategory, (newCategory) => {
  if (newCategory) {
    fetchKnowledgeData(newCategory);
  }
}, { immediate: false });

// 组件挂载时获取默认分类数据
onMounted(async () => {
  await fetchCategories();
  // 设置默认分类
  console.log(`categories:`, categories.value);
  if (categories.value.length > 0) {
    const firstCategory = categories.value[0];
    console.log(`第一个分类:`, firstCategory);
    // 确保类型一致
    activeCategory.value = firstCategory.articleType;
    console.log(`activeCategory.value:`, activeCategory.value);
  } else {
    console.log('没有获取到分类数据');
    // 如果没有分类数据，设置一个默认值
    activeCategory.value = '1';
  }
});

// 获取当前分类的标签
const getCurrentTags = () => {
  // 简单返回烫发标签作为默认，后续可以根据实际需求映射
  return permTags;
};

// 处理标签点击事件
const handleTagClick = (tag: string) => {
  console.log('点击了标签:', tag);
  // 这里可以添加标签点击的具体逻辑，比如：
  // 1. 筛选包含该标签的文章
  // 2. 跳转到标签相关的页面
  // 3. 显示该标签下的更多内容
  // 4. 添加到搜索过滤器
};


</script>

<style lang="scss" scoped>
.knowledge {
  padding: 20px 0;
  background-color: #f9f9f9;
}

.main-content {
  background-color: #fff;
  padding: 20px 0;
}

.container {
  max-width: 1400px;
  margin: 0 auto;
  padding: 0 20px;
}

.page-title {
  font-size: 32px;
  font-weight: bold;
  color: #333;
  margin-bottom: 30px;
  text-align: center;
  padding: 20px 0;
}

/* 分类导航样式 */
.app-categories {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 15px;
  margin-bottom: 40px;
  padding: 0 20px;
}

.category-btn {
  padding: 12px 24px;
  background-color: #f0f0f0;
  border: none;
  border-radius: 25px;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 16px;
  font-weight: 500;
  color: #666;
  position: relative;
  overflow: hidden;
}

.category-btn:hover {
  background-color: #e0e0e0;
  transform: translateY(-2px);
}

.category-btn.active {
  background-color: #ff6b6b;
  color: white;
  box-shadow: 0 4px 12px rgba(255, 107, 107, 0.4);
  transform: translateY(-1px);
}

/* 知识板块通用样式 */
.knowledge-section {
  background-color: #fff;
  border-radius: 12px;
  padding: 30px;
  margin-bottom: 40px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
}

.section-header {
  margin-bottom: 30px;
  text-align: center;
}

.section-title {
  font-size: 28px;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
  position: relative;
  display: inline-block;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 50%;
  transform: translateX(-50%);
  width: 60px;
  height: 4px;
  background: linear-gradient(90deg, #4ECDC4, #45B7D1);
  border-radius: 2px;
}

.section-description {
  color: #666;
  font-size: 16px;
  line-height: 1.6;
  margin-top: 20px;
}

/* 筛选栏样式 */
.filter-bar {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 25px;
  padding: 15px 0;
  border-bottom: 1px solid #eee;
}

.filter-options {
  display: flex;
  gap: 10px;
}

.filter-btn {
  padding: 8px 16px;
  background-color: #f8f9fa;
  border: 1px solid #ddd;
  border-radius: 20px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  font-size: 14px;
  color: #666;
  position: relative;
  overflow: hidden;
  transform: translateY(0);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
}

.filter-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 107, 107, 0.2), transparent);
  transition: left 0.5s ease;
}

.filter-btn:hover {
  background-color: #e9ecef;
  border-color: #ff6b6b;
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  color: #ff6b6b;
}

.filter-btn:hover::before {
  left: 100%;
}

.filter-btn.active {
  background-color: #ff6b6b;
  color: white;
  border-color: #ff6b6b;
  box-shadow: 0 4px 12px rgba(255, 107, 107, 0.4);
  transform: translateY(-1px);
}

.filter-btn:active {
  transform: translateY(0);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 知识卡片网格样式 */
.knowledge-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
  gap: 25px;
  margin-bottom: 30px;
}

/* 知识卡片样式 */
.knowledge-card {
  background-color: #fff;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 3px 15px rgba(0, 0, 0, 0.08);
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
  display: block;
}

.knowledge-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
}

.card-image {
  height: 180px;
  overflow: hidden;
  position: relative;
}

.image-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 48px;
  font-weight: bold;
  color: white;
  transition: transform 0.3s ease;
}

.knowledge-card:hover .image-placeholder {
  transform: scale(1.05);
}

.card-content {
  padding: 20px;
}

.card-title {
  font-size: 20px;
  font-weight: bold;
  color: #333;
  margin-bottom: 12px;
  line-height: 1.3;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card-summary {
  color: #666;
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 15px;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 10px;
  border-top: 1px solid #f0f0f0;
  font-size: 12px;
  color: #999;
}

.publish-date {
  display: flex;
  align-items: center;
  gap: 5px;
}

.read-count {
  display: flex;
  align-items: center;
  gap: 5px;
}

/* 热门标签样式 */
.popular-tags {
  background-color: #f8f9fa;
  border-radius: 8px;
  padding: 20px;
  margin-top: 30px;
}

.popular-tags h3 {
  font-size: 18px;
  font-weight: bold;
  color: #333;
  margin-bottom: 15px;
}

.tags-container {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.tag {
  padding: 6px 14px;
  background-color: #fff;
  border: 1px solid #e0e0e0;
  border-radius: 20px;
  font-size: 14px;
  color: #666;
  cursor: pointer;
  transition: all 0.3s ease;
  display: inline-block;
}

.tag:hover {
  background-color: #4ECDC4;
  color: white;
  border-color: #4ECDC4;
}

  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-bottom: 30px;

    .page-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover:not(:disabled) {
        border-color: #ff6b6b;
        color: #ff6b6b;
      }

      &:disabled {
        opacity: 0.5;
        cursor: not-allowed;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }
  }

/* 响应式设计 */
@media (max-width: 1024px) {
  .knowledge-grid {
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

@media (max-width: 768px) {
  .container {
    padding: 0 15px;
  }
  
  .page-title {
    font-size: 26px;
  }
  
  .knowledge-section {
    padding: 20px;
  }
  
  .section-title {
    font-size: 24px;
  }
  
  .knowledge-grid {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  
  .card-image {
    height: 150px;
  }
  
  .app-categories {
    justify-content: flex-start;
    overflow-x: auto;
    padding-bottom: 10px;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: thin;
  }
  
  .app-categories::-webkit-scrollbar {
    height: 5px;
  }
  
  .app-categories::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
  }
  
  .app-categories::-webkit-scrollbar-thumb {
    background: #ccc;
    border-radius: 10px;
  }
  
  .app-categories::-webkit-scrollbar-thumb:hover {
    background: #aaa;
  }
  
  .filter-bar {
    justify-content: center;
  }
  
  .tags-container {
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .page-title {
    font-size: 22px;
  }
  
  .category-btn {
    padding: 10px 20px;
    font-size: 14px;
  }
  
  .section-title {
    font-size: 20px;
  }
  
  .card-title {
    font-size: 18px;
  }
}
</style>