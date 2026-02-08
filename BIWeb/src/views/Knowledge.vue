<template>
  <div class="knowledge">
   
    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <!-- <h1 class="page-title">美业知识库</h1> -->

        <!-- 分类导航 -->
        <div class="app-categories">
          <button v-for="category in categories" :key="category.key"
            :class="['category-btn', { active: activeCategory === category.key }]"
            @click="activeCategory = category.key">
            {{ category.name }}
          </button>
        </div>

        <!-- 知识模块 - 使用统一组件，通过不同数据渲染 -->
        <div class="knowledge-section">
          <knowledge-module 
            :knowledge-data="getCurrentKnowledge()"
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
import { ref, computed } from 'vue';
import KnowledgeModule from '../components/KnowledgeModule.vue';

interface Category {
  key: string;
  name: string;
}

interface KnowledgeItem {
  id: number;
  title: string;
  summary: string;
  publishDate: string;
  readCount: number;
}

const activeCategory = ref('perm'); // 默认显示烫发分类
const activeFilter = ref('latest'); // 默认显示最新

const categories: Category[] = [
  { key: 'perm', name: '烫发' },
  { key: 'hairDyeing', name: '染发' },
  { key: 'shampoo', name: '洗发' },
  { key: 'haircut', name: '剪发' },
  { key: 'blowDry', name: '吹发' }
];

// 颜色数组，用于知识卡片的背景色
const colors = [
  '#FF6B6B', '#4ECDC4', '#45B7D1', '#F9CA24', '#6C5CE7',
  '#00B894', '#E17055', '#FD79A8', '#FDCB6E', '#6C5CE7'
];

// 烫发知识数据 - 增加到15条
const permKnowledge: KnowledgeItem[] = [
  { id: 1, title: '冷烫与热烫的区别及适用发质', summary: '详细解析冷烫与热烫的技术原理、效果差异及适合的发质类型，帮助美发师选择正确的烫发方式。', publishDate: '2025-01-15', readCount: 2580 },
  { id: 2, title: '烫发药水的选择与调配技巧', summary: '介绍不同品牌烫发药水的特性，以及如何根据客户需求正确调配烫发药水比例，确保烫发效果。', publishDate: '2025-01-10', readCount: 1890 },
  { id: 3, title: '受损发质的烫发修复技术', summary: '针对受损发质的特殊烫发处理方法，包括预处理步骤、药水选择和后期护理建议。', publishDate: '2025-01-05', readCount: 3240 },
  { id: 4, title: '烫发杠具的选择与排列技巧', summary: '详解各种烫发杠具的特点及适用场景，以及如何通过不同的排列方式创造多样化的烫发效果。', publishDate: '2025-10-28', readCount: 2150 },
  { id: 21, title: '烫发前的头发预处理技术', summary: '介绍烫发前的深层清洁、去角质和营养护理步骤，为烫发做好充分准备。', publishDate: '2025-01-16', readCount: 1760 },
  { id: 22, title: '烫发过程中的温度控制要点', summary: '详细说明冷烫和热烫过程中的温度监控和调节技巧，确保烫发过程的安全性。', publishDate: '2025-01-11', readCount: 2120 },
  { id: 23, title: '烫发后护理与造型维护', summary: '分享烫发后的专业护理产品和造型技巧，帮助客户保持最佳烫发效果。', publishDate: '2025-01-06', readCount: 2680 },
  { id: 24, title: '个性化烫发设计方案', summary: '根据客户脸型、发质和生活习惯，制定个性化烫发方案的设计思路和方法。', publishDate: '2025-01-02', readCount: 1950 },
  { id: 25, title: '烫发失败后的紧急修复方案', summary: '提供烫发失败或效果不理想时的紧急处理方法和修复技巧。', publishDate: '2024-12-28', readCount: 3420 },
  { id: 26, title: '季节性烫发护理指南', summary: '根据春夏秋冬四季的不同特点，提供相应的烫发护理建议和注意事项。', publishDate: '2024-12-25', readCount: 2890 },
  { id: 27, title: '烫发设备维护与保养', summary: '详细介绍烫发设备的日常维护方法，延长设备使用寿命并确保安全。', publishDate: '2024-12-20', readCount: 1580 },
  { id: 28, title: '高级烫发造型技术', summary: '讲解进阶烫发造型技巧，包括创意纹理处理和特殊效果创造。', publishDate: '2024-12-15', readCount: 2240 },
  { id: 29, title: '烫发服务的客户沟通技巧', summary: '提升烫发服务质量，掌握与客户沟通需求、预期效果的专业技巧。', publishDate: '2024-12-10', readCount: 1870 },
  { id: 30, title: '环保烫发技术的应用', summary: '介绍环保型烫发产品和技术，平衡效果与环境保护的现代美发理念。', publishDate: '2024-12-05', readCount: 2330 },
  { id: 31, title: '烫发成本控制与利润分析', summary: '帮助美发师了解烫发服务的成本构成，制定合理的价格策略。', publishDate: '2024-11-30', readCount: 1420 }
];

