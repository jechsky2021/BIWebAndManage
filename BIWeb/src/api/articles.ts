import axios from '../utils/axios';

// 获取文章列表
export async function getArticlesByPage(params: any): Promise<any> {
  return axios.post('/WebArticle/GetLastByPage', params);
}

// 获取文章详情
export async function getArticlesById(params: any): Promise<any> {
  return axios.post('/WebArticle/GetDetailById', params);
}

// 搜索网站
export async function getSearchArticles(params: any): Promise<any> {
  return axios.post('/WebArticle/GetSearchArticles', params);
}

// 更新文章点赞数
export async function updateArticleLikes(params: any): Promise<any> {
  return axios.post('/WebArticle/UpdateArticleLikes', params);
}
// 获取用户文章点赞数
export async function getUidAid(params: any): Promise<any> {
  return axios.post('/WebArticle/GetUidAid', params);
}
// 取消文章点赞数
export async function cancelArticleLikes(params: any): Promise<any> {
  return axios.post('/WebArticle/CancelArticleLikes', params);
}

// 获取用户点赞的文章列表
export async function getMyArticleLikes(params: any): Promise<any> {
  return axios.post('/WebArticle/GetMyArticleLikes', params);
}
