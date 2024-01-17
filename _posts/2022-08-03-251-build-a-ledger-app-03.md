---
slug: 251-build-a-ledger-app-03
date: '2022-08-03'
layout: post
title: 做一个记账应用 03 - Automate 添加记录到 Notion
tags:
  - Automation
  - Notion
issue: 251
---

在[上一步](https://anl.gg/post/250-build-a-ledger-app-02)中，我做了一个简单的 Automate 脚本从文本中解析出记账的结构化数据，这一次，我要把解析出来的数据添加到 Notion 中。

## 建立一个 Integration

要使用 Notion API，首先需要建立一个 Integration。

可以从 Settings 进入。

![Integrations](https://github.com/greatghoul/greatghoul.github.io/assets/208966/91e8f844-5c5c-4121-83a1-9061590cf091)

也可以直接访问 https://www.notion.so/my-integrations

我建立了一个名为 Ledger App 的 Integration, 权限至少需要 Insert Content, 因为要添加记录嘛。不过反正是自用，多点权限也 ok。

![Capabilities](https://github.com/greatghoul/greatghoul.github.io/assets/208966/090dba74-2c9a-41d7-98fa-fe7a85bb8e72)

建立的 Integration 会有一个 Secret Token，记下它备用。

![Integration](https://github.com/greatghoul/greatghoul.github.io/assets/208966/48c268a7-d3b5-47db-acd5-15e38bd6a192)

接下来，将这个 Integration 加入到表格中就好了。

![Add Integration](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8336ae0b-dbbd-464a-8bc2-20f64a73cec0)

## 测试插入数据

从 Notion 的 [API 文档](https://developers.notion.com/reference/post-page)中，了解到添加数据是下面这样的。

```bash
curl 'https://api.notion.com/v1/pages' \
  -H 'Authorization: Bearer '"$NOTION_API_KEY"'' \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  --data '{
	"parent": { "database_id": "d9824bdc84454327be8b5b47500af6ce" },
  "icon": {
  	"emoji": "🥬"
  },
	"cover": {
		"external": {
			"url": "https://upload.wikimedia.org/wikipedia/commons/6/62/Tuscankale.jpg"
		}
	},
	"properties": {
		"Name": {
			"title": [
				{
					"text": {
						"content": "Tuscan Kale"
					}
				}
			]
		},
		"Description": {
			"rich_text": [
				{
					"text": {
						"content": "A dark green leafy vegetable"
					}
				}
			]
		},
		"Food group": {
			"select": {
				"name": "Vegetable"
			}
		},
		"Price": { "number": 2.5 }
	},
	"children": [
		{
			"object": "block",
			"type": "heading_2",
			"heading_2": {
				"rich_text": [{ "type": "text", "text": { "content": "Lacinato kale" } }]
			}
		},
		{
			"object": "block",
			"type": "paragraph",
			"paragraph": {
				"rich_text": [
					{
						"type": "text",
						"text": {
							"content": "Lacinato kale is a variety of kale with a long tradition in Italian cuisine, especially that of Tuscany. It is also known as Tuscan kale, Italian kale, dinosaur kale, kale, flat back kale, palm tree kale, or black Tuscan palm.",
							"link": { "url": "https://en.wikipedia.org/wiki/Lacinato_kale" }
						}
					}
				]
			}
		}
	]
}'
```

这里面有几个关键的参数

* NOTION\_API\_KEY - 也就是上面建立 Integration 后拿到的 Secret Token
    
* parent.database\_id 这个是指要插入数据的表格的 id, 这个在表格的网址里面很容易就找到了
    
    ![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/892eba6d-4552-40c7-8857-d856903e430d)

* properties - 即要添加的记录的字段内容啦，这个东西有一定的格式，具体要看[文档](https://developers.notion.com/reference/property-value-object)。
    

剩下的那个 children 是指表格记录正文里的内容，我不用关心。

简单梳理一下，改成我的账本需要的格式。

```bash
curl "https://api.notion.com/v1/pages" \
  -H "Authorization: Bearer secret_RYKdQ..............tBKK" \
  -H "Content-Type: application/json" \
  -H "Notion-Version: 2022-06-28" \
  --data '{
  "parent": { "database_id": "4d93fd200d6c40a0bf888798eff41b29" },
  "properties": {
    "项目": {
      "title": [
        {
          "text": {
            "content": "测试"
          }
        }
      ]
    },
    "金额": {
      "number": -1
    },
    "分类": {
      "select": {
        "name": "测试"
      }
    },
    "日期": {
      "date": {
        "start": "2022-08-03"
      }
    }
  }
}'
```

终端里面运行下，竟一次成功。

```json
{"object":"page","id":"5a6421b3-f398-4ae5-8112-2ba34b54a30a","created_time":"2022-08-03T11:28:00.000Z","last_edited_time":"2022-08-03T11:28:00.000Z","created_by":{"object":"user","id":"d036a84d-e6f1-43b0-aa48-1ed84f38a00e"},"last_edited_by":{"object":"user","id":"d036a84d-e6f1-43b0-aa48-1ed84f38a00e"},"cover":null,"icon":null,"parent":{"type":"database_id","database_id":"4d93fd20-0d6c-40a0-bf88-8798eff41b29"},"archived":false,"properties":{"分类":{"id":"Axg%3B"},"日期":{"id":"PszJ"},"金额":{"id":"Rixk"},"备注":{"id":"fA%5E%3C"},"收支":{"id":"maGe"},"项目":{"id":"title"}},"url":"https://www.notion.so/5a6421b3f3984ae581122ba34b54a30a"}
```

甚至自动建立了不存在的分类 ”测试"

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/866c81ab-93ad-41ee-ab8a-1d0a2144baa3)

顺带一提，我给表格做了日期分组和金额汇总，方便查看。

既然 API 验证无误，就接着下一步吧。

## Automate 调用 API

这一步其实很简单，在 Automate 中建立一个 HTTP Request 类型的 Block，然后配置上上面测试 ok 的请求信息即可，为了方便验证，顺便 log 一下返回的 Response 内容。

![新增的两个 Block](https://github.com/greatghoul/greatghoul.github.io/assets/208966/438b5e21-671f-492b-af02-7c3524b86b96)

![HTTP Request Block](https://github.com/greatghoul/greatghoul.github.io/assets/208966/12865879-20a1-42bf-99ea-9fb8e818722e)

这里请求的 Header 与 Body 一样，也需要设置成 JSON 格式, Automate 才能识别。

```json
{
  "Authorization": "Bearer secret_RYKdQ....zItBKK",
  "Content-Type": "application/json",
  "Notion-Version": "2022-06-28"
}
```

在替换成我具体的输入内容前，我再验证一下试试。

![运行日志](https://github.com/greatghoul/greatghoul.github.io/assets/208966/65234fb1-1725-4055-a97e-272a9c9aeee8)

![表格记录](https://github.com/greatghoul/greatghoul.github.io/assets/208966/8f76ee39-1c78-4fbf-81fb-cf282e9e4fd6)

运行良好！

## 替换测试内容

就剩下最后一件事了：替换 Request Body。

[上一步](https://anl.gg/post/250-build-a-ledger-app-02) 中，我解析出了数据，那么这里就可以直接用了。

> 07-31 15:29:25.427 U 32366@6: 早餐7元买饭, 早餐, 7, 买饭

```json
["早餐7元买饭", "早餐", "7", "买饭"]
```

用下面的内容替换 Request Body。

```json
{
  "parent": { "database_id": "4d93fd200d6c40a0bf888798eff41b29" },
  "properties": {
    "项目": {
      "title": [
        {
          "text": {
            "content": matches[1]
          }
        }
      ]
    },
    "金额": {
      "number": -matches[2]
    },
    "分类": {
      "select": {
        "name": matches[3]
      }
    },
    "日期": {
      "date": {
        "start": dateFormat(now, "yyyy-MM-dd")
      }
    }
  }
}
```

这里面有几个特殊的格式

* `matches[1]` 用于访问数组元素
    
* `-matches[2]` 用于将字符串 "7" 转为数字并转为负数（如果是仅仅转为数字，使用 `+matches[2]`）  
    参考：https://llamalab.com/automate/doc/expression.html#to\_number\_operator
    
* `dateFormat(now, "yyyy-MM-dd")` 把今天的日期格式化为 "2022-08-03" 的字符串  
    参考：https://llamalab.com/automate/doc/function/date\_format.html
    

替换好之后，再次运行，又毫无悬念的成功了。

![运行结果](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e7544e43-65b2-47db-9132-6497dc2e8e37)

最后，去掉输入框的预设值，再在末尾插入一个 toast block，运行，提示记账成功！

![运行过程](https://github.com/greatghoul/greatghoul.github.io/assets/208966/1527fde7-7adc-4b1f-ab61-9e3e0e41f35e)

然而，高兴的太早了。

![结果错误](https://github.com/greatghoul/greatghoul.github.io/assets/208966/454913cc-4f11-4266-b7fc-4f488c3474c6)

”猪肉23做饭“ 识别成了 "猪肉2, 3, 做饭"，这显然是正则表达式写的有问题。

这是个小问题, 给 "项目" 的捕获组匹配模式做成[非贪婪](https://www.liaoxuefeng.com/wiki/1252599548343744/1306046731649057)就好了。

```erb
findAll(text, "^(.*)(\\d+)元?(.*)$")
```

改为

```erb
findAll(text, "^(.*?)(\\d+)元?(.*)$")
```

再次运行，舒适了！

![结果正确](https://github.com/greatghoul/greatghoul.github.io/assets/208966/246d1acd-78a2-4a09-a0de-c7af19992330)

---

## 下一步

我并不是总是使用手机记账，如果人刚好在电脑旁，那用网页 Notion 记账当然更加快捷，但是 Notion 不支持字段默认值，每次都得手动输入日期也挺烦的。

看了一圈文档，发现 Notion 官方还没有发布 Webhook，虽然有一些第三方的，但是不想折腾那么多。而且只要输入一次日期，就可以从分组这里很方便的建立该日期下的记录了，勉强够用。

![建立分组下的记录](https://github.com/greatghoul/greatghoul.github.io/assets/208966/201ea804-df06-49da-94a2-0f36889c1cc8)

所以我暂时打算跳过设置默认日期的步骤。

下一步，我打算改进一下 Automate 脚本，让它可以一次添加多条记账，这会用到 Automate 一些高级的功能，以及脚本的重构，这正是编程迷人的部分。

敬请期待。