// 染发知识数据 - 增加到15条
const hairDyeKnowledge: KnowledgeItem[] = [
  { id: 1, title: '色彩理论与染发基础', summary: '详细介绍色彩搭配原理、三原色应用及染发配色的基本知识，为专业染发奠定理论基础。', publishDate: '2025-01-14', readCount: 3120 },
  { id: 2, title: '染发剂选择与调配技巧', summary: '全面介绍各类染发剂的特性、使用方法和调配比例，帮助美发师选择合适的染发产品。', publishDate: '2025-01-09', readCount: 2750 },
  { id: 3, title: '漂发技术与头发保护', summary: '讲解专业漂发技术流程，包括头发保护措施、漂发时间控制和安全注意事项。', publishDate: '2025-01-04', readCount: 4210 },
  { id: 4, title: '渐变染与创意染发技巧', summary: '教授渐变染、挑染、片染等多种创意染发技术的操作方法和效果设计。', publishDate: '2025-10-29', readCount: 3680 },
  { id: 41, title: '染发前的头发评估方法', summary: '详细介绍如何评估客户发质状况，选择最适合的染发方案和安全的产品。', publishDate: '2025-01-15', readCount: 2890 },
  { id: 42, title: '白发遮盖的专业技术', summary: '针对白发染色的特殊处理方法，包括颜色选择、染发间隔和遮盖技巧。', publishDate: '2025-01-10', readCount: 4250 },
  { id: 43, title: '染发后护理与固色方法', summary: '分享染发后的专业护理产品和固色技巧，延长染发效果保持时间。', publishDate: '2025-01-05', readCount: 3520 },
  { id: 44, title: '多色混合染发创意技法', summary: '教授如何运用多种颜色创造独特染发效果，包括三色、四色混合技巧。', publishDate: '2025-01-01', readCount: 2970 },
  { id: 45, title: '染发过敏预防与处理', summary: '详细介绍染发前的过敏测试方法，预防染发过敏反应的应急处理。', publishDate: '2024-12-27', readCount: 5680 },
  { id: 46, title: '季节性染发色彩推荐', summary: '根据春夏秋冬四季特点，推荐相应的染发色彩和时尚搭配方案。', publishDate: '2024-12-24', readCount: 3160 },
  { id: 47, title: '染发设备与工具的正确使用', summary: '详细介绍染发所需的各类设备和工具，确保染发过程的标准化操作。', publishDate: '2024-12-19', readCount: 2340 },
  { id: 48, title: '染发服务的全程管理', summary: '从客户咨询到后期跟进，提升染发服务全过程的专业化管理水平。', publishDate: '2024-12-14', readCount: 2890 },
  { id: 49, title: '环保染发技术的应用', summary: '介绍环保型染发产品和技术，在保证效果的同时关注环境保护。', publishDate: '2024-12-09', readCount: 2250 },
  { id: 50, title: '染发成本控制与盈利分析', summary: '分析染发服务的成本构成，提供提高盈利能力的定价策略建议。', publishDate: '2024-12-04', readCount: 1780 },
  { id: 51, title: '染发新趋势与时尚解析', summary: '分析2025年染发新趋势，包括流行色彩、染发技术和创意设计理念。', publishDate: '2024-11-29', readCount: 3450 }
];

// 洗发知识数据
const shampooKnowledge: KnowledgeItem[] = [
  { id: 9, title: '不同发质的洗发产品选择', summary: '详解干性、油性、中性、混合性和受损发质的特点，以及如何选择最适合的洗发水和护发素。', publishDate: '2025-01-12', readCount: 2380 },
  { id: 10, title: '科学洗发方法与频率建议', summary: '介绍正确的洗发步骤、水温控制及根据不同发质推荐的洗发频率，避免过度清洁导致的问题。', publishDate: '2025-01-06', readCount: 3520 },
  { id: 11, title: '头皮护理的专业知识', summary: '深入讲解头皮健康的重要性，常见头皮问题的成因及护理方法，包括产品推荐和按摩技巧。', publishDate: '2025-01-01', readCount: 4120 },
  { id: 12, title: '洗发后的正确护理步骤', summary: '分享洗发后的护发素使用、毛巾擦干、吹干等关键步骤的正确方法，减少头发损伤。', publishDate: '2025-10-26', readCount: 2890 }
];

