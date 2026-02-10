<template>
  <div class="knowledge-module">
    <!-- 统一的知识模块 -->
    
    <!-- <div class="section-header">
            <h2 class="section-title">吹发知识</h2>
            <p class="section-description">专业吹发技巧、造型方法和工具选择</p>
          </div> -->

    <!-- 筛选和排序 -->
    <div class="filter-bar">
      <div class="filter-options">
        <button 
          v-for="filter in filters" 
          :key="filter.key"
          :class="['filter-btn', { active: activeFilter === filter.key }]" 
          @click="$emit('update:activeFilter', filter.key)"
        >
          {{ filter.name }}
        </button>
      </div>
    </div> 
    
    <!-- 知识卡片列表 -->
    <div class="knowledge-grid">
      <router-link 
        v-for="item in paginatedKnowledge" 
        :key="item.id" 
        :to="'/article/' + item.id" 
        class="knowledge-card"
      >
        <div class="card-image">
          <div class="image-placeholder" :style="{ backgroundColor: colors[item.id % colors.length] }">
            {{ item.title.charAt(0) }}
          </div>
        </div>
        <div class="card-content">
          <h3 class="card-title">{{ item.title }}</h3>
          <p class="card-summary">{{ item.introduce }}</p>
          <div class="card-meta">
            <span class="publish-date">{{ dayjsFormat(item.createTime) }}</span>
            <span class="read-count">阅读 {{ item.pageViews }}</span>
          </div>
        </div>
      </router-link>
    </div>
    
    <!-- 分页控件 -->
    <div v-if="totalPages > 1" class="pagination">
      <button 
        class="page-btn" 
        :disabled="currentPage === 1"
        @click="goToPage(1)"
        title="第一页"
      >
        首页
      </button>
      <button 
        class="page-btn" 
        :disabled="currentPage === 1"
        @click="goToPage(currentPage - 1)"
        title="上一页"
      >
        上一页
      </button>
      <span class="page-info">{{ currentPage }} / {{ totalPages }}</span>
      <button 
        class="page-btn" 
        :disabled="currentPage === totalPages"
        @click="goToPage(currentPage + 1)"
        title="下一页"
      >
        下一页
      </button>
      <button 
        class="page-btn" 
        :disabled="currentPage === totalPages"
        @click="goToPage(totalPages)"
        title="最后一页"
      >
        末页
      </button>
    </div>
    
    <!-- 页码快速跳转 -->
    <div v-if="totalPages > 5" class="page-jump">
      <span>跳转到</span>
      <input 
        v-model.number="jumpPage" 
        type="number" 
        :min="1" 
        :max="totalPages"
        @keyup.enter="jumpToPage()"
        class="page-input"
      />
      <span>页</span>
      <button class="jump-btn" @click="jumpToPage()">确定</button>
    </div>
    
    <!-- 热门标签 -->
    <!-- <div v-if="tags && tags.length > 0" class="popular-tags">
      <h3>热门标签</h3>
      <div class="tags-container">
        <span v-for="tag in tags" :key="tag" class="tag" @click="$emit('tag-click', tag)">{{ tag }}</span>
      </div>
    </div> -->
  </div>
</template>

<script>
import dayjs from 'dayjs';

