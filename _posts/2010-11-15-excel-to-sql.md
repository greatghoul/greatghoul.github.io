---
title: 将Excel中的数据转成sql脚本
slug: excel-to-sql
date: 2010-11-15 22:29
tags: [excel, java, sql]
---

用户经常给一些Excel文件的数据，让我们录入到系统中，作数据初始化，录数据其实是一项相当无聊的工作，一个不注意还容易出错，不过聪明的程序员总能让事情变得有趣起来。

在 Java 中，使用 `PreparedStatement` 或者 Hibernate 的 hql，经常都会碰到类似如下形式的参数绑定。

    ::sql
    select * from table_names where id = ?
    from Employee emp where emp.deptName = :detpName

其实如果是规则的 excel 文件，我们也可以利用类似的机制将其中的数据批量导成 sql ，然后在数据库管理工具中直接执行，来简化数据录入。

比如有张表如下：

<table>
    <tr>
        <th>姓名</th>
        <th>性别</th>
        <th>省份</th>
        <th>地址</th>
    </tr>
    <tr>
        <td>张三</td>
        <td>男</td>
        <td>陕西</td>
        <td>陕西西安</td>
    </tr>
    <tr>
        <td>李四</td>
        <td>女</td>
        <td>黑龙江</td>
        <td>黑龙江鸡西</td>
    </tr>
    <tr>
        <td>王八</td>
        <td>男</td>
        <td>景德镇</td>
        <td>景德镇根据地</td>
    </tr>
</table>

如果想把里面的数据插入到 `hr_emps` 表中，只要指定sql语句模板

    ::sql
    insert into hr_emps(name, gender, prov, addr) values(':0', ':1', ':2', ':3');

则生成对应的sql语句如下：

    ::sql
    insert into hr_emps(name, gender, prov, addr) values('张三', '男', '陕西', '陕西西安');
    insert into hr_emps(name, gender, prov, addr) values('李四', '女', '黑龙江', '黑龙江鸡西');
    insert into hr_emps(name, gender, prov, addr) values('王八', '帝', '景德镇', '景德镇根据地');

下面是Java代码：

    ::java
    import java.io.File;
    import java.io.FileWriter;
    import java.io.IOException;
    import java.io.PrintWriter;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.regex.Matcher;
    import java.util.regex.Pattern;

    import jxl.Sheet;
    import jxl.Workbook;
    import jxl.read.biff.BiffException;

    /**
     * xls转sql工具
     *
     * @author greatghoul@gmail.com
     */
    public class Excel2SqlConvertor {
      /**
       * 将xls文件按照指定的sql语句模板转换成sql脚本。
       *
       * @param xlsFile xls文件路径
       * @param sqlFile 要输出的sql脚本文件路径
       * @param template sql语句模板
       * @param sheetIndex xls中标签页的序号(从0开始)
       * @param start 转换开始的行数 (从0开始)
       * @param end 转换结束的行数 (从0开始)
       * @throws IOException
       * @throws BiffException
       */
      public static void convert(String xlsFile, String sqlFile, String template,
          int sheetIndex, int start, int end) throws IOException, BiffException {
        // 获取工作薄
        Workbook workbook = Workbook.getWorkbook(new File(xlsFile));
        Sheet sheet = workbook.getSheet(sheetIndex);

        // 获取sql中的所有字段点位符
        Matcher matcher = Pattern.compile("(:\\d)").matcher(template);
        List columns = new ArrayList();
        while (matcher.find()) {
          columns.add(Integer.valueOf(matcher.group().replace(":", "")));
        }

        // 输出sql脚本文件
        PrintWriter writer = new PrintWriter(new FileWriter(sqlFile));
        System.out.println("Writing sql statements to file: " + sqlFile);
        System.out.println("-------------------------------------------------------------------------------");
        int rowCount = 0;
        for (int i = 0, j = sheet.getRows(); i &lt; j; i++) {
          if (i &lt; start - 1 || i &gt;= end) {
            continue;
          } else {
            // 组装sql语句
            String line = new String(template);
            for (Integer column : columns) {
              line = line.replace(":" + column, sheet.getCell(column, i).getContents());
            }
            System.out.println(line);
            writer.println(line);
            rowCount++;
          }
        }
        writer.flush();
        writer.close();
        System.out.println("-------------------------------------------------------------------------------");
        System.out.format("Converting completed. %d row(s) in total.%n", rowCount);

        // Runtime.getRuntime().exec("notepad.exe " + sqlFile);
      }

      public static void main(String[] args) {
        String xlsFile = "d:\\规划所花名册(人力资源部提供）编制.XLS";
        String sqlFile = "d:\\规划所花名册(人力资源部提供）编制-事业.SQL";
        // 其中:0  :2  :6  为值所在excel的列号
        String template = "INSERT INTO PS_USER(ID, NAME, BIRTHDAY) VALUES(:0, ':2', ':6');";
        try {
          Excel2SqlConvertor.convert(xlsFile, sqlFile, template, 2, 2, 133);
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    }

代码中使用到了 [Java Excel API][^1]，请自行下载。

[^1]: http://jexcelapi.sourceforge.net/
