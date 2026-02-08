<template>
  <div class="dashboard">
    <!-- 日期选择区域 -->
    <div class="date-range">
      <el-date-picker
        v-model="dateRange"
        type="daterange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        value-format="YYYY-MM-DD"
        @change="handleDateRangeChange"
        language="zh-CN"
        :picker-options="{
          shortcuts: [
            { text: '今天', onClick: (picker: any) => { const end = new Date(); const start = new Date(); picker.$emit('pick', [start, end]); } },
            { text: '昨天', onClick: (picker: any) => { const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24); picker.$emit('pick', [start, end]); } },
            { text: '最近7天', onClick: (picker: any) => { const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 7); picker.$emit('pick', [start, end]); } },
            { text: '最近30天', onClick: (picker: any) => { const end = new Date(); const start = new Date(); start.setTime(start.getTime() - 3600 * 1000 * 24 * 30); picker.$emit('pick', [start, end]); } }
          ]
        }"
      />
      <div class="quick-dates">
        <el-button size="small" :class="{ active: activeQuickDate === 'today' }" @click="setQuickDate('today')">今日</el-button>
        <el-button size="small" :class="{ active: activeQuickDate === 'yesterday' }" @click="setQuickDate('yesterday')">昨日</el-button>
        <el-button size="small" :class="{ active: activeQuickDate === '7days' }" @click="setQuickDate('7days')">近7天</el-button>
        <el-button size="small" :class="{ active: activeQuickDate === '30days' }" @click="setQuickDate('30days')">近30天</el-button>
      </div>
    </div>

    <!-- 统计卡片 -->
    <el-row :gutter="20" class="dashboard-stats">
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-icon revenue">
            <el-icon><Money /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">¥{{ formatCurrency(stats.countwxMoney + stats.countBookkingMoney) }}</div>
            <div class="stat-label">总销售额</div>
          </div>
        </div>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-icon orders">
            <el-icon><ShoppingCart /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.wxOrderCount + stats.bookkingOrderCount }}</div>
            <div class="stat-label">总订单数</div>
          </div>
        </div>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-icon today-revenue">
            <el-icon><Wallet /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">¥{{ formatCurrency(stats.todayCountWxMoney + stats.todayCountBookkingMoney) }}</div>
            <div class="stat-label">今日销售额</div>
          </div>
        </div>
      </el-col>
      
      <el-col :xs="24" :sm="12" :lg="6">
        <div class="stat-card">
          <div class="stat-icon today-orders">
            <el-icon><Calendar /></el-icon>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.todayWxOrderCount + stats.todayBookkingOrderCount }}</div>
            <div class="stat-label">今日订单数</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- 图表区域 -->
    <el-row :gutter="20" class="dashboard-charts">
      <el-col :xs="24" :lg="16">
        <div class="chart-container">
          <div class="chart-header">
            <h3>销售趋势</h3>
          </div>
          <div ref="chartRef" class="chart-content"></div>
        </div>
      </el-col>
      
     
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Money, ShoppingCart, Wallet, Calendar } from '@element-plus/icons-vue'
import dayjs from 'dayjs'


// 日期范围选择
const dateRange = ref<string[]>([])
const activeQuickDate = ref<string>('today')
 

// 统计数据
const stats = ref({
  totalSales: 0,
  countwxMoney: 0,//微信支付总销售额
  countBookkingMoney: 0,//额度支付总销售额
  todayTotalSales: 0,
  todayCountWxMoney: 0,//今日微信支付销售额
  todayCountBookkingMoney: 0,//今日额度支付销售额
  totalOrders: 0,
  wxOrderCount: 0,//微信支付总订单数
  bookkingOrderCount: 0,//额度支付总订单数
  todayTotalOrders: 0,
  todayWxOrderCount: 0,//今日微信支付总订单数
  todayBookkingOrderCount: 0//今日额度支付总订单数
})


// 用户消费统计数据
const userConsumptionStats = ref([])

// 分页信息
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})




// 格式化货币
const formatCurrency = (value: number | string): string => {
  return parseFloat(String(value)).toFixed(2)
}

 

onMounted(() => {
 
})

// 处理日期范围变化
const handleDateRangeChange = (value: string[]) => {
  dateRange.value = value
  activeQuickDate.value = ''
}

// 设置快速日期选择
const setQuickDate = (type: string) => {
  activeQuickDate.value = type
  const today = new Date()
  const startDate = new Date()
  
  switch (type) {
    case 'today':
      startDate.setHours(0, 0, 0, 0)
      break
    case 'yesterday':
      startDate.setDate(today.getDate() - 1)
      startDate.setHours(0, 0, 0, 0)
      today.setDate(today.getDate() - 1)
      today.setHours(23, 59, 59, 999)
      break
    case '7days':
      startDate.setDate(today.getDate() - 6)
      startDate.setHours(0, 0, 0, 0)
      break
    case '30days':
      startDate.setDate(today.getDate() - 29)
      startDate.setHours(0, 0, 0, 0)
      break
  }
  
  dateRange.value = [
    dayjs(startDate).format('YYYY-MM-DD'),
    dayjs(today).format('YYYY-MM-DD')
  ]
 
}

// 初始化日期为今天
setQuickDate('today')
</script>

<style lang="scss" scoped>
.dashboard {
  padding: 20px;
  
  .date-range {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    
    .quick-dates .el-button {
      margin-left: 10px;
      
      &.active {
        background-color: #409EFF;
        color: #fff;
      }
    }
  }
  
  .dashboard-stats {
    margin-bottom: 20px;
    
    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
      
      .stat-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 15px;
        font-size: 24px;
        color: white;
        
        &.revenue {
          background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
        
        &.orders {
          background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        &.today-revenue {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        &.today-orders {
          background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
      }
      
      .stat-content {
        .stat-number {
          font-size: 24px;
          font-weight: bold;
          color: #303133;
          margin-bottom: 5px;
        }
        
        .stat-label {
          color: #909399;
          font-size: 14px;
        }
      }
    }
  }
  
  .dashboard-charts {
    .chart-container,
    .recent-orders {
      background: white;
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
      
      .chart-header {
        margin-bottom: 20px;
        
        h3 {
          margin: 0;
          color: #303133;
          font-size: 16px;
        }
      }
    }
    
    .chart-content {
      height: 300px;
    }
    
    .order-list {
      .order-item {
        padding: 12px 0;
        border-bottom: 1px solid #f0f0f0;
        
        &:last-child {
          border-bottom: none;
        }
        
        .order-title {
          font-weight: 500;
          color: #303133;
          margin-bottom: 5px;
        }
        
        .order-meta {
          font-size: 12px;
          color: #909399;
          
          span + span {
            margin-left: 10px;
          }
        }
      }
    }
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  
  .dashboard {
    .date-range {
      flex-direction: column;
      align-items: flex-start;
      gap: 10px;
    }
  }
}

@media (max-width: 576px) {
  .dashboard {
    padding: 10px;
  }
}
</style>
