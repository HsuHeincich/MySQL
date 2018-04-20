USE world;
SELECT * FROM city;

SELECT Name ,District FROM city;

SELECT Region FROM country;

SELECT DISTINCT Region FROM country;  /*不重复*/

SELECT Name AS 城市名,CountryCode AS 城市编码, Population AS 人口数
FROM city;

SELECT Name AS '城市 名称',CountryCode AS '城市 编码'
FROM city;   /*用单（双）引号将有空格的字段引起来*/

SELECT Population AS 人口,GNP AS 国民生产总值,
GNP*10000/Population AS 人均国民生产总值 FROM country;  /*四则运算*/

SELECT ID ,concat(Name,'&',CountryCode) FROM city;   /*连接符的使用*/

/*算数比较运算符包括=、>=、>、<=、<、!=（<>）、!>、!<*/
SELECT ID,Population FROM city
WHERE Population>=1500000;

SELECT ID ,Name ,CountryCode FROM city
WHERE CountryCode!='AGO';

/*between and*/
SELECT ID,Population FROM city
WHERE Population BETWEEN 1500000 AND 2000000;

/*in(字段1，字段2，...)*/
SELECT ID ,Name ,CountryCode FROM city
WHERE CountryCode IN('AGO','AFG');

/*OR与in（）的等价*/
SELECT ID ,Name ,CountryCode FROM city
WHERE CountryCode ='AGO' OR CountryCode='AFG';

/*字符串比较，一般返回布尔型*/
SELECT 'sqloijh'>'bgf';
SELECT upper('mysql')='MYSQL';
/*binary 二进制比较，二进制会区分大小写*/
SELECT 'mysql' = BINARY 'MYSQL';  /*或SELECT BINARY 'mysql' = 'MYSQL';*/

/*日期比较，可以使用算数比较符，也可以使用between and、in（）；时间日期用引号引起来*/
USE sakila;
SELECT actor_id,last_name ,last_update
FROM actor WHERE last_update>'2006-02-15 04:34:32';  /*时间日期*/
SELECT actor_id,last_name ,last_update
FROM actor WHERE last_update>'20060215';   /*日期，时间默认00:00:00*/

/*逻辑查询and、or、not*/
USE world;
SELECT ID,CountryCode,Population FROM city
WHERE Population>1500000
AND (CountryCode='AGO' OR CountryCode='AFG');   /*AND OR,注意区分有无括号的不同*/

SELECT ID,Name,CountryCode FROM city
WHERE CountryCode NOT IN ('AGO','AFG');  /*not一般与in（）和between and*/

/*空值查询*/
SELECT ID ,Name FROM city
WHERE Name IS NULL ;

SELECT ID ,Name FROM city
WHERE Name IS NOT NULL ;

/*通配符*/
/*‘_’表示单个任意字符，‘%’表示0或者多个任意字符。like*/
SELECT Name FROM city
WHERE Name LIKE 'A%r_';  /*A开头倒数第二个为r*/

/*转义字符--有的字符本身就带有%，或_*/
/*在需要转义的字符加一个转义符，mysql中转义符可以是任意字符，但需要在后面注明*/
SELECT Name FROM city
WHERE Name LIKE '_&_%' ESCAPE '&';  /*以任意字母开头，第二个字符为_，剩余通配符结尾
                                     ESCAPE 注明'&'是转义符，将第二个下划线转义*/

/*mysql中的REGEXP模糊匹配---正则表达式初级*/
/*
^，用来匹配字符串的开始
$，用来匹配字符串的结尾
[]，任意在[]中的字符都可以匹配
[^],不在[]中的任意字符匹配
.，匹配任一单个字符
-，连字符，表示范围。例如[a-z]表示字符a到z中的任意字符
+，表示用于匹配的该字符在需要匹配的字符串中至少出现一次或多次
*，表示用于匹配的该字符在需要匹配的字符串中出现0次或多次
?,表示用于匹配的该字符在需要匹配的字符串中出现0次或1次
()，圆括号中表示一个整体，（abc）表示匹配的字符串中有abc
ab|cde，表示匹配ab或者cde
{}，表示{}前的字符串出现的次数，例如abc{2}表示abc出现了两次
a{0,}表示a出现了0次以上，相当于a*
a{1,}表示a出现了1次以上，相当于a+
a{0,1}表示啊出现了0次以上，1次以下，相当于a?
特殊字符前的转义用\\，例如'\\.'
*/
SELECT Name FROM city
WHERE Name REGEXP '^A';

