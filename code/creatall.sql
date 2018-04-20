CREATE DATABASE test_STInfo;
use test_stinfo;
CREATE TABLE T_student (
  stuID VARCHAR(15) PRIMARY KEY AUTO_INCREMENT,
  stuName VARCHAR(10) NOT NULL ,
  age INT NOT NULL ,
  sex VARCHAR(2) NOT NULL ,
  birth DATETIME NOT NULL
);
CREATE  TABLE T_dept (
  deptID VARCHAR(15) UNIQUE ,
  deptName VARCHAR(10)
);

CREATE TABLE T_result (
  stuID  VARCHAR(15) NOT NULL,
  curID  VARCHAR(15) NOT NULL,
  result DOUBLE,
  PRIMARY KEY (stuID,curID),
  FOREIGN KEY (stuID) REFERENCES T_student (stuID) ON DELETE CASCADE
);
CREATE TABLE T_curriculum (
  curID VARCHAR(15) PRIMARY KEY ,
  curName VARCHAR(10) ,
  credit INT,
  CHECK (credit BETWEEN 3 AND 8)
);
CREATE TABLE T_teacher (
  teaID VARCHAR(15) PRIMARY KEY ,
  teaName VARCHAR(10) NOT NULL ,
  age INT NOT NULL ,
  sex VARCHAR(2) NOT NULL ,
  deptID VARCHAR(15) ,
  dept VARCHAR(20) NOT NULL ,
  profession VARCHAR(10)
);
CREATE INDEX i_profession ON T_teacher(profession ASC );
CREATE INDEX i_dept_profession ON T_teacher(dept,profession);
ALTER TABLE T_teacher DROP INDEX i_profession;
ALTER TABLE T_teacher ADD salary INT NOT NULL ;
ALTER TABLE T_dept ADD PRIMARY KEY (deptID);
ALTER TABLE T_result ADD FOREIGN KEY (curID) REFERENCES T_curriculum(curID);
ALTER TABLE T_curriculum ADD INDEX i_credit(credit DESC );
ALTER TABLE  T_student MODIFY sex CHAR(2);
ALTER TABLE T_teacher DROP salary;
ALTER TABLE T_dept DROP PRIMARY KEY ;
ALTER TABLE T_curriculum DROP INDEX i_credit;
DROP TABLE T_teacher;

CREATE TABLE Orders (
  ID_o VARCHAR(255) NOT NULL ,
  sales INT(5) ,
  CONSTRAINT pk_o PRIMARY KEY (ID_o)
);


/*创建视图-相当于新表存在*/
USE world;
CREATE VIEW V_country
  AS
  SELECT * FROM country;

CREATE VIEW V_country2(V_name,V_population,V_code)  /*不指定的列与FROM表列名相同*/
  AS
  SELECT Name ,Population,Code
  FROM country;

SELECT Name ,Population FROM V_country;

/*创建视图就是在查询前加上CREATE VIEW V_VIEW([列1]，[列2]，...) AS即可
 可以连接后创建视图，分组后创建视图，各种函数查询后创建视图*/

/*利用视图创建视图，相当于将条件进行多次拆分，便于将复杂的查询分开写*/
CREATE VIEW V_country3(V_name3)
AS
SELECT V_name
FROM V_country2;
/*对于复杂的查询，可以先查询一步将其存为视图，然后再在视图进行进一步查询*/

/*对视图添加约束*/
/*CHECK约束*/
CREATE VIEW V_country4(V_name4,V_code4)
  AS
  SELECT Name,Code
  FROM country
  WHERE Code='AFG'
  WITH CHECK OPTION ;  /*这里的CHECK约束针对条件语句，即生成的视图中存在约束
                       若想在生成的视图插入数据，其code必须是AFG，若想对该视图
                       进行更新操作，只能更改除code列的其他列*/

DROP VIEW V_country4;  /*删除视图*/

/*插入数据*/
USE test_stinfo;

ALTER TABLE T_student ALTER COLUMN age SET DEFAULT 20;
ALTER TABLE T_student MODIFY COLUMN birth DATE;
ALTER TABLE T_student ALTER COLUMN birth SET DEFAULT NULL ;
/*修改表列的类型modify,修改表列的默认alter，set default*/

