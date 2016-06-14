# BUG LIST #
    
1. 2014-10-28 | 生成的service中缺少BeanWrapper和BeanBuilder类的导入
2. 2014-10-28 | 生成的dao的实现，@author后面出现多余的":"
3. 2014-10-28 | 生成的dao的实现中的query方法提示有不安全的类型返回




# 功能建议 #
#### 基于版本：1.0.1 ####
1. service和dao的单元测试依赖于AbstractTest，应该在生成单元测试文件时判断该文件是否存在，如果不存在则一起生成
2. 依赖性太强



#### 版本2.0 ###

1. 重构1.0，使用新的设计并实现