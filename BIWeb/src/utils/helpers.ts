import { pictureServerBaseUrl } from './axios'

export function getImageUrl(imagePath: string | undefined | null): string {
  if (!imagePath) return ''
  
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath
  }
  
  return `${pictureServerBaseUrl}${imagePath}`
}

export function getAvatarUrl(avatarPath: string | undefined | null): string {
  return getImageUrl(avatarPath)
}
