---
slug: 240-mysql-distinct-sequential-values
date: '2021-08-26'
layout: post
title: MySQL 针对连续数据去重
tags:
  - Database
issue: 240
---

今天在电鸭社区的微信群里，遇到有人问一个 SQL 问题，针对连续的数据去重。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/e25ff230-fd0d-4c3b-9781-6ae4206c8cd5)

比如图中的数据，预期的去重结果是。

![image](https://github.com/greatghoul/greatghoul.github.io/assets/208966/9dba86f5-3a66-476c-8848-50e9cbf49aac)

这种上下行数据相互关联的去重，想着还挺难做的，不过参考了一些资料后，发现利用 Session Variable 还是可以实现的。

第一种方法，是给查询创咋 row number，然后同表按照 row num = row num + 1 left join，从而判断是不是连续重复数据。

```sql
SET @row_number_a = 0;
SET @row_number_b = 1;

SELECT
  t1.id, t1.floor_id, t1.number, t1.name
from (
  SELECT (@row_number_a:=@row_number_a + 1) AS row_num, rooms.* FROM rooms ORDER BY id
) as t1
left outer join (
  SELECT (@row_number_b:=@row_number_b + 1) AS row_num, rooms.* FROM rooms ORDER BY id
) as t2
ON t1.row_num = t2.row_num
WHERE t1.number <> t2.number OR t2.number IS NULL;
```

这种写法无疑很慢，但是也能达到效果，想到 Session Variable 既然可以塞到查询里面，为何不直接引用上一行的数据呢，于是有了改进后的写法。

```sql
SET @last_number = 0;
SELECT
  t.id,
  t.floor_id,
  t.number,
  t.name
FROM (
  SELECT
    (@last_number = number) AS duplicated,
    (@last_number := number) AS last_number,
    rooms.*
  FROM rooms
  ORDER BY id
) as t
WHERE t.duplicated = 0
ORDER BY t.id;
```

这种写法比较语句 `(@last_number = number)` 必须放在赋值语句 `(@last_number := number)` 前面，才可以有效判断是不是连续重复数据。

具体的运行效果，可以在这里看到。

http://sqlfiddle.com/#!9/75f67a/33

第二种写法效率上应该更高一些，不过也抗不住数据多，更有效方法，可以用空间换时间，比如

1. 给表里做一个新的字段，last_number，每次写入数据，都查出上一条数据，然后更新到 last_number，这样查询就很简单
2. 或者添加一个 duplicated 的字段，写一个定时脚本，给一段时间扫描一遍，把重复的数据标记为 duplicated

## 参考资料

- [MySQL ROW_NUMBER() Using Session Variable](https://www.javatpoint.com/mysql-row_number-function)