INSERT INTO T_student(stuID, stuName)
VALUE ('s001','Yuan');  /*指定列插入，其他字段必须有默认值*/

INSERT INTO T_student
VALUE ('s002','bin','18','男','19980820');   /*省略表明，插入全部字段*/

INSERT INTO T_curriculum
    VALUE ('c001','数学','2');

INSERT INTO T_result
VALUE ('s001','c001',78);  /*在向具有外键约束的表中插入数据，必须满足所有的
                          外键约束，即他对应的所有主表已经存在该信息（对应的匹配关键字）*/
/*向视图插入数据与向表插入数据一样，最终会转换到向表插入数据，但有部分限制，因此不建议*/

UPDATE T_student SET stuID='s003'
WHERE stuID='s002';    /*有链接外表的，若更新会导致外表改变则报错，需要添加on update cascade；
同样有外键约束的从表更新会导致主表信息改变，则先需要，先改变主表信息。*/

ALTER TABLE t_result
DROP FOREIGN KEY t_result_ibfk_1;
ALTER TABLE t_result
ADD CONSTRAINT t_result_ibfk_1
  FOREIGN KEY (stuID)
  REFERENCES t_student(stuID)
  ON DELETE CASCADE
  ON UPDATE CASCADE;   /*修改外键约束的方式，先删除后添加*/

UPDATE T_student SET stuID='s004'
WHERE stuID='s001';   /*添加ON UPDATE CASCADE 后即可修改有链接外表的主表信息*/

/*利用子查询修改数据*/  /*将学号s004的学生的性别和生日改为等于学号为s003的学生*/
UPDATE T_student SET sex=
(
  SELECT tstusex.sex
  FROM (
    SELECT sex
    FROM T_student
    WHERE stuID = 's003'
  ) AS tstusex
),
  birth =                    /*修改两个列不能一起修改，很伤*/
  (
      SELECT tstubirth.birth
    FROM (
      SELECT birth
      FROM T_student
      WHERE stuID='s003'
    ) AS tstubirth
  )
WHERE stuID='s004';   /*from子句结果不能直接更改，因此需在外面套一个子句*/

UPDATE T_student SET age=20 WHERE stuID='s004';

UPDATE T_student SET age=
CASE
    WHEN age <=18 THEN age-1
    WHEN age >18 THEN age+1
    ELSE age
    END
;          /*利用case语句方便修改多行值*/

DELETE FROM T_result WHERE stuID='s004';
/*有外键约束的字表删除信息时，需要指定on delete cascade*/
/*当字表的外键约束指定了on delete cascade 时，可以从主表删除数据，字表若存在关联的信息也被删除*/

INSERT INTO T_result
VALUE ('s004','c001',78);

DELETE  FROM T_student
WHERE stuID=
      (
        SELECT T_result.stuID FROM T_result
        WHERE T_result.result=78
      )
;    /*子查询删除，删除学生表中成绩为78的学生信息*/

/*TRUNCATE删除所有记录，但保留表结构*/
TRUNCATE TABLE T_result;  /*无法删除子表具有外键约束的主表，除非删除外键约束，但可以删除
具有外键约束的子表。*/

/*权限*/
/*
数据表：SELECT INSERT UPDATE DELETE ALTER INDEX ALL PRIVIEGES
视图：  SELECT INSERT UPDATE DELETE ALL PRIVIEGES
数据列：SELECT INSERT UPDATE DELETE ALL PRIVIEGES
*/
/*以下例子由于没有足够的用户和数据库及数据表，只范例，不操作*/
USE world;
GRANT SELECT ON TABLE city TO user2; /*将数据表city的查询权限赋给用户user2*/

GRANT INSERT ,UPDATE ,DELETE
ON TABLE city
TO use2,user3;

GRANT ALL PRIVILEGES ON TABLE city TO user3;

GRANT UPDATE (Name,Population) ON TABLE city TO user2;/*表的部分列的部分权限授予*/

GRANT SELECT ON TABLE city TO user2
WITH GRANT OPTION ;  /*授予2的查询权限，同时允许2将查询权限授予其他用户*/

REVOKE SELECT ON TABLE city FROM user2;/*回收授权*/

