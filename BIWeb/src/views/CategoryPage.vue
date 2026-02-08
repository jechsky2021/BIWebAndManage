<template>
  <div class="category-page">
    <!-- 导航栏和分类栏会通过App.vue自动包含 -->
    
    <!-- 二级页面内容 -->
    <main class="main-content">
      <div class="container">
        <!-- 分类标题和描述 -->
        <div class="category-header">
          <h1 class="category-title">{{ categoryName }}</h1>
          <p class="category-description">{{ categoryDescription }}</p>
        </div>

        <!-- 筛选和排序 -->
        <div class="filter-bar">
          <div class="filter-options">
            <button class="filter-btn" :class="{ active: activeFilter === 'latest' }" @click="activeFilter = 'latest'">最新</button>
            <button class="filter-btn" :class="{ active: activeFilter === 'hot' }" @click="activeFilter = 'hot'">最热</button>
            <button class="filter-btn" :class="{ active: activeFilter === 'recommend' }" @click="activeFilter = 'recommend'">推荐</button>
          </div>
          <div class="view-mode">
            <button class="view-btn" :class="{ active: activeViewMode === 'list' }" @click="activeViewMode = 'list'">列表</button>
            <button class="view-btn" :class="{ active: activeViewMode === 'grid' }" @click="activeViewMode = 'grid'">网格</button>
          </div>
        </div>

        <!-- 内容列表 -->
        <div class="content-list" :class="{ 'grid-view': activeViewMode === 'grid' }">
          <div 
            v-for="article in filteredArticles" 
            :key="article.id" 
            class="content-item"
            @click="goToDetail(article.id)"
          >
            <div class="content-image">
              <div class="image-placeholder" :style="{ backgroundColor: article.color }">{{ article.id }}</div>
            </div>
            <div class="content-info">
              <h3 class="content-title">{{ article.title }}</h3>
              <p class="content-summary">{{ article.summary }}</p>
              <div class="content-meta">
                <span class="publish-date">{{ article.publishDate }}</span>
                <span class="read-count">阅读 {{ article.readCount }}</span>
                <span class="like-count">点赞 {{ article.likeCount }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- 分页 -->
        <div class="pagination">
          <button class="page-btn prev" :disabled="currentPage === 1">上一页</button>
          <button 
            v-for="page in totalPages" 
            :key="page" 
            class="page-btn" 
            :class="{ active: page === currentPage }"
            @click="currentPage = page"
          >
            {{ page }}
          </button>
          <button class="page-btn next" :disabled="currentPage === totalPages">下一页</button>
        </div>

        <!-- 热门标签 -->
        <div class="popular-tags">
          <h3>热门标签</h3>
          <div class="tags-container">
            <span v-for="tag in popularTags" :key="tag" class="tag">{{ tag }}</span>
          </div>
        </div>
      </div>
    </main>

    
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute, useRouter } from 'vue-router';

interface CategoryInfo {
  name: string;
  description: string;
}

interface Article {
  id: number;
  title: string;
  summary: string;
  publishDate: string;
  readCount: number;
  likeCount: number;
  color: string;
}

const route = useRoute();
const router = useRouter();
const categoryId = computed(() => route.params.id || '1');
const categoryName = ref('美业资讯分类');
const categoryDescription = ref('这里是关于美业的最新资讯和产品信息');
const currentPage = ref(1);
const totalPages = ref(5);
const articles = ref<Article[]>([]);
const popularTags = ref<string[]>(['染发技巧', '护发知识', '产品测评', '行业动态', '潮流趋势', '专业工具', '护理方法', '色彩搭配']);
const activeFilter = ref('latest');
const activeViewMode = ref('list');

const loadCategoryData = () => {
  // 根据分类ID加载不同的分类信息
  const categoryMap: Record<string, CategoryInfo> = {
    '1': { name: '单支染膏', description: '了解各种单支染膏产品的特点和使用方法' },
    '2': { name: '双支染膏', description: '双支染膏的专业调配和效果展示' },
    '3': { name: '黑油精油', description: '黑油精油产品介绍和使用技巧' },
    '4': { name: '冷烫热汤', description: '烫发技术和产品的详细解析' },
    '5': { name: '洗护产品', description: '各类洗护产品的选择和使用建议' },
    '6': { name: '发膜系列', description: '发膜产品的功效和正确使用方法' },
    '7': { name: '彩妆工具', description: '专业彩妆工具的使用技巧和推荐' },
    '8': { name: '美发工具', description: '美发专业工具的选择和使用指南' }
  };
  
  if (categoryMap[categoryId.value as string]) {
    categoryName.value = categoryMap[categoryId.value as string].name;
    categoryDescription.value = categoryMap[categoryId.value as string].description;
  }
};

const generateMockArticles = () => {
  // 生成模拟文章数据
  const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#F7DC6F', '#BB8FCE', '#52BE80', '#F8C471', '#85C1E9'];
  
  articles.value = Array.from({ length: 10 }, (_, index) => ({
    id: (currentPage.value - 1) * 10 + index + 1,
    title: `${categoryName.value}专业知识分享${index + 1}：如何选择适合的产品`,
    summary: `这是一篇关于${categoryName.value}的专业文章，详细介绍了产品的选择方法、使用技巧以及注意事项，帮助您更好地了解和使用相关产品。`,
    publishDate: new Date(Date.now() - index * 86400000).toLocaleDateString(),
    readCount: Math.floor(Math.random() * 10000) + 1000,
    likeCount: Math.floor(Math.random() * 500) + 50,
    color: colors[index % colors.length]
  }));
};

