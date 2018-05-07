# 国内机票产品货架系统接口文档

#### 1. 接口规则定义
---

- 传输协议：HTTP
- 数据编码：UTF-8
- 请求方式：POST | GET
- 数据格式：application/json

Key | Value|Type
---|---|---
code | 业务代码 1：成功 | int 
msg  | 	提示信息 | String
data | 实际返回结果，复杂格式，可能是string，int，或者子json(class) | Object

#### 2. 接口配置
---

- 接口地址：  
http://101.200.123.157:8270/operator （测试）  
http://172.29.1.191:8270/operator （`生产`）

#### 3. 接口类目
---


- 客户端端接口
    - [特价活动详情](items/activity-bargains-detail.md)    

#### 4. 帮助信息
---