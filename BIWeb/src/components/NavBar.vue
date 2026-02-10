<template>
  <div>
    <!-- 导航栏 -->
    <header class="navbar">
      <div class="container">
        <div class="logo">
          <router-link to="/">美业资讯</router-link>
        </div>
        <nav class="nav-links">
          <router-link to="/" class="nav-link" :class="{ active: currentRoute === '/' }" >首页</router-link>
          <router-link to="/beauty-circle" class="nav-link" :class="{ active: currentRoute === '/beauty-circle' }" >美业圈</router-link>
          <router-link to="/knowledge" class="nav-link" :class="{ active: currentRoute === '/knowledge' }" >美业知识库</router-link>
        </nav>
        
        <!-- 搜索框 -->
        <div class="search-container">
          <div class="search-box" :class="{ active: isSearchFocused }">
            <input 
              v-model="searchQuery"
              type="text" 
              placeholder="搜索美业资讯..."
              class="search-input"
              @focus="isSearchFocused = true"
              @blur="isSearchFocused = false"
              @keyup.enter="performSearch"
            />
            <button class="search-btn" @click="performSearch">
              <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
              </svg>
            </button>
          </div>
          
          <!-- 搜索建议 -->
          <div v-if="showSuggestions && searchQuery" class="search-suggestions">
            <div v-for="suggestion in filteredSuggestions" :key="suggestion.id" class="suggestion-item" @click="selectSuggestion(suggestion)">
              <!-- <div class="suggestion-icon">🔍</div> -->
              <div class="suggestion-text">{{ suggestion.title }}</div>
            </div>
          </div>
        </div>
        
        <div class="user-actions">
          <router-link to="/login" class="login-btn" @click="navigateTo('/login')">登录</router-link>
        </div>
      </div>
    </header>

    <!-- 分类栏 - 仅在首页显示 -->
    <div v-if="currentRoute === '/'" class="categories-bar">
      <div class="container">
        <div class="category-items">
          <router-link 
            v-for="category in categories" 
            :key="category.id" 
            :to="`/category/${category.id}`" 
            class="category-item" 
            :class="{ active: currentRoute.includes(`/category/${category.id}`) }" 
          >{{ category.atName }}</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getArticleTypeByPage } from '../api/articleTypes';

export default {
  name: 'NavBar',
  data() {
    return {
      activeDropdown: null,
      searchQuery: '',
      isSearchFocused: false,
      // 分类数据
      categories: [],
      // 模拟搜索建议数据
      searchSuggestions: [
        { id: 1, title: '染发技巧大全', category: '染发' },
        { id: 2, title: '护发产品推荐', category: '护发' },
        { id: 3, title: '烫发技术详解', category: '烫发' },
        { id: 4, title: '美业工具选择', category: '工具' },
        { id: 5, title: '色彩搭配原理', category: '色彩' },
        { id: 6, title: '沙龙经营技巧', category: '经营' },
        { id: 7, title: '客户沟通方法', category: '服务' },
        { id: 8, title: '产品成分分析', category: '产品' }
      ]
    }
  },
  created() {
    // 加载分类数据
    this.loadCategories();
  },
  computed: {
    currentRoute() {
      return this.$route.path;
    },
    filteredSuggestions() {
      if (!this.searchQuery.trim()) return [];
      
      return this.searchSuggestions.filter(suggestion => 
        suggestion.title.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
        suggestion.category.toLowerCase().includes(this.searchQuery.toLowerCase())
      ).slice(0, 5); // 最多显示5个建议
    },
    showSuggestions() {
      return this.isSearchFocused && this.searchQuery.trim() && this.filteredSuggestions.length > 0;
    }
  },
  methods: {
    // 加载分类数据
    async loadCategories() {
      try {
        const response = await getArticleTypeByPage({ pageNumber: 1, pageSize: 8 });
        // console.log("response:",response)
        if (response.data && response.data.lists) {
          this.categories = response.data.lists;
        }
      } catch (error) {
        console.error('Failed to load categories:', error);
      }
    },
    navigateTo(path) {
      // 确保导航正确执行
      this.$router.push(path);
    },
    toggleDropdown(index) {
      this.activeDropdown = this.activeDropdown === index ? null : index;
    },
    performSearch() {
      if (this.searchQuery.trim()) {
        console.log('搜索:', this.searchQuery);
        // 这里可以导航到搜索结果页面或触发搜索事件
        // this.$router.push({ name: 'Search', query: { q: this.searchQuery } });
        // 或者发出一个全局事件
        this.$root.$emit('global-search', this.searchQuery);
        
        // 清空搜索框
        this.searchQuery = '';
        this.isSearchFocused = false;
      }
    },
    selectSuggestion(suggestion) {
      this.searchQuery = suggestion.title;
      this.performSearch();
    }
  }
}
</script>