SELECT Name FROM city
WHERE Name REGEXP 'M$';  /*mysql对大小写不敏感，虽然Name中结尾是小写*/

SELECT Name FROM city
WHERE Name REGEXP '^[mo].*a.*[mo]$'; /*mo开头且mo结尾，中间包括a*/

SELECT Name FROM city
WHERE Name REGEXP '^[^a-exy]';

SELECT Name FROM city
WHERE Name REGEXP 'oo';  /*相当于like ‘%oo%’*/

/*正则表达式的逻辑真与假*/
select "aefY" REGEXP "^[aY]+$";   /*限定了单个字母a、Y，该字母至少出现一次*/
select "aXbc" REGEXP "^[a-dXYZ]+$";  /*限定了一个字母，该字母可以是a-d、X、Y、Z
，并出现至少一次*/
SELECT 'a' REGEXP '^[a-z]$', 'ab' REGEXP '^[a-z]$';  /*同时加^与$表示模式与字符串要相同，
本例中'^[a-z]$'限定了一个a-z的字母*/

/*ORDER BY*/
SELECT Name FROM city
ORDER BY Name ASC;  /*降序用DESC,也可以对非选择列排序*/

SELECT Name FROM city
WHERE Population>1500000
ORDER BY Name DESC;   /*ORDER BY语句必须位于最后，即在WHERE、GROUP BY、HAVING之后*/

SELECT Name ,CountryCode FROM city
ORDER BY 2 ASC;     /*这里的数字指的是选择后的列的序号，不是原始表的列序号*/

SELECT Name ,CountryCode FROM city
ORDER BY Name,CountryCode;   /*多列排序,若第一列相同才会排序第二列*/

SELECT Name,CountryCode FROM city
ORDER BY CountryCode,Name;   /*与上*/

SELECT Name,CountryCode FROM city
ORDER BY Name,CountryCode DESC ;  /*与上上同，若第一列相同，才会按第二列的降序排列*/

/*聚合函数--分组函数或统计函数*/
/*
sum（）、avg（）和count（）可以利用DISTINCT关键字剔除重复值（行值）运算
min（）、max（）可以是数字、字符、日期类型
count（*）--指计算表的总行数，计算总行数时不忽略NULL，其他聚合函数包括count（）--计算行数，忽略NULL
*/
SELECT count(*) FROM city;

SELECT count(CountryCode) FROM city;/*重复统计*/
SELECT count(DISTINCT CountryCode) FROM city;/*不重复统计*/

SELECT Name,max(Population),min(Population) FROM city;

SELECT Name,sum(Population),count(Population),avg(Population) FROM city;

SELECT Name,CountryCode ,sum(Population) FROM city
GROUP BY CountryCode;  /*单列分组求和统计*/

SELECT Name,CountryCode,District,max(Population) FROM city
GROUP BY CountryCode,District; /*多列分组求和统计*/
/*在将聚合函数作为一列选出时，必须有GROUP BY*/

/*HAVING出现在GROUP BY后面的条件句*/
SELECT Name,CountryCode ,max(Population) FROM city
GROUP BY CountryCode
HAVING max(Population)>1000000;  /*HAVING子句中可以利用未选中列如MAX（District）进行条件限制*/

SELECT Name,CountryCode,max(Population) FROM city
WHERE Name BETWEEN 'a' AND 'd'    /*包括a但不包括d*/
GROUP BY CountryCode
HAVING max(Population)>1000000;   /*WHERE作用于SELECT语句，HAVING作用于GROUP BY语句*/

