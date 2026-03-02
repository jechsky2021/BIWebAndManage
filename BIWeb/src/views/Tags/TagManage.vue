<template>
  <div class="tag-manage-page">
 

    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <div class="page-header">
          <h1 class="page-title">标签管理</h1>
          <el-button type="primary" @click="handleAdd">
            <el-icon><Plus /></el-icon>
            添加标签
          </el-button>
        </div>

        <!-- 搜索栏 -->
        <div class="search-bar">
          <el-input
            v-model="searchName"
            placeholder="请输入标签名称搜索"
            clearable
            @clear="handleSearch"
            @keyup.enter="handleSearch"
          >
            <template #append>
              <el-button @click="handleSearch">
                <el-icon><Search /></el-icon>
              </el-button>
            </template>
          </el-input>
        </div>

        <!-- 标签列表 -->
        <div class="tag-table-wrapper">
          <el-table
            :data="tagList"
            v-loading="loading"
            stripe
            border
            style="width: 100%"
          >
            <el-table-column prop="id" label="ID" width="80" align="center" />
            <el-table-column prop="name" label="标签名称" min-width="200" />
            <el-table-column prop="createTime" label="创建时间" width="180" align="center">
              <template #default="{ row }">
                {{ row.createTime ? dayjs(row.createTime).format('YYYY-MM-DD HH:mm:ss') : '-' }}
              </template>
            </el-table-column>
            <el-table-column label="操作" width="200" align="center" fixed="right">
              <template #default="{ row }">
                <span class="action-link edit-link" @click="handleEdit(row)">
                  编辑
                </span>
                <span class="action-link delete-link" @click="handleDelete(row)">
                  删除
                </span>
              </template>
            </el-table-column>
          </el-table>
        </div>

        <!-- 分页 -->
        <div class="pagination-wrapper">
          <el-pagination
            v-model:current-page="currentPage"
            v-model:page-size="pageSize"
            :page-sizes="[10, 20, 50, 100]"
            :total="total"
            layout="total, sizes, prev, pager, next, jumper"
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>
    </main>

    <!-- 标签对话框（添加/编辑共用） -->
    <el-dialog
      v-model="showDialog"
      :title="isEdit ? '编辑标签' : '添加标签'"
      width="500px"
      :close-on-click-modal="false"
    >
      <el-form :model="formData" :rules="formRules" ref="formRef" label-width="80px">
        <el-form-item label="标签名称" prop="name">
          <el-input
            v-model="formData.name"
            placeholder="请输入标签名称"
            maxlength="20"
            show-word-limit
          />
        </el-form-item>
        <el-form-item label="标签描述" prop="description">
          <el-input
            v-model="formData.description"
            type="textarea"
            placeholder="请输入标签描述"
            :rows="3"
            maxlength="200"
            show-word-limit
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showDialog = false">取消</el-button>
          <el-button type="primary" @click="handleSubmit" :loading="submitLoading">
            确定
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';
import { ElMessage, ElMessageBox } from 'element-plus';
import { Plus, Search } from '@element-plus/icons-vue';
import type { FormInstance, FormRules } from 'element-plus';
import {
  getTagsByPage,
  addTag,
  updateTag,
  deleteTag,
  getTagByName
} from '../../api/tags';
import dayjs from 'dayjs';

const router = useRouter();

// 列表数据
const tagList = ref<any[]>([]);
const loading = ref(false);
const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(0);
const searchName = ref('');

// 标签对话框（添加/编辑共用）
const showDialog = ref(false);
const isEdit = ref(false);
const formRef = ref<FormInstance>();
const submitLoading = ref(false);
const formData = ref({
  id: 0,
  name: '',
  description: ''
});
const formRules = ref<FormRules>({
  name: [
    { required: true, message: '请输入标签名称', trigger: 'blur' },
    { min: 1, max: 20, message: '标签名称长度在 1 到 20 个字符', trigger: 'blur' }
  ]
});

