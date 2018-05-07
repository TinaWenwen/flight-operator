# [首页](doc/api/home.md) | 特价活动

#### 描述
```
查询特价活动详情
```

####  API
 ```
activity/bargains/detail
```

#### 请求方式
```
GET
```

#### 请求参数
参数	| 类型	| 说明 | 必填 
---|---|---|---
actId   | String | 活动ID | Y

#### 请求示例
`无`

#### 返回参数
参数 | 类型 | 说明
---|---|---
`参照返回示例 `|

#### 返回示例
```
{
    "code": 0,
    "msg": "系统故障"
}

{
    "code": 1,
    "msg": "success",
    "data": {
        "title": "标题",
        "status": "状态 1：在线 2：下线",
        "backColor": "背景颜色",
        "listStyle": "航线展示样式",
        "header": {
            "img": "图片url"
        },
        "titleBar": {
            "backColor": "背景颜色"
        },
        "bookButton": {
            "color": "预定按钮颜色",
            "text": "预定按钮文案"
        },
        "showMoreButton": {
            "color": "查看更多航线按钮颜色"
        },
        "rule": {
            "title": "活动规则",
            "items": [
                "规则说明1",
                "规则说明2",
                "规则说明3"
            ],
            "backColor": "背景颜色",
            "fontColor": "字体颜色"
        },
        "footer": {
            "img": "图片url"
        },
        "wechatShare": {
            "desc": "描述",
            "icon": "图标url",
            "link": "",
            "title": "标题"
        }
    }
}
```