SELECT Name,CountryCode FROM city
GROUP BY CountryCode
ORDER BY Name;    /*分组排序*/

/*WITH ROLLUP统计数据*/
SELECT CountryCode ,District,sum(Population) FROM city
GROUP BY CountryCode,District
WITH ROLLUP ;   /*添加一行记录，对统计量进行统计，最后一行添加记录所有行统计量的统计*/

/*LIMIT限制结果显示数量*/
SELECT Name,CountryCode FROM city
GROUP BY CountryCode
ORDER BY Name
LIMIT 50;   /*注意这里ORDER BY并不是放在最后*/

SELECT Name,CountryCode  FROM city
GROUP BY CountryCode
ORDER BY Name
LIMIT 20,10;  /*从结果的第21条开始，读取10条，注意mysql中偏移为1,且从0开始。即LIMIT 0,n和LIMIT n等价*/


/*连接查询*/
SELECT city.Name ,city.CountryCode,country.Code, country.Name
FROM country ,city
WHERE city.CountryCode=country.Code
ORDER BY country.Name;   /*利用WHERE进行等值连接*/

SELECT cs.Name, cs.CountryCode,gj.Code,gj.Name
FROM city AS cs,country AS gj
WHERE cs.CountryCode=gj.Code
ORDER BY gj.Name;       /*表别名，但在文本编辑器中使用原表更好，存在代码补全*/

SELECT city.Name AS csName ,city.CountryCode,
country.Code ,country.Name AS gjName
FROM country INNER JOIN city
ON country.Code = city.CountryCode
ORDER BY country.Name;   /*inner join连接*/

SELECT city.Name AS csName ,city.CountryCode,
country.Code ,country.Name AS gjName,
countrylanguage.CountryCode,countrylanguage.Language
from (country INNER JOIN city ON country.Code = city.CountryCode)
INNER JOIN countrylanguage ON countrylanguage.CountryCode=country.Code
WHERE country.Name REGEXP '^z'
order BY country.Name;  /*多表连接，因为这里不涉及四张有关系的表，因此不做四表连接，但思路如下：*/
/*四表连接及更多表连接*/
/*
INNER JOIN 关联四张数据表的写法：
SELECT * FROM
((表1 INNER JOIN 表2 ON 表1.字段号=表2.字段号)
INNER JOIN 表3 ON 表1.字段号=表3.字段号)
INNER JOIN 表4 ON 表1.字段号=表4.字段号
*/

/*上述三表连接也可以采用WHERE子句，但逻辑不清晰*/
SELECT city.Name AS csName ,city.CountryCode,
country.Code ,country.Name AS gjName,
countrylanguage.CountryCode,countrylanguage.Language
FROM country,city,countrylanguage
WHERE country.Code = city.CountryCode
AND countrylanguage.CountryCode=country.Code
AND country.Name REGEXP '^z'
ORDER BY country.Name;    /*结果一致*/

/*使用USING关键字连接*/
SELECT city.Name AS csName ,city.CountryCode,
countrylanguage.CountryCode,Language
FROM countrylanguage INNER JOIN city
USING (CountryCode)
WHERE city.Name REGEXP '^z'
ORDER BY city.Name;  /*使用USING必须保证匹配关键字一致，否则应使用ON进行等值连接*/

/*交叉连接产生表的笛卡尔积，即两张分别有a和b个记录的表交叉，会产生一个有a*b个记录的表，
一般不用，因为会产生大量重复*/
/*
①：
SELECT city.Name ,country.Name
FROM country,city;
②
SELECT city.Name ,country.Name
FROM city CROSS JOIN country;
*/

/*外连接LEFT JOIN,RIGHT JOIN和FULL JOIN，替换上面例子的INNER JOIN即可*/
/*左表+交集，右表+交集，并集*/