// 剪发知识数据
const haircutKnowledge: KnowledgeItem[] = [
  { id: 1, title: '发型设计与脸型搭配', summary: '详细介绍各种脸型的特点，教授如何根据客户脸型设计最适合的发型。', publishDate: '2025-01-12', readCount: 3520 },
  { id: 2, title: '基础剪发技术与手法', summary: '系统讲解剪发的基本手法、工具使用和标准操作流程。', publishDate: '2025-01-07', readCount: 2980 },
  { id: 3, title: '层次剪发的技巧与艺术', summary: '深入教授层次剪发的各种技法，包括经典层次、空气层次等流行款式。', publishDate: '2025-01-02', readCount: 4250 },
  { id: 4, title: '男士发型的现代剪裁', summary: '介绍当代男士发型的流行趋势和剪裁技巧，满足男性客户的多元化需求。', publishDate: '2025-10-26', readCount: 3840 },
  { id: 81, title: '剪发前的咨询与设计沟通', summary: '提升剪发服务质量，掌握与客户沟通需求、设计预期的专业技巧。', publishDate: '2025-01-15', readCount: 2670 },
  { id: 82, title: '儿童剪发的特殊技巧', summary: '针对儿童的特点，提供安全有趣的儿童剪发服务和技巧分享。', publishDate: '2025-01-10', readCount: 3150 },
  { id: 83, title: '染发与剪发的完美结合', summary: '介绍如何将染发与剪发技术相结合，创造整体发型设计的最佳效果。', publishDate: '2025-01-05', readCount: 3890 },
  { id: 84, title: '专业剪发工具的使用与维护', summary: '详细介绍各种剪发工具的性能特点、正确使用方法和日常维护。', publishDate: '2025-01-01', readCount: 2450 },
  { id: 85, title: '剪发失败后的修复技术', summary: '提供剪发失误后的紧急处理方法和修复技巧，挽回发型效果。', publishDate: '2024-12-25', readCount: 4980 },
  { id: 86, title: '剪发成本与盈利能力分析', summary: '分析剪发服务的成本构成，提供提高盈利能力的定价策略建议。', publishDate: '2024-12-22', readCount: 1890 },
  { id: 87, title: '季节性发型设计与建议', summary: '根据春夏秋冬四季特点，提供相应的发型设计建议和剪裁方案。', publishDate: '2024-12-17', readCount: 3240 },
  { id: 88, title: '剪发服务的卫生与安全管理', summary: '建立专业的卫生标准和安全管理流程，确保剪发服务的安全性。', publishDate: '2024-12-12', readCount: 2560 },
  { id: 89, title: '潮流发型趋势解析', summary: '分析2025年发型流行趋势，包括短发、长发、卷发等各种风格走向。', publishDate: '2024-12-07', readCount: 3670 },
  { id: 90, title: '剪发艺术的创意表达', summary: '探索剪发的艺术性和创意性，培养美发师的艺术审美和创新能力。', publishDate: '2024-12-02', readCount: 2980 },
  { id: 91, title: '剪发服务的标准化运营', summary: '建立标准化的剪发服务流程，提升服务效率和客户满意度。', publishDate: '2024-11-27', readCount: 2150 }
];

// 吹发知识数据
const blowDryKnowledge: KnowledgeItem[] = [
  { id: 17, title: '专业吹发工具选择与使用', summary: '介绍不同类型吹风机、风嘴、梳子的特点及适用场景，帮助美发师选择合适的工具。', publishDate: '2025-01-11', readCount: 2650 },
  { id: 18, title: '吹出持久卷度的技巧', summary: '详细讲解如何通过正确的手法、温度控制和产品使用，吹出持久自然的卷发效果。', publishDate: '2025-01-04', readCount: 3980 },
  { id: 19, title: '直发造型的吹发方法', summary: '分享打造顺滑亮丽直发的专业技巧，包括吹发方向、温度设置和产品搭配。', publishDate: '2025-12-30', readCount: 3250 },
  { id: 20, title: '减少热损伤的吹发技巧', summary: '介绍如何在吹发过程中最大程度减少热损伤，包括温度控制、距离保持和防护产品使用。', publishDate: '2025-10-24', readCount: 2790 }
];

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

// 获取当前分类的知识数据
const getCurrentKnowledge = () => {
  const categoryMap: Record<string, KnowledgeItem[]> = {
    perm: permKnowledge,
    hairDyeing: hairDyeKnowledge,
    shampoo: shampooKnowledge,
    haircut: haircutKnowledge,
    blowDry: blowDryKnowledge
  };
  return categoryMap[activeCategory.value] || [];
};

// 获取当前分类的标签
const getCurrentTags = () => {
  const tagsMap: Record<string, string[]> = {
    perm: permTags,
    hairDyeing: hairDyeingTags,
    shampoo: shampooTags,
    haircut: haircutTags,
    blowDry: blowDryTags
  };
  return tagsMap[activeCategory.value] || [];
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

// 获取过滤后的知识数据
const filteredKnowledge = computed(() => {
  // 首先获取当前分类的数据
  const currentData = getCurrentKnowledge();
  
  // 根据activeFilter进行排序或过滤
  let sortedData = [...currentData];
  
  switch (activeFilter.value) {
    case 'latest':
      // 按发布日期排序（最新的在前）
      sortedData.sort((a, b) => new Date(b.publishDate).getTime() - new Date(a.publishDate).getTime());
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
});
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
  max-width: 1200px;
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
  -webkit-line-clamp: 2;
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
  -webkit-line-clamp: 3;
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