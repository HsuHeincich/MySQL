USE world;
SELECT length(Name) FROM country;

SELECT length('creat 教师表') FROM dual;
/*dual表为系统空表。汉字算作三个字符*/

SELECT lower('CREAT TEACHER_TABLE');
/*如果FROM dual，则可以省略*/

SELECT upper('creat teacher_table');

/*截取函数*/
SELECT substr('creat teacher_table',5,10); /*没有第0个位置*/
SELECT substr('creat teacher_table',-5);   /*倒数，并截取到最后*/
SELECT substring('creat teacher_table' FROM 5 FOR 10);
SELECT substring_index('abc,bcd:cde,def:efg.fgh',':',2); /*第二个冒号之前的字符串*/
SELECT substring_index('abc,bcd:cde,def:efg.fgh',':',-2); /*倒数第二个冒号滞后的字符串*/
SELECT left('creat teacher_table',7);  /*最左侧*/
SELECT right('creat teacher_table',6);

/*剔除*/
SELECT ltrim('  .abc cdef g. ');  /*去除左端空格*/
SELECT rtrim('  .abc cdef g. ');
SELECT trim('  .abc cdef g. ');
SELECT trim(LEADING '.' FROM '...abc cdef g***'); /*去除左端指定字符‘.’*/
SELECT trim(TRAILING '*' FROM '...abc cdef g***');
SELECT trim(BOTH '.' FROM '...abc cdef g...');  /*去除两端制定字符，但两段字符不一致时就分两次剔除吧*/

/*填充*/
SELECT lpad('abc','8','SQL');  /*左侧填充指定字符串‘SQL'，直到满足’8‘个长度*/
SELECT lpad('abc','2','SQL');  /*可以起到左截取的作用*/
SELECT rpad('abc','8','SQL');
SELECT rpad('abc','2','SQL');  /*只从左侧返回最终长度*/

/*定位-第一次出现*/
SELECT instr('abcdefghijkabcdefghijk','i');
SELECT instr('abcdefghijkabcdefghijk','m');  /*可用来确定字符是否在字符串中*/
SELECT instr('abcdefghijkabcdefghijk','bc');  /*找子串的位置，返回子串首字母的位置*/
SELECT position('bc' IN 'abcdefghijkabcdefghijk'); /*同上*/
SELECT locate('bc','abcdefghijkabcdefghijk');      /*同上*/
SELECT locate('b','abcdefghijkabcdefghijk',4);    /*从第四个位置开始往后查找’b‘第一次出现的位置*/

/*倒序*/
SELECT reverse('abcdefg');

/*替换*/
SELECT replace('i am a teacher','teacher','');   /*空值替换，删除*/
SELECT replace('i am a teacher','teacher','young student');  /*特定值替换*/

/*拼接,连接*/
SELECT concat(CountryCode,':',Name) FROM city
LIMIT 5;
SELECT concat(CountryCode,NULL ,Name) FROM city
LIMIT 5;     /*注意，连接的列中有一列含有NULL，则结果为NULL*/

/*字符与ASCII的转换*/
SELECT ascii('X');
SELECT ASCII('Xaa');  /*只返回左侧第一个字符的ASCII*/
SELECT ascii(12);     /*数字的ASCII不需要引号*/
SELECT char(99);      /*ASCII值应在0~255范围*/

/*匹配发音*/
SELECT soundex('hart');
SELECT soundex('heart');  /*返回值一样*/

/*重复*/
SELECT repeat('abc',3);

/*数学函数*/
SELECT abs(-3);        /*绝对值*/
SELECT power(-3,2),power(9,0.5);  /*-3的平方，9的0.5次方*/
SELECT sqrt(9);        /*平方根*/
select log(3),log(0.5); /*3和0.5的自然对数，*/
select log10(3),log10(10);/*以10为底的对数*/
SELECT exp(3),exp(0);      /*e的三次方与0次方*/
SELECT power(2,3);    /*任意底数与任意幂数，2的3次方*/
SELECT round(3.5),round(3.12578,2);  /*四舍五入*/
SELECT truncate(3.12578,2);   /*直接截取不四舍五入*/
SELECT round(2345.66666,-3);  /*返回2000*/
SELECT round(2545.66666,-3);  /*返回3000*/
SELECT round(2345.66666,-4);  /*返回0*/
SELECT round(5345.66666,-4);  /*返回10000*/
SELECT round(5345.66666,-5);  /*返回0*/
/*当参数为负，意思为小数点左侧第|m|位四舍五入，该位及后面整0*/
SELECT MOD (5,3);   /*余数*/
SELECT ceil(5.3);  /*取整函数，不小于*/
SELECT ceiling(5.3);  /*同上*/
SELECT floor(5.3); /*向下取整，不大于*/
SELECT sin(pi()/3),cos(pi()/3),
       tan(pi()/4),cot(pi()/4),
       asin(1),acos(1),
       atan(1),atan2(10,4);   /*三角函数*/
SELECT degrees(pi()/3),radians(60);  /*弧度与角度转换*/
SELECT sign(-1),sign(0),sign(1);  /*符号函数*/