// 加载标签列表
const loadTags = async () => {
  try {
    loading.value = true;
    const params: any = {
      pageNumber: currentPage.value,
      pageSize: pageSize.value
    };
    
    if (searchName.value) {
      params.name = searchName.value;
    }
    
    const response = await getTagsByPage(params);
    
    if (response.sign === '1' && response.data) {
      tagList.value = response.data.lists || [];
      total.value = response.data.total || 0;
    } else {
      ElMessage.error(response.msg || '获取标签列表失败');
    }
  } catch (error) {
    console.error('获取标签列表失败:', error);
    ElMessage.error('获取标签列表失败，请稍后重试');
  } finally {
    loading.value = false;
  }
};

// 搜索
const handleSearch = () => {
  currentPage.value = 1;
  loadTags();
};

// 分页事件
const handleSizeChange = (val: number) => {
  pageSize.value = val;
  currentPage.value = 1;
  loadTags();
};

const handleCurrentChange = (val: number) => {
  currentPage.value = val;
  loadTags();
};

// 打开添加对话框
const handleAdd = () => {
  isEdit.value = false;
  formData.value = {
    id: 0,
    name: '',
    description: ''
  };
  showDialog.value = true;
};

// 打开编辑对话框
const handleEdit = (row: any) => {
  isEdit.value = true;
  formData.value = {
    id: row.id,
    name: row.name,
    description: row.description || ''
  };
  showDialog.value = true;
};

// 提交表单（添加/编辑共用）
const handleSubmit = async () => {
  if (!formRef.value) return;
  
  try {
    await formRef.value.validate();
    submitLoading.value = true;
    
    if (isEdit.value) {
      // 编辑模式
      const response = await updateTag({
        id: formData.value.id,
        name: formData.value.name,
        description: formData.value.description
      });
      
      if (response.sign === '1') {
        ElMessage.success('标签更新成功！');
        showDialog.value = false;
        formData.value = { id: 0, name: '', description: '' };
        formRef.value.resetFields();
        loadTags();
      } else {
        ElMessage.error(response.msg || '标签更新失败');
      }
    } else {
      // 添加模式
      // 先检查标签是否已存在
      const checkResponse = await getTagByName({ name: formData.value.name });
      
      if (checkResponse.sign === '1' && checkResponse.data) {
        const count = checkResponse.data.count || 0;
        if (count > 0) {
          ElMessage.warning('该标签名称已存在');
          submitLoading.value = false;
          return;
        }
      }
      
      // 添加标签
      const response = await addTag({ 
        name: formData.value.name,
        description: formData.value.description 
      });
      
      if (response.sign === '1') {
        ElMessage.success('标签添加成功！');
        showDialog.value = false;
        formData.value = { id: 0, name: '', description: '' };
        formRef.value.resetFields();
        loadTags();
      } else {
        ElMessage.error(response.msg || '标签添加失败');
      }
    }
    
    submitLoading.value = false;
  } catch (error) {
    console.error(isEdit.value ? '更新标签失败:' : '添加标签失败:', error);
    ElMessage.error(isEdit.value ? '更新标签失败，请稍后重试' : '添加标签失败，请稍后重试');
    submitLoading.value = false;
  }
};

// 删除标签
const handleDelete = async (row: any) => {
  try {
    await ElMessageBox.confirm(
      `确定要删除标签 "${row.name}" 吗？`,
      '确认删除',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    );
    
    const response = await deleteTag({ id: row.id });
    
    if (response.sign === '1') {
      ElMessage.success('标签删除成功！');
      loadTags();
    } else {
      ElMessage.error(response.msg || '标签删除失败');
    }
  } catch (error: any) {
    if (error !== 'cancel') {
      console.error('删除标签失败:', error);
      ElMessage.error('删除标签失败，请稍后重试');
    }
  }
};

onMounted(() => {
  loadTags();
});
</script>

<style lang="scss" scoped>
.tag-manage-page {
  min-height: 100vh;
  background-color: #f8f8f8;
}

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
    max-width: 1400px;
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

    &:hover,
    &.active {
      color: #ff6b6b;
    }

    &.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 20px;
      height: 3px;
      background-color: #ff6b6b;
      border-radius: 2px;
    }
  }
}

/* 主内容区 */
.main-content {
  padding: 30px 0;

  .container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }
}

/* 页面标题 */
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;

  .page-title {
    font-size: 24px;
    font-weight: 600;
    color: #333;
    margin: 0;
  }
}

