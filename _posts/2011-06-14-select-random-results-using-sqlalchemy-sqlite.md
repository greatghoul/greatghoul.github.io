---
layout: post
title: SQLAlchemy使用sqlite查询随机结果
slug: select-random-results-using-sqlalchemy-sqlite
date: 2011-06-14 13:54
tags: [python, sqlalchemy, sqlite]
---

最近公司项目接受尾声，有时闲有时忙的，于是就用 [bottle][1] 写个[美丽人物][2]玩玩，因为东西很小，就使用  sqlite 整了, 
orm 使用的是闻名的 [SQLAlchemy][3]。

美丽人物这种东东除了显示当前图片外，还会随机推荐一些其它的人物（那自然是美女了），需要随机返回一些结果呈现给用户。

SQLAlchemy 自然是提供了这种支持的，不过不同的数据库的用法可能会有所不同，sqlite 的方法如下：

    from sqlalchemy import func
    ...
    session.query(Item.item_name).order_by(func.random())

其实是调用 sqlite 的 `random()` 函数。

这里给出一个完整的例子做参考：

    from sqlalchemy.ext.declarative import declarative_base
    from sqlalchemy.orm import Session

    from sqlalchemy import (create_engine, MetaData, Column, Integer, String)
    from sqlalchemy import func

    Base = declarative_base()

    class Item(Base):
        __tablename__ = 'items'

        item_id = Column(Integer, primary_key=True, autoincrement=True)
        item_name = Column(String(30), nullable=False)

    if __name__ == '__main__':
        engine = create_engine('sqlite:///test.db')
        Base.metadata.create_all(engine)

        session = Session(engine)

        # make some records
        session.query(Item).delete()
        session.add_all([
            Item(item_name='Item 1'),
            Item(item_name='Item 2'),
            Item(item_name='Item 3'),
            Item(item_name='Item 4')
        ])
        session.commit()

        # test random results
        for i in range(5):
            print session.query(Item.item_name).order_by(func.random()).all()</pre>

[1]: http://bottlepy.org/docs/dev/
[2]: http://www.ppperson.com/
[3]: http://www.sqlalchemy.org/