/*集合查询：并操作（主要）、交操作和差操作*/
/*并操作，将两次或多次产查询结果并在一起显示,并且要求两个SELECT语句的列数一致，且对应的
列数类型一致，相当于将两个查询到的表纵向连接到一起，并且以第一个SELECT语句选择的列名为主*/
SELECT city.Name AS csName ,city.CountryCode,
country.Code ,country.Name AS gjName
FROM country LEFT JOIN city
ON country.Code = city.CountryCode
UNION
SELECT city.Name AS csName ,city.CountryCode,
country.Code ,country.Name AS gjName
FROM country RIGHT JOIN city
ON country.Code = city.CountryCode;

/*交操作，即显示两个结果（表）相交的部分,mysql中没有INTERSECT关键字，可用INNER JOIN*/
/*差操作，即显示连个结果（表）向差的部分，结合差集理解A-B，mysql中没有MINUS关键字，
可利用LEFT JOIN 并且使表2的匹配关键字在NULL情况下选取，则剔除了表2与表1交集的部分。
即在LEFT JOIN 加如下限定条件WHERE 表2.匹配关键字 IS NULL*/


/*子查询-嵌套查询*/
SELECT Name ,Population FROM country
WHERE Population > (
  SELECT Population FROM country
  WHERE Name='Armenia'
      )
ORDER BY Name;   /*返回人口大于Armenia的结果，单列单行子查询要求子查询只返回一个结果*/

SELECT Name FROM city
WHERE CountryCode IN (
  SELECT CountryCode FROM city
  WHERE Name='Herat'
)
ORDER BY Name;  /*返回与Herat在同一个国家的城市名，即事先不清楚Herat属于哪个国家
                该语句为单列多行子查询，可以返回多行，本例只返回一行*/

/*ANY多行子查询，长与算术运算符连用
=ANY，等于查询结果中的任何一个值
>ANY，大于查询结果中的任何一个值，即大于查询结果中的最小值
<ANY，小于查询结果中的任何一个值，即小于查询结果中的最大值
<=ANY,>=ANY
!=ANY，不等于查询结果中的任何一个值
*/
SELECT Name ,Population FROM country
WHERE Population >ANY (
  SELECT Population FROM country
  WHERE Name LIKE 'A%n'
)
ORDER BY Name;

/*ALL多行子查询，长与算术运算符连用
=ALL，等于查询结果中的所有值
>ALL，大于查询结果中的所有值，即大于查询结果中的最大值
<ALL，小于查询结果中的所有值，即小于查询结果中的最小值
<=ALL,>=ALL
!=ALL，不等于查询结果中的所有值，相当于NOT IN
*/
SELECT Name ,Population FROM country
WHERE Population >ALL (
  SELECT Population FROM country
  WHERE Name LIKE 'A%n'
)
ORDER BY Name;

/*多列子查询，子查询中含有多列，规则与单列一致，看子查询返回的结果为单行或多行*/
SELECT Name , CountryCode,District FROM city
WHERE (CountryCode,District)=(
  SELECT CountryCode ,District FROM city
  WHERE Name='Apeldoorn'
)
ORDER BY Name;  /*返回与Apeldoorn城市具有相同国家代号和区名的城市名*/

/*相关子查询，即逐步查询，带有关键字EXISTS和NOT EXISTS*/
SELECT country.Name ,country.Population FROM country
WHERE exists(
  SELECT * FROM city
  WHERE country.Code=city.CountryCode
  AND city.Population =89000
)
ORDER BY country.Name;  /*查询国家有城市人口等于89000的国家*/
/*先查询country表里第一条信息，在city表里找到第一条
记录的CountryCode（即等于country.Code），然后查询是否存在人口=89000，存在返回TRUE
，则显示第一条信息，以此迭代*/

SELECT DISTINCT country.Name ,country.Population
FROM country INNER JOIN city
ON country.Code = city.CountryCode
WHERE city.Population =89000
ORDER BY country.Name;   /*利用内连接解决上述嵌套相关循环*/

SELECT country.Name ,country.Population FROM country
WHERE exists(
  SELECT * FROM city
  WHERE country.Code=city.CountryCode
  AND city.Population>1000000
)
ORDER BY country.Name;   /*查询国家中有城市人口>1000000的国家名*/