/*日期函数*/
SELECT now(),sysdate();  /*当前DT与系统DT*/
SELECT current_date,current_time;/*当前的D与T*/
SELECT NOW(),DATE_ADD(NOW(),INTERVAL 1 DAY) AS NexDay;
SELECT NOW(),DATE_ADD(NOW(),INTERVAL -1 DAY) AS YesterDay;
SELECT now(),date_add(now(),INTERVAL '01:5:06' DAY_SECOND) AS NewDT;
SELECT NOW(),DATE_SUB(NOW(),INTERVAL 1 WEEK) AS LastWeek;
/*可以增加或减少的关键字有：
YEAR,MONTH,QUARTER,WEEK,DAY,HOUR,MINUTE,SECOND
MICOSECOND(微秒)，YEAR_MONTH(年和月)，DAY-HOUR(小时数’hh‘)
DAY_MINUTE（小时和分钟数’hh:mm‘）
DAY_SECOND('hh:mm:ss')
*/
SELECT monthname(now()) AS MonthName,dayname(now()) AS DayName,
       week(now()) AS 第几周,minute(now()) AS Minute;
/*日期时间提取
DAYOFYEAR()     DAYNAME()        WEEKDAY()  返回0~6,0表示周日
DAYOFMONTH()    MONTHNAME()      WEEK(date) 返回一年中的第几个星期，默认一个星期的第一天是周日
DAYOFWEEK()     YEAR()           WEEK(date,first) 返回一年中的第几个星期，可指定一个星期的的第一天，0表示周日
WEEKOFYEAR()    MONTH()          HOUR() MINUTE() SECOND()  0表示始末时间
*/
SELECT YEAR(now())-3 AS 前三年,year(now())+3 AS 后三年;/*简单时间计算*/
SELECT datediff(now(),'19920103');   /*两个日期的天数*/
SELECT last_day(now());  /*所在日期月份的最后一天的日期*/
select DATE_ADD(curdate(),interval -day(curdate())+1 day);   /*获取本月第一天*/
select date_add(curdate()-day(curdate())+1,interval 1 month); /* 获取下个月的第一天,日期可以直接减去天数*/
select DATEDIFF(date_add(curdate()-day(curdate())+1,interval 1 month ),
                DATE_ADD(curdate(),interval -day(curdate())+1 day)); /*获取当前月的天数*/

/*类型转换*/
/*字符串转换函数*/
SELECT Name ,Population,cast(Population AS CHAR(15))
FROM country;          /*不可转化为同类型*/
/*日期转换函数*/
select now(), date_format(now(),'%W %M%D%Y') AS newdate,
  DATE_FORMAT(NOW(),'%H:%i:%s') AS newtime;
/*其他日期时间格式
%Y(4位数年份) %y(2位数年份)
%M（英文显示月份名） %b（英文简写月份名）%m（以数字01-12显示）%c（以数字1-12显示）
%W（英文星期名）  %a(简写英文星期名) %w（0-6表示星期）
%D（1st,2nd表示天数） %d（01-31表示天数） %e(1-31表示天数)
%U（一年中的星期数，周日为首天） %u（一年中的星期数，周一为首天） --00-52
%j（一年中的天数001-365）
%H（小时01-24） %k(24小时制的小时) %l（12小时制的小时） %I或%h（2位数12小时制的小时）
%i(2位数的分钟)
%S或%s（2位数的秒）
%P（上午AM,下午PM）
%T（24小时制的时间00:00:00-23:23:59）
%r（12小时制的时间12：00：AM-11:59:59PM）
%%（表示标识符%）
*/
/*注意，TIME_FORMAT与DATE_FORMAT用法一致，但只能用来转换时间格式*/

/*比较函数*/
SELECT least(16,5,7,3,8,9);    /*集合中最小*/
SELECT greatest(16,5,7,3,8,9);  /*集合中最大*/
SELECT strcmp('student','students'),
       strcmp('student','STUDENT'),
       strcmp('student','stu');  /*字符串1>字符串2返回1，小于返回-1*/

/*空值转换*/
SELECT ifnull(null,0);   /*如果字段1值为NULL，将其转化为0*/

/*判断空值*/
SELECT Name ,GNPOld FROM country
WHERE GNPOld IS NULL;

SELECT IndepYear,LifeExpectancy,GNPOld,
       coalesce( IndepYear,LifeExpectancy,GNPOld )
FROM country;     /*返回集合中第一个不是空值的值*/


/*if函数条件表达的嵌套*/
SELECT Name ,CountryCode,Population,
  if(
    CountryCode='AFG',Population+5000,
     if(CountryCode='AGO',Population-5000,
       IF(CountryCode='ALB',Population+8000,Population)
     )
  ) AS NewPopulation
FROM city
LIMIT 100;     /*if(表达式，结果1，结果2)*/

/*CASE的分支条件表达*/
SELECT Name,CountryCode,Population,
  CASE CountryCode
    WHEN 'AFG' THEN Population+5000
    WHEN 'AGO' THEN Population-5000
    WHEN 'ALB' THEN Population+8000
    ELSE Population END AS NEWpopulation
FROM city
LIMIT 100;

/*CASE条件表达式中不同条件返回不同结果*/
SELECT Name,CountryCode,Population,
    CASE
    WHEN Population>10000000 THEN Population+5000
    WHEN Population>800000 THEN Population+8000
    WHEN Population>500000 THEN Population+15000
    ELSE Population END AS NEWpopulation
FROM city
LIMIT 100;         /*此种情况CASE后面不跟字段名*/