/* 搜索栏 */
.search-bar {
  max-width: 400px;
  margin-bottom: 24px;
}

/* 表格区域 */
.tag-table-wrapper {
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
  margin-bottom: 24px;
}

/* 分页 */
.pagination-wrapper {
  display: flex;
  justify-content: flex-end;
}

/* 对话框底部 */
.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
}

/* 对话框样式 - 与整体网站保持一致 */
:deep(.el-dialog) {
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
}

:deep(.el-dialog__header) {
  border-bottom: 1px solid #f0f0f0;
  padding: 20px;
  background-color: #fff;

  .el-dialog__title {
    font-size: 18px;
    font-weight: 500;
    color: #333;
  }
}

:deep(.el-dialog__body) {
  padding: 20px;
  background-color: #fff;
}

:deep(.el-dialog__footer) {
  border-top: 1px solid #f0f0f0;
  padding: 20px;
  background-color: #fff;
}

/* 表单样式 - 与整体网站保持一致 */
:deep(.el-form-item__label) {
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

:deep(.el-input__wrapper) {
  border-radius: 8px;
  box-shadow: 0 0 0 1px #e0e0e0 inset;
  transition: all 0.3s ease;
  background-color: #fff;

  &.is-focus {
    box-shadow: 0 0 0 1px #ff6b6b inset;
    background-color: #fff;
  }
}

:deep(.el-input__inner:focus) {
  box-shadow: none;
}

:deep(.el-input__inner) {
  font-size: 14px;
  color: #333;
}

:deep(.el-textarea__inner) {
  border-radius: 8px;
  font-size: 14px;
  color: #333;
  resize: vertical;
}

/* 按钮样式 - 与整体网站保持一致 */
:deep(.el-button) {
  border-radius: 8px;
  padding: 8px 16px;
  font-size: 14px;
  transition: all 0.3s ease;

  &.el-button--primary {
    background-color: #ff6b6b;
    border-color: #ff6b6b;

    &:hover {
      background-color: #ff5252;
      border-color: #ff5252;
      transform: translateY(-2px);
    }
  }
}

/* 表格样式 - 与整体网站保持一致 */
:deep(.el-table) {
  border-radius: 8px;
  overflow: hidden;

  .el-table__header-wrapper {
    th {
      background-color: #f8f8f8;
      color: #333;
      font-weight: 600;
    }
  }

  .el-table__row {
    transition: all 0.3s ease;

    &:hover {
      background-color: #fff5f5;
    }
  }
}

/* 搜索栏样式 */
.search-bar {
  :deep(.el-input__wrapper) {
    border-radius: 8px 0 0 8px;
  }

  :deep(.el-input-group__append) {
    border-radius: 0 8px 8px 0;
    background-color: #ff6b6b;
    border-color: #ff6b6b;

    .el-button {
      color: #fff;
      border: none;
      background: transparent;

      &:hover {
        background-color: #ff5252;
      }
    }
  }
}

/* 操作链接样式 */
.action-link {
  cursor: pointer;
  font-size: 14px;
  margin: 0 8px;
  transition: all 0.3s ease;

  &:hover {
    opacity: 0.8;
  }
}

.edit-link {
  color: #ff6b6b;

  &:hover {
    color: #ff5252;
  }
}

.delete-link {
  color: #f56c6c;

  &:hover {
    color: #f23c3c;
  }
}

/* 分页样式 */
:deep(.el-pagination) {
  .el-pagination__total {
    color: #666;
  }

  .el-pagination__sizes {
    .el-input__wrapper {
      border-radius: 4px;
    }
  }

  .el-pager li {
    border-radius: 4px;

    &.active {
      background-color: #ff6b6b;
    }

    &:hover {
      color: #ff6b6b;
    }
  }

  .btn-prev, .btn-next {
    border-radius: 4px;

    &:hover {
      color: #ff6b6b;
    }
  }
}

/* 响应式 */
@media (max-width: 768px) {
  .navbar {
    .container {
      flex-direction: column;
      gap: 16px;
    }
  }

  .page-header {
    flex-direction: column;
    gap: 16px;
    align-items: flex-start;
  }

  .search-bar {
    max-width: 100%;
  }
}
</style>