export default {
  name: 'KnowledgeModule',
  props: {
    // 知识数据
    knowledgeData: {
      type: Array,
      required: true
    },
    // 当前激活的过滤器
    activeFilter: {
      type: String,
      default: 'latest'
    },
    // 过滤器选项
    filters: {
      type: Array,
      default: () => [
        { key: 'latest', name: '最新' },
        { key: 'hottest', name: '最热' },
        { key: 'recommended', name: '推荐' }
      ]
    },
    // 颜色数组
    colors: {
      type: Array,
      default: () => [
        '#FF6B6B', '#4ECDC4', '#45B7D1', '#F9CA24', '#6C5CE7',
        '#00B894', '#E17055', '#FD79A8', '#FDCB6E', '#6C5CE7'
      ]
    },
    // 标签数据
    tags: {
      type: Array,
      default: () => []
    },
    // 每页显示条数
    pageSize: {
      type: Number,
      default: 10
    }
  },
  data() {
    return {
      currentPage: 1, // 当前页码
      jumpPage: 1     // 跳转页码
    }
  },
  computed: {
    // 获取过滤后的知识数据
    filteredKnowledge() {
      // 确保knowledgeData是数组
      const data = Array.isArray(this.knowledgeData) ? this.knowledgeData : [];
      // 根据activeFilter进行排序或过滤
      let sortedData = [...data];
      
      switch (this.activeFilter) {
        case 'latest':
          // 按发布日期排序（最新的在前）
          sortedData.sort((a, b) => new Date(b.publishDate) - new Date(a.publishDate));
          break;
        case 'hottest':
          // 按阅读量排序（最多的在前）
          sortedData.sort((a, b) => b.readCount - a.readCount);
          break;
        case 'recommended':
          // 推荐排序（这里可以根据自定义逻辑，比如结合阅读量和日期的加权）
          // 这里简化为：阅读量高于2500的排在前面
          sortedData.sort((a, b) => {
            if (a.readCount >= 2500 && b.readCount < 2500) return -1;
            if (a.readCount < 2500 && b.readCount >= 2500) return 1;
            return b.readCount - a.readCount;
          });
          break;
      }
      
      return sortedData;
    },
    
    // 总页数
    totalPages() {
      return Math.ceil(this.filteredKnowledge.length / this.pageSize)
    },
    
    // 分页后的知识数据
    paginatedKnowledge() {
      const start = (this.currentPage - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.filteredKnowledge.slice(start, end);
    }
  },
  
  methods: {
    dayjsFormat(date) {
      return dayjs(date).format('YYYY-MM-DD HH:mm:ss');
    },
    // 跳转到指定页面
    goToPage(page) {
      if (page >= 1 && page <= this.totalPages) {
        this.currentPage = page;
        this.jumpPage = page;
        
        // 滚动到顶部
        this.$el.scrollIntoView({ behavior: 'smooth', block: 'start' });
        
        // 发出页面切换事件
        this.$emit('page-change', {
          currentPage: this.currentPage,
          totalPages: this.totalPages,
          pageSize: this.pageSize
        });
      }
    },
    
    // 快速跳转到指定页面
    jumpToPage() {
      this.goToPage(this.jumpPage);
    }
  },
  
  watch: {
    // 监听筛选条件变化，重置到第一页
    activeFilter() {
      if (this.currentPage !== 1) {
        this.currentPage = 1;
        this.jumpPage = 1;
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.knowledge-module {
  .filter-bar {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 25px;
    padding: 15px 0;
    border-bottom: 1px solid #eee;

    .filter-options {
      display: flex;
      gap: 12px;
      background: rgba(255, 255, 255, 0.1);
      padding: 8px;
      border-radius: 25px;
      backdrop-filter: blur(10px);
      
      .filter-btn {
        padding: 10px 20px;
        border: none;
        background: transparent;
        color: #666;
        border-radius: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
        font-size: 14px;
        
        &.active {
          background: linear-gradient(135deg, #ff6b6b, #ff8a8a);
          color: white;
          box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
        }
        
        &:hover:not(.active) {
          background: rgba(255, 107, 107, 0.1);
          color: #ff6b6b;
        }
      }
    }
  }
  
  .knowledge-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 24px;
    margin-bottom: 40px;
    
    .knowledge-card {
      background: white;
      border-radius: 16px;
      overflow: hidden;
      text-decoration: none;
      color: inherit;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
      transition: all 0.3s ease;
      display: block;
      
      &:hover {
        transform: translateY(-8px);
        box-shadow: 0 12px 40px rgba(0, 0, 0, 0.15);
      }
      
      .card-image {
        height: 200px;
        overflow: hidden;
        
        .image-placeholder {
          width: 100%;
          height: 100%;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 48px;
          font-weight: bold;
          color: white;
        }
      }
      
      .card-content {
        padding: 20px;
        
        .card-title {
          font-size: 18px;
          font-weight: 600;
          margin: 0 0 12px 0;
          color: #333;
          line-height: 1.4;
        }
        
        .card-summary {
          font-size: 14px;
          color: #666;
          line-height: 1.6;
          margin: 0 0 16px 0;
          display: -webkit-box;
          -webkit-box-orient: vertical;
          overflow: hidden;
        }
        
        .card-meta {
          display: flex;
          justify-content: space-between;
          align-items: center;
          font-size: 12px;
          color: #999;
          
          .read-count {
            color: #ff6b6b;
            font-weight: 500;
          }
        }
      }
    }
  }
  
  .popular-tags {
    margin-top: 40px;
    
    h3 {
      font-size: 18px;
      font-weight: 600;
      margin: 0 0 16px 0;
      color: #333;
      text-align: center;
    }
    
    .tags-container {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      justify-content: center;
      
      .tag {
        padding: 6px 12px;
        background: rgba(255, 107, 107, 0.1);
        color: #ff6b6b;
        border-radius: 20px;
        font-size: 12px;
        cursor: pointer;
        transition: all 0.3s ease;
        
        &:hover {
          background: #ff6b6b;
          color: white;
          transform: translateY(-2px);
        }
      }
    }
  }
  
  /* 分页控件样式 */
  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin: 40px 0;
    padding: 20px;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 16px;
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    
    .page-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background: white;
      border-radius: 8px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
      color: #666;
      
      &:hover:not(:disabled) {
        border-color: #ff6b6b;
        color: #ff6b6b;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.2);
      }
      
      &:disabled {
        opacity: 0.5;
        cursor: not-allowed;
        transform: none;
      }
      
      &:active:not(:disabled) {
        transform: translateY(0);
      }
    }
    
    .page-info {
      padding: 8px 16px;
      background: linear-gradient(135deg, #ff6b6b, #ff8a8a);
      color: white;
      border-radius: 8px;
      font-weight: 500;
      font-size: 14px;
    }
  }
  
  /* 页码跳转样式 */
  .page-jump {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin: 20px 0;
    padding: 16px;
    background: rgba(255, 255, 255, 0.8);
    border-radius: 12px;
    backdrop-filter: blur(10px);
    
    span {
      font-size: 14px;
      color: #666;
    }
    
    .page-input {
      width: 60px;
      padding: 6px 8px;
      border: 1px solid #ddd;
      border-radius: 6px;
      text-align: center;
      font-size: 14px;
      
      &:focus {
        outline: none;
        border-color: #ff6b6b;
        box-shadow: 0 0 0 2px rgba(255, 107, 107, 0.2);
      }
    }
    
    .jump-btn {
      padding: 6px 12px;
      background: #ff6b6b;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
      
      &:hover {
        background: #ff5252;
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(255, 107, 107, 0.3);
      }
      
      &:active {
        transform: translateY(0);
      }
    }
  }
}
</style>