SELECT DISTINCT country.Name ,country.Population
FROM country INNER JOIN city
ON country.Code = city.CountryCode
WHERE city.Population>1000000
ORDER BY country.Name;   /*利用内连接解决上述问题*/
/*需要是因为内连接可能导致产生重复值，从而造成与上述结果不一致，因此需要加DISTINCT关键字*/

/*如何查询一列中所有具有相同的值，两种方法供参考*/
SELECT Name,Population FROM country
WHERE Population IN (
  SELECT Population FROM country
  GROUP BY Population
  HAVING count(Population)>1
)
ORDER BY Population;    /*查询一列中具有相同的值*/

SELECT Name,Population FROM city AS city_copy
WHERE exists(
  SELECT * FROM city
  WHERE city.Population=city_copy.Population
  AND city.ID!=city_copy.ID
)
ORDER BY Population;   /*查询一列中具有相同的值*/

/*如何创建表的副本*/
create table city_c as select * from city where 1=0;
/*或者：CREATE TABLE city_c LIKE city*/
insert into city_c select * from city;

CREATE TABLE city_a AS (SELECT * FROM city);   /*方法二，子查询创建新表*/

CREATE TABLE city_b AS SELECT * FROM city;    /*去掉括号也可以，但不建议这样*/



/*DISTINCT 作用两个字段不起作用的转化*/
CREATE TABLE a(
  id INT(4),
  name VARCHAR(4)
);
INSERT INTO a VALUES(1,'a');
INSERT INTO a VALUES(2,'b');
INSERT INTO a VALUES(3,'c');
INSERT INTO a VALUES(4,'c');
INSERT INTO a VALUES(5,'d');

SELECT *,count(DISTINCT name) FROM a
GROUP BY name ;

/*NOT EXISTS*/
SELECT country.Name,country.Population FROM country
WHERE NOT exists(
  SELECT * FROM city
  WHERE country.Code=city.CountryCode
  AND city.Population>1000000
)
ORDER BY country.Name;   /*查询国家里没有城市人口大于1000000的国家名*/

SELECT DISTINCT country.Name,country.Population
FROM country INNER JOIN city
ON country.Code = city.CountryCode
GROUP BY country.Code
HAVING max(city.Population)<=1000000
ORDER BY country.Name;    /*同样用内连接可以解决，但存在一个问题，为什么会自动删除国家人口为0
                          的国家（缺失7个）*/


/*位于SELECT的子查询，其子查询应该返回一个具体的结果*/
SELECT city.* ,(SELECT name FROM country
  WHERE country.Code='AFG') AS countryname
FROM city
WHERE city.CountryCode = 'AFG'
ORDER BY city.Name;  /*查询编码为'AFG'的国家的城市信息*/

/*在FROM子句中的子查询，该子查询的结果应该是一个数据表*/
SELECT city.* ,GJ.Name AS GJName
FROM city,(SELECT Code,Name FROM country) AS GJ
WHERE city.CountryCode=GJ.Code
AND city.CountryCode = 'AFG'
ORDER BY city.Name;   /*FROM中的子查询的结果表一定要别名*/

/*HAVING子句中的子查询，该子查询的结果应该是一个数据表*/
SELECT city.*,Country.Name, AVG(city.Population) AS Avgpopulation
FROM city INNER JOIN country
ON city.CountryCode = country.Code
GROUP BY city.CountryCode
HAVING country.Name IN (
  SELECT country.Name FROM country
  WHERE country.Name LIKE 'B%'
)
ORDER BY country.Name;


/*多重子查询*/
SELECT name ,Population FROM city
WHERE CountryCode = (
  SELECT CountryCode FROM city
  WHERE Name='Quilmes'
)
AND
  Population>(
    SELECT Population FROM city
    WHERE Name='Quilmes'
  )
ORDER BY Name;     /*查询与Quilmes国家相同但人口高于该城市的其他城市*/





