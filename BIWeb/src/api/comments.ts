import axios from '../utils/axios';

// 添加评论
export async function addComment(params: any): Promise<any> {
  return axios.post('/WebComment/AddComment', params);
}

// 获取评论详情
export async function getCommentsByPage(params: any): Promise<any> {
  return axios.post('/WebComment/GetCommentsByPage', params);
}

