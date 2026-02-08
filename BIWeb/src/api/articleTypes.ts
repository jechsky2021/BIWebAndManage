import axios from '../utils/axios';

// 获取分类
export async function getArticleTypeByPage(params: any): Promise<any> {
  return axios.post('/WebArticleType/GetWebArticleTypeByPage', params);
}



