import axios from '../utils/axios'

export const getArticleTypeByPage = (params: any): Promise<any> => {
  return axios.post('/ArticleType/GetByPage', params)
}

export const addArT = (params: any): Promise<any> => {
  return axios.post('/ArticleType/AddArT', params)
}

export const updateArT = (params: any): Promise<any> => {
  return axios.post('/ArticleType/UpdateArT', params)
}

export const deleteById = (params: any): Promise<any> => {
  return axios.post('/ArticleType/DeleteARTById', params)
}
