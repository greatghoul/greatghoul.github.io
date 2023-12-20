---
slug: 208-sequelize-migration-on-delete
date: '2018-10-14'
layout: post
title: Sequelize 在 migration 中如何修改外键的 onDelete
tags:
  - Database
  - Node.js
issue: 208
---


最近做的项目中使用了 Sequelize 来管理数据库结构，在设计评论表时，犯了一些错误，将外键的 `onDelete` 设置成了 `cascade`，这导致父级评论删除时，它所有的回复都被清空了，而项目的预期是，当父级评论删除时，所有回复依然需要保留。

```javascript
queryInterface.createTable('Comments', {
  parent_id: {
    type: Sequelize.INTEGER,
    references: {
      model: 'Comments',
      key: 'id',
    },
    onDelete: 'cascade',
  },
});
```

于是需要写个新的 migration 来纠正，首先，想到了使用 `changeColumn`

```javascript
queryInterface.changeColumn('Comments', 'parent_id', {
  parent_id: {
    type: Sequelize.INTEGER,
    references: {
      model: 'Comments',
      key: 'id',
    },
    onDelete: 'SET NULL',
  },
});
```

而这个写法其实是错误的，它导致数据多出一条额外的 Foreign-key constraints

```text
Foreign-key constraints:
    "parent_id_foreign_idx" FOREIGN KEY (parent_id) REFERENCES "Comments"(id) ON DELETE SET NULL
```

手动删除后，再仔细查了下 Sequelize 的手册。

```sql
ALTER Table "Comments" DROP CONSTRAINT "parent_id_foreign_idx";
```

终于尝试出了正确的写法。

```javascript
up: (queryInterface, Sequelize) => {
  return [
    queryInterface.removeConstraint('Comments', 'Comments_parent_id_fkey'),
    queryInterface.addConstraint('Comments', ['parent_id'], {
      type: 'foreign key',
      name: 'Comments_parent_id_fkey',
      references: {
        table: 'Comments',
        field: 'id'
      },
      onDelete: 'SET NULL',
    }),
  ];
},
```
