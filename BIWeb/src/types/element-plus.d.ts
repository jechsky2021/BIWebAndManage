declare module 'element-plus' {
  import type { App, Plugin, Component } from 'vue'

  export interface FormInstance {
    validate: (callback?: (valid: boolean) => void) => Promise<boolean>
    resetFields: () => void
    clearValidate: (props?: string | string[]) => void
    validateField: (props: string | string[], callback?: (errorMessage: string) => void) => void
  }

  export type FormRules = Record<string, any[]>

  export interface FormItemRule {
    required?: boolean
    message?: string
    trigger?: string
    min?: number
    max?: number
    pattern?: RegExp
    validator?: (rule: any, value: any, callback: (error?: string) => void) => void
  }

  export const ElMessage: any
  export const ElMessageBox: any
  export const ElNotification: any
  export const ElLoading: any
  export const ElTreeSelect: any
  export const ElTag: any
  export const ElInput: any
  export const ElButton: any
  export const ElForm: any
  export const ElFormItem: any
  export const ElDialog: any
  export const ElPagination: any
  export const ElTable: any
  export const ElTableColumn: any
  export const ElDropdown: any
  export const ElDropdownMenu: any
  export const ElDropdownItem: any
  export const ElMenu: any
  export const ElMenuItem: any
  export const ElSubMenu: any
  export const ElBreadcrumb: any
  export const ElBreadcrumbItem: any
  export const ElTabs: any
  export const ElTabPane: any
  export const ElCard: any
  export const ElAlert: any
  export const ElCollapse: any
  export const ElCollapseItem: any
  export const ElAvatar: any
  export const ElBadge: any
  export const ElProgress: any
  export const ElTooltip: any
  export const ElPopover: any
  export const ElCarousel: any
  export const ElCarouselItem: any
  export const ElSteps: any
  export const ElStep: any
  export const ElCheckbox: any
  export const ElCheckboxGroup: any
  export const ElRadio: any
  export const ElRadioGroup: any
  export const ElSelect: any
  export const ElOption: any
  export const ElDatePicker: any
  export const ElTimePicker: any
  export const ElUpload: any
  export const ElDivider: any
  export const ElSpace: any
  export const ElSkeleton: any
  export const ElSkeletonItem: any
  export const ElEmpty: any
  export const ElResult: any
  export const ElStatistic: any
  export const ElBacktop: any
  export const ElInfiniteScroll: any
  export const ElScrollbar: any
  export const ElImage: any
  export const ElImageViewer: any
  export const ElCalendar: any
  export const ElConfigProvider: any
  export const ElPopconfirm: any
  export const ElDrawer: any
  export const ElCascader: any
  export const ElColorPicker: any
  export const ElTransfer: any
  export const ElTree: any
  export const ElDescriptions: any
  export const ElDescriptionsItem: any
  export const ElTimeline: any
  export const ElTimelineItem: any
  export const ElPageHeader: any
  export const ElResult: any
  export const ElCollapseTransition: any
  export const ElDialog: any
  export const ElTooltip: any
  export const ElPopover: any
  export const ElPopconfirm: any
  export const ElTag: any
  export const ElButton: any
  export const ElInput: any
  export const ElSelect: any
  export const ElOption: any
  export const ElRadio: any
  export const ElRadioGroup: any
  export const ElCheckbox: any
  export const ElCheckboxGroup: any
  export const ElSwitch: any
  export const ElSlider: any
  export const ElInputNumber: any
  export const ElDatePicker: any
  export const ElTimePicker: any
  export const ElUpload: any
  export const ElRate: any
  export const ElColorPicker: any
  export const ElTransfer: any
  export const ElTree: any
  export const ElTreeSelect: any
  export const ElCascader: any
  export const ElTable: any
  export const ElTableColumn: any
  export const ElPagination: any
  export const ElBadge: any
  export const ElAvatar: any
  export const ElSkeleton: any
  export const ElSkeletonItem: any
  export const ElEmpty: any
  export const ElProgress: any
  export const ElStatistic: any
  export const ElAlert: any
  export const ElDrawer: any
  export const ElDialog: any
  export const ElPopover: any
  export const ElPopconfirm: any
  export const ElTooltip: any
  export const ElCarousel: any
  export const ElCarouselItem: any
  export const ElCollapse: any
  export const ElCollapseItem: any
  export const ElSteps: any
  export const ElStep: any
  export const ElTabs: any
  export const ElTabPane: any
  export const ElMenu: any
  export const ElMenuItem: any
  export const ElSubMenu: any
  export const ElDropdown: any
  export const ElDropdownMenu: any
  export const ElDropdownItem: any
  export const ElBreadcrumb: any
  export const ElBreadcrumbItem: any
  export const ElPageHeader: any
  export const ElCard: any
  export const ElTimeline: any
  export const ElTimelineItem: any
  export const ElDescriptions: any
  export const ElDescriptionsItem: any
  export const ElResult: any
  export const ElBacktop: any
  export const ElInfiniteScroll: any
  export const ElScrollbar: any
  export const ElImage: any
  export const ElImageViewer: any
  export const ElCalendar: any
  export const ElConfigProvider: any
  export const ElDivider: any
  export const ElSpace: any
  export const ElCollapseTransition: any

  const ElementPlus: Plugin
  export default ElementPlus
}
