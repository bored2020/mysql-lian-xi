UPDATE  employees SET last_name  = "Mike" WHERE  emp_no =10001;

#delete 语句
以下是 SQL DELETE 语句从 MySQL 数据表中删除数据的通用语法：

DELETE FROM table_name [WHERE Clause]

如果没有指定 WHERE 子句，MySQL 表中的所有记录将被删除。
你可以在 WHERE 子句中指定任何条件
您可以在单个表中一次性删除记录。

DELETE FROM employees WHERE  emp_no = 10001;


# LIKE 子句 
我们知道在 MySQL 中使用 SQL SELECT 命令来读取数据， 同时我们可以在 SELECT 语句中使用 WHERE 子句来获取指定的记录。
WHERE 子句中可以使用等号 = 来设定获取数据的条件，如 "nowcoder_author = 'NOWCODER.COM'"。
但是有时候我们需要获取 nowcoder_author 字段含有 "COM" 字符的所有记录，这时我们就需要在 WHERE 子句中使用 SQL LIKE 子句。
SQL LIKE 子句中使用百分号 %字符来表示任意字符，类似于UNIX或正则表达式中的星号 *****。
如果没有使用百分号 %, LIKE 子句与等号 = 的效果是一样的

SQL中使用like的示例如下：
SELECT field1, field2,...fieldN 
FROM table_name
WHERE field1 LIKE condition1 [AND [OR]] filed2 = 'somevalue'

从employees选取所有last_name最后的字母为k的样本
SELECT  * FROM  employees WHERE  last_name like "%k";


# Mysql UNION 操作符

# Mysql 排序


SELECT field1, field2,...fieldN FROM table_name1, table_name2...
ORDER BY field1 [ASC [DESC][默认 ASC]], [field2...] [ASC [DESC][默认 ASC]]

SELECT * FROM employees;
SELECT  * FROM  employees ORDER BY  hire_date DESC;



# GOUP BY 语句
示例
SELECT column_name, function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;

首先创建我们要用的sql表

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `employee_tbl`
-- ----------------------------
DROP TABLE IF EXISTS `employee_tbl`;
CREATE TABLE `employee_tbl` (
  `id` int(11) NOT NULL,
  `name` char(10) NOT NULL DEFAULT '',
  `date` datetime NOT NULL,
  `singin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '登录次数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `employee_tbl`
-- ----------------------------
BEGIN;
INSERT INTO `employee_tbl` VALUES ('1', '小明', '2016-04-22 15:25:33', '1'), ('2', '小王', '2016-04-20 15:25:47', '3'), ('3', '小丽', '2016-04-19 15:26:02', '2'), ('4', '小王', '2016-04-07 15:26:14', '4'), ('5', '小明', '2016-04-11 15:26:40', '4'), ('6', '小明', '2016-04-04 15:26:54', '2');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;


SELECT  * FROM  employee_tbl;

SELECT name,COUNT(*) FROM  employee_tbl GROUP BY name;


SELECT name,SUM(singin) as singin_count FROM employee_tbl GROUP BY name WITH ROLLUP;
其中记录 NULL 表示所有人的登录次数。

我们可以使用 coalesce 来设置一个可以取代 NUll 的名称，coalesce 语法：

select coalesce(a,b,c);

参数说明：如果a==null,则选择b；如果b==null,则选择c；如果a!=null,则选择a；如果a b c 都为null ，则返回为null（没意义）;



SELECT coalesce(name, '总数'), SUM(singin) as singin_count FROM  employee_tbl GROUP BY name WITH ROLLUP;



# 连接的使用
首先创建两个新表.

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `nowcoder_tbl`;
CREATE TABLE `nowcoder_tbl` (
  `nowcoder_id` int(11) NOT NULL AUTO_INCREMENT,
  `nowcoder_title` varchar(100) NOT NULL,
  `nowcoder_author` varchar(40) NOT NULL,
  `submission_date` date DEFAULT NULL,
  PRIMARY KEY (`nowcoder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `nowcoder_tbl` VALUES ('1', '学习 PHP', '牛客教程', '2017-04-12'), ('2', '学习 MySQL', '牛客教程', '2017-04-12'), ('3', '学习 Java', 'NOWCODER.COM', '2015-05-01'), ('4', '学习 Python', 'NOWCODER.COM', '2016-03-06'), ('5','学习 C', 'FK', '2017-04-05');
COMMIT;

DROP TABLE IF EXISTS `tcount_tbl`;
CREATE TABLE `tcount_tbl` (
  `nowcoder_author` varchar(255) NOT NULL DEFAULT '',
  `nowcoder_count` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

BEGIN;
INSERT INTO `tcount_tbl` VALUES ('牛客教程', '10'), ('NOWCODER.COM ', '20'), ('Google', '22');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;



SELECT a.nowcoder_id,a.nowcoder_author,b.nowcoder_count FROM nowcoder_tbl a INNER  JOIN  tcount_tbl b ON a.nowcoder_author = b.nowcoder_author;

# 上面的代码等价于;


SELECT a.nowcoder_id, a.nowcoder_author, b.nowcoder_count FROM nowcoder_tbl a,tcount_tbl b where a.nowcoder_author=b.nowcoder_author;

# 左连接 left join 
MySQL left join 与 join 有所不同。 MySQL LEFT JOIN 会读取左边数据表的全部数据，即便右边表无对应数据。;


SELECT a.nowcoder_id, a.nowcoder_author, b.nowcoder_count FROM nowcoder_tbl a LEFT JOIN tcount_tbl b ON a.nowcoder_author = b.nowcoder_author;

# 右连接
MySQL RIGHT JOIN 会读取右边数据表的全部数据，即便左边边表无对应数据。；



SELECT a.nowcoder_id, a.nowcoder_author, b.nowcoder_count FROM nowcoder_tbl a RIGHT JOIN tcount_tbl b ON a.nowcoder_author = b.nowcoder_author;
