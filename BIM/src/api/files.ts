import { fileService } from '../utils/axios'

// 保存图片
export const saveGoodsPic = (params: any): Promise<any> => {
  return fileService.post('/fileManageEndPoint/saveGoodsPic', params)
}

// 查看图片
export const downLoadFromOSS = (params: any): Promise<any> => {
  return fileService.post('/fileManageEndPoint/downLoadFromOSS', params)
}

// 上传文件（支持富文本编辑器图片上传）
export const uploadFiles = (formData: FormData): Promise<any> => {
  return fileService.post('/fileManageEndPoint/upload', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