const goToDetail = (id: number) => {
  router.push(`/article/${id}`);
};

const filteredArticles = computed(() => {
  let filtered = [...articles.value];
  
  switch (activeFilter.value) {
    case 'latest':
      // 按发布日期降序排序
      return filtered.sort((a, b) => new Date(b.publishDate).getTime() - new Date(a.publishDate).getTime());
    case 'hot':
      // 按阅读量降序排序
      return filtered.sort((a, b) => b.readCount - a.readCount);
    case 'recommend':
      // 筛选阅读量超过3000的文章
      return filtered.filter(article => article.readCount > 3000).sort((a, b) => b.readCount - a.readCount);
    default:
      return filtered;
  }
});

onMounted(() => {
  loadCategoryData();
  generateMockArticles();
});

watch(currentPage, () => {
  generateMockArticles();
});
</script>

<style lang="scss" scoped>
.category-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f9fa;

  .main-content {
    flex: 1;
    padding: 30px 0;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .category-header {
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .category-title {
      font-size: 32px;
      font-weight: bold;
      color: #333;
      margin-bottom: 12px;
    }

    .category-description {
      font-size: 16px;
      color: #666;
      line-height: 1.6;
    }
  }

  .filter-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #fff;
    padding: 16px 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .filter-options {
      display: flex;
      gap: 12px;
    }

    .filter-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
      transform: translateY(0);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
      font-size: 14px;
      color: #666;

      &::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 107, 107, 0.2), transparent);
        transition: left 0.5s ease;
      }

      &:hover {
        background-color: #f5f5f5;
        border-color: #ff6b6b;
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        color: #ff6b6b;
      }

      &:hover::before {
        left: 100%;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.4);
        transform: translateY(-1px);
      }

      &:active {
        transform: translateY(0);
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }
    }
    
    .view-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        background-color: #f5f5f5;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }

    .view-mode {
      display: flex;
      gap: 8px;
    }
  }

  .content-list {
    margin-bottom: 20px;
    
    &.grid-view {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }
  }

  .content-item {
    display: flex;
    gap: 20px;
    background-color: #fff;
    padding: 20px;
    margin-bottom: 16px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    cursor: pointer;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
    }

    .content-image {
      width: 120px;
      height: 120px;
      border-radius: 6px;
      overflow: hidden;
      flex-shrink: 0;

      .image-placeholder {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
        font-weight: bold;
        color: #fff;
      }
    }

    .content-info {
      flex: 1;

      .content-title {
        font-size: 20px;
        font-weight: 600;
        color: #333;
        margin-bottom: 12px;
        line-height: 1.4;
      }

      .content-summary {
        font-size: 14px;
        color: #666;
        line-height: 1.6;
        margin-bottom: 12px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .content-meta {
        display: flex;
        gap: 20px;
        font-size: 13px;
        color: #999;
      }
    }
    
  }
  
  // 网格视图下的内容项样式
  .content-list.grid-view .content-item {
    display: flex;
    flex-direction: column;
    margin-bottom: 0;
    height: 100%;
    
    .content-image {
      width: 100%;
      height: 200px;
      margin-bottom: 16px;
    }
    
    .content-info {
      .content-title {
        font-size: 18px;
        margin-bottom: 8px;
      }
      
      .content-summary {
        -webkit-line-clamp: 3;
        margin-bottom: 10px;
      }
      
      .content-meta {
        margin-top: auto;
        flex-wrap: wrap;
        gap: 12px;
      }
    }
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

  .popular-tags {
    background-color: #fff;
    padding: 24px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    h3 {
      font-size: 18px;
      font-weight: 600;
      color: #333;
      margin-bottom: 16px;
    }

    .tags-container {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;

      .tag {
        padding: 6px 16px;
        background-color: #f0f0f0;
        border-radius: 20px;
        font-size: 14px;
        color: #666;
        cursor: pointer;
        transition: all 0.3s ease;

        &:hover {
          background-color: #ff6b6b;
          color: #fff;
        }
      }
    }
  }

  // 响应式设计
  @media (max-width: 768px) {
    .category-header {
      padding: 20px;

      .category-title {
        font-size: 24px;
      }
    }

    .filter-bar {
      flex-direction: column;
      gap: 16px;
      align-items: stretch;

      .filter-options {
        justify-content: center;
      }

      .view-mode {
        justify-content: center;
      }
    }

    .content-item {
      flex-direction: column;
      gap: 16px;

      .content-image {
        width: 100%;
        height: 180px;
      }

      .content-info {
        .content-title {
          font-size: 18px;
        }
      }
    }

    // 响应式网格视图
    .content-list.grid-view {
      grid-template-columns: 1fr;
      gap: 16px;
    }
    
    .content-list.grid-view .content-item {
      .content-image {
        height: 160px;
      }
      
      .content-info {
        .content-title {
          font-size: 16px;
        }
        
        .content-summary {
          -webkit-line-clamp: 2;
        }
      }
    }

    .pagination {
      flex-wrap: wrap;
    }
  }
  
  // 中等屏幕尺寸的响应式调整
  @media (min-width: 769px) and (max-width: 1024px) {
    .content-list.grid-view {
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 16px;
    }
  }
}
</style>