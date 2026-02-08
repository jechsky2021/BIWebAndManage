import axios from '../utils/axios'

export const getArticleByPage = (params: any): Promise<any> => {
  return axios.post('/Article/GetByPage', params)
}

export const getDetailById = (params: any): Promise<any> => {
  return axios.post('/Article/GetDetailById', params)
}

export const addArticle = (params: any): Promise<any> => {
  return axios.post('/Article/AddArt', params)
}

export const updateArticle = (params: any): Promise<any> => {
  return axios.post('/Article/UpdateArt', params)
}

export const updateStatus = (params: any): Promise<any> => {
  return axios.post('/Article/UpdateStatus', params)
}