<style lang="scss" scoped>
/* 导航栏样式 */
.navbar {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  padding: 16px 0;

  .container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    
    a {
      color: inherit;
      text-decoration: none;
    }
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 20px;
    
  }

  .nav-link {
    color: #666;
    text-decoration: none;
    padding: 8px 16px;
    transition: all 0.3s ease;
    position: relative;
    cursor: pointer;
    font-size: 20px;

    &:hover,
    &.active {
      color: #ff6b6b;
    }

    &.active::after {
      content: '';
      position: absolute;
      bottom: -8px;
      left: 50%;
      transform: translateX(-50%);
      width: 20px;
      height: 2px;
      background: linear-gradient(90deg, #ff6b6b, #ffa500);
      border-radius: 1px;
    }

/* 搜索框样式 */
.search-container {
  position: relative;
  margin-left: 20px;
}

.search-box {
  display: flex;
  align-items: center;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 25px;
  padding: 8px 12px;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.search-box.active {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 107, 107, 0.5);
  box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
}

.search-input {
  background: transparent;
  border: none;
  outline: none;
  color: white;
  font-size: 14px;
  width: 180px;
  margin-right: 8px;
}

.search-input::placeholder {
  color: rgba(255, 255, 255, 0.7);
}

.search-btn {
  background: transparent;
  border: none;
  cursor: pointer;
  padding: 4px;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.search-btn:hover {
  background: rgba(255, 107, 107, 0.2);
}

.search-icon {
  width: 18px;
  height: 18px;
  stroke: rgba(255, 255, 255, 0.8);
  transition: stroke 0.3s ease;
}

.search-box.active .search-icon {
  stroke: #ff6b6b;
}

/* 搜索建议样式 */
.search-suggestions {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  margin-top: 8px;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  overflow: hidden;
  z-index: 1000;
  max-height: 300px;
  overflow-y: auto;
}

.suggestion-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  cursor: pointer;
  transition: background-color 0.2s ease;
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.suggestion-item:last-child {
  border-bottom: none;
}

.suggestion-item:hover {
  background-color: rgba(255, 107, 107, 0.1);
}

.suggestion-icon {
  margin-right: 10px;
  font-size: 14px;
  opacity: 0.7;
}

.suggestion-text {
  color: #333;
  font-size: 14px;
  flex: 1;
}

.suggestion-item:hover .suggestion-text {
  color: #ff6b6b;
}
  }

  .login-btn {
    padding: 8px 20px;
    background-color: #ff6b6b;
    color: #fff;
    border-radius: 20px;
    text-decoration: none;
    transition: all 0.3s ease;

    &:hover {
      background-color: #ff5252;
      transform: translateY(-2px);
    }
  }
}

/* 分类栏样式 */
.categories-bar {
  background: linear-gradient(135deg, #fff 0%, #fef7f7 50%, #fff 100%);
  border-bottom: 1px solid #f0f0f0;
  position: sticky;
  top: 68px; /* 导航栏高度 + 一些间距 */
  z-index: 999;
  padding: 0;
  box-shadow: 0 2px 8px rgba(255, 107, 107, 0.05);

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .category-items {
    display: flex;
    list-style: none;
    margin: 0;
    padding: 0;
    flex-wrap: nowrap;
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    scrollbar-width: none;
   
    
    /* 美容主题装饰线条 */
    &::before {
      content: '';
      position: absolute;
      left: 20px;
      right: 20px;
      bottom: 0;
      height: 2px;
      background: linear-gradient(90deg, transparent, #ff6b6b, transparent);
      opacity: 0.3;
    }
  }

  /* 隐藏横向滚动条但保留功能 */
  .category-items::-webkit-scrollbar {
    display: none;
  }
  
  .category-items {
    -ms-overflow-style: none;
  }

  .category-item {
    color: #555;
    text-decoration: none;
    padding: 18px 24px;
    font-size: 18px;
    position: relative;
    white-space: nowrap;
    transition: all 0.3s ease;
    border-radius: 10px;
    margin: 6px 0;
    
    /* 美容主题图标装饰 */
    &::before {
      content: '✦';
      position: absolute;
      left: 10px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 11px;
      color: #ff6b6b;
      opacity: 0;
      transition: all 0.3s ease;
    }

    &:hover {
      background: linear-gradient(135deg, #fff 0%, #ffe6e6 100%);
      color: #ff6b6b;
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(255, 107, 107, 0.2);
      
      &::before {
        opacity: 1;
        left: 14px;
      }
    }

    /* 激活状态样式 - 美容主题 */
    &.active {
      color: #fff;
      font-weight: 600;
      background: linear-gradient(135deg, #ff6b6b 0%, #ff8a8a 100%);
      box-shadow: 0 6px 16px rgba(255, 107, 107, 0.35);
      transform: translateY(-2px);
      
      &::before {
        content: '♥';
        opacity: 1;
        left: 14px;
        color: #fff;
        font-size: 13px;
      }
      
      &::after {
        content: '';
        position: absolute;
        bottom: -7px;
        left: 50%;
        transform: translateX(-50%);
        width: 0;
        height: 0;
        border-left: 7px solid transparent;
        border-right: 7px solid transparent;
        border-top: 7px solid #ff6b6b;
      }
    }
  }

  /* 响应式设计 */
  @media (max-width: 768px) {
    .category-items {
      padding: 12px 0;
      
      &::before {
        left: 15px;
        right: 15px;
      }
    }

    .category-item {
      padding: 15px 20px;
      font-size: 15px;
      margin: 4px 0;
      
      &::before {
        font-size: 10px;
        left: 8px;
      }
      
      &:hover {
        &::before {
          left: 12px;
        }
      }
      
      &.active {
        &::before {
          left: 12px;
          font-size: 12px;
        }
      }
    }
  }
  
  @media (max-width: 480px) {
    .container {
      padding: 0 15px;
    }
    
    .category-item {
      padding: 14px 18px;
      font-size: 14px;
      margin: 3px 0;
    }
  }
}

/* 主导航栏响应式设计 */
@media (max-width: 768px) {
  .navbar .container {
    flex-direction: column;
    gap: 16px;
    padding: 12px 20px;
  }

  .nav-links {
    flex-wrap: wrap;
    justify-content: center;
    gap: 16px;
  }
  
  .search-container {
    margin-left: 0;
    order: -1; /* 在移动端搜索框显示在顶部 */
  }
  
  .search-input {
    width: 200px;
  }
  
  .categories-bar {
    top: 110px; /* 在移动端调整粘性定位 */
  }
}

@media (max-width: 480px) {
  .search-input {
    width: 160px;
    font-size: 13px;
  }
  
  .search-box {
    padding: 6px 10px;
  }
  
  .search-container {
    margin-left: 0;
  }
}
</style>