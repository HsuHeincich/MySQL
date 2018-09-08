CREATE DATABASE mysql_leetcode;
use mysql_leetcode;

#595 Big Countries
CREATE TABLE World(
  name VARCHAR(255),
  continent VARCHAR(255),
  area INT,
  population INT,
  gdp INT
);
INSERT INTO World VALUES
  ('Afghanistan' ,'Asia' ,652230 ,25500100 ,20343000),
  ('Albania' ,'Europe' ,28748 ,2831741 ,12960000),
  ('Algeria' ,'Africa' ,2381741 ,37100000,188681000),
  ('Andorra' ,'Europe' ,468 ,78115 ,3712000),
  ('Angola' ,'Africa' ,1246700 ,20609294 ,100990000);
/*
这里有张 World 表

+-----------------+------------+------------+--------------+---------------+
| name            | continent  | area       | population   | gdp           |
+-----------------+------------+------------+--------------+---------------+
| Afghanistan     | Asia       | 652230     | 25500100     | 20343000      |
| Albania         | Europe     | 28748      | 2831741      | 12960000      |
| Algeria         | Africa     | 2381741    | 37100000     | 188681000     |
| Andorra         | Europe     | 468        | 78115        | 3712000       |
| Angola          | Africa     | 1246700    | 20609294     | 100990000     |
+-----------------+------------+------------+--------------+---------------+
如果一个国家的面积超过300万平方公里，或者人口超过2500万，那么这个国家就是大国家。

编写一个SQL查询，输出表中所有大国家的名称、人口和面积。

例如，根据上表，我们应该输出:

+--------------+-------------+--------------+
| name         | population  | area         |
+--------------+-------------+--------------+
| Afghanistan  | 25500100    | 652230       |
| Algeria      | 37100000    | 2381741      |
+--------------+-------------+--------------+
*/
#solve
select  name ,population ,area from World
where area > 3000000 or population > 25000000;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#182 Duplicate Emails
CREATE TABLE Person(
  id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255)
);
INSERT IGNORE INTO Person VALUES
  (1,'a@b.com'),
  (2,'c@d.com'),
  (3,'a@b.com');
/*
编写一个 SQL 查询，查找 Person 表中所有重复的电子邮箱。

示例：

+----+---------+
| Id | Email   |
+----+---------+
| 1  | a@b.com |
| 2  | c@d.com |
| 3  | a@b.com |
+----+---------+
根据以上输入，你的查询应返回以下结果：

+---------+
| Email   |
+---------+
| a@b.com |
+---------+
说明：所有电子邮箱都是小写字母。
*/
#solve 1
select distinct Email from person
group by email
having count(*) > 1;
#solve 2
select distinct email from person
where email in (
select p1.email from person p1
group by p1.email having count(*)>1);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#620. Not Boring Movies
CREATE TABLE cinema(
  id INT PRIMARY KEY AUTO_INCREMENT,
  movie VARCHAR(255),
  description VARCHAR(255),
  rating FLOAT
);
INSERT INTO cinema(movie, description, rating) VALUES
  ('War','great 3D',8.9),
  ('Science','fiction',8.5),
  ('irish','boring',6.2),
  ('Ice song','Fantacy',8.6),
  ('House card','Interesting',9.1);
/*
某城市开了一家新的电影院，吸引了很多人过来看电影。该电影院特别注意用户体验，专门有个 LED显示板做电影推荐，上面公布着影评和相关电影描述。

作为该电影院的信息部主管，您需要编写一个 SQL查询，找出所有影片描述为非 boring (不无聊) 的并且 id 为奇数 的影片，结果请按等级 rating 排列。



例如，下表 cinema:

+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   1     | War       |   great 3D   |   8.9     |
|   2     | Science   |   fiction    |   8.5     |
|   3     | irish     |   boring     |   6.2     |
|   4     | Ice song  |   Fantacy    |   8.6     |
|   5     | House card|   Interesting|   9.1     |
+---------+-----------+--------------+-----------+
对于上面的例子，则正确的输出是为：

+---------+-----------+--------------+-----------+
|   id    | movie     |  description |  rating   |
+---------+-----------+--------------+-----------+
|   5     | House card|   Interesting|   9.1     |
|   1     | War       |   great 3D   |   8.9     |
+---------+-----------+--------------+-----------+
*/
#solve
select * from cinema where description != 'boring'
and id %2 = 1
order by rating desc;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#627. Swap Salary
CREATE TABLE salary(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  sex CHAR(10),
  salary INT
);
INSERT INTO salary(name, sex, salary) VALUES
  ('A','m',2500),
  ('B','f',1500),
  ('C','m',5500),
  ('D','f',500);
/*
给定一个 salary表，如下所示，有m=男性 和 f=女性的值 。交换所有的 f 和 m 值(例如，将所有 f 值更改为 m，反之亦然)。要求使用一个更新查询，并且没有中间临时表。

例如:

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | m   | 2500   |
| 2  | B    | f   | 1500   |
| 3  | C    | m   | 5500   |
| 4  | D    | f   | 500    |
运行你所编写的查询语句之后，将会得到以下表:

| id | name | sex | salary |
|----|------|-----|--------|
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |
*/
#solve
update salary set sex= case sex
when 'm' then 'f'
else 'm'
end;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#181. Employees Earning More Than Their Managers
CREATE TABLE Employee(
  Id INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(255),
  Salary INT,
  ManagerId INT DEFAULT NULL
);
INSERT INTO Employee(Name, Salary ,ManagerId) VALUES
  ('Joe' ,7000 ,3),
  ('Henry',8000,4),
  ('Sam',6000,NULL ),
  ('Max',9000,NULL );
/*
Employee 表包含所有员工，他们的经理也属于员工。每个员工都有一个 Id，此外还有一列对应员工的经理的 Id。

+----+-------+--------+-----------+
| Id | Name  | Salary | ManagerId |
+----+-------+--------+-----------+
| 1  | Joe   | 70000  | 3         |
| 2  | Henry | 80000  | 4         |
| 3  | Sam   | 60000  | NULL      |
| 4  | Max   | 90000  | NULL      |
+----+-------+--------+-----------+
给定 Employee 表，编写一个 SQL 查询，该查询可以获取收入超过他们经理的员工的姓名。在上面的表格中，Joe 是唯一一个收入超过他的经理的员工。

+----------+
| Employee |
+----------+
| Joe      |
+----------+
*/
#slove
select e3.Name Employee from
(select e1.* ,e2.salary manager_salary from employee e1 inner join employee e2 on e1.ManagerId = e2.id) e3
where e3.salary > e3.manager_salary;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#196. Delete Duplicate Emails
/*
编写一个 SQL 查询，来删除 Person 表中所有重复的电子邮箱，重复的邮箱里只保留 Id 最小 的那个。

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | a@b.com |
| 2  | c@d.com  |
| 3  | a@b.com |
+----+------------------+
Id 是这个表的主键。
例如，在运行你的查询语句之后，上面的 Person 表应返回以下几行:

+----+------------------+
| Id | Email            |
+----+------------------+
| 1  | a@b.com |
| 2  | c@d.com  |
+----+------------------+
*/
#solve1 select
select *  FROM person
where id in (SELECT min(p1.id) FROM person p1 GROUP BY p1.email);

#solve2 delete(注意更新和删除不能在从句中更新，需要在外层嵌套一张表)
delete FROM person
where id not in (SELECT p2.min_id FROM   #嵌套一张表
                   (SELECT min(p1.id) min_id FROM person p1 GROUP BY p1.email) p2);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#197. Rising Temperature
CREATE TABLE Weather (
  id INT PRIMARY KEY  AUTO_INCREMENT,
  RecordDate DATE,
  Temperature INT
);
INSERT INTO Weather(RecordDate,Temperature) VALUES
  ('2015-01-01',10),
  ('2015-01-02',25),
  ('2015-01-03',20),
  ('2015-01-04',30);
/*
给定一个 Weather 表，编写一个 SQL 查询，来查找与之前（昨天的）日期相比温度更高的所有日期的 Id。

+---------+------------------+------------------+
| Id(INT) | RecordDate(DATE) | Temperature(INT) |
+---------+------------------+------------------+
|       1 |       2015-01-01 |               10 |
|       2 |       2015-01-02 |               25 |
|       3 |       2015-01-03 |               20 |
|       4 |       2015-01-04 |               30 |
+---------+------------------+------------------+
例如，根据上述给定的 Weather 表格，返回如下 Id:

+----+
| Id |
+----+
|  2 |
|  4 |
+----+
*/
#solve
select id from
(select w1.id ,w1.Temperature today_t ,w2.Temperature lastday_t from
weather w1 inner join weather w2 on date_add(w1.RecordDate,interval -1 day) = w2.RecordDate) as w3
where w3.today_t > w3.lastday_t;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#626. Exchange Seats
CREATE TABLE seat(
  id INT PRIMARY KEY  AUTO_INCREMENT,
  student VARCHAR(255)
);
INSERT INTO seat(student) VALUES
  ('Abbot'),
  ('Doris'),
  ('Emerson'),
  ('Green'),
  ('Jeames');
/*
小美是一所中学的信息科技老师，她有一张 seat 座位表，平时用来储存学生名字和与他们相对应的座位 id。

其中纵列的 id 是连续递增的

小美想改变相邻俩学生的座位。

你能不能帮她写一个 SQL query 来输出小美想要的结果呢？



示例：

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Abbot   |
|    2    | Doris   |
|    3    | Emerson |
|    4    | Green   |
|    5    | Jeames  |
+---------+---------+
假如数据输入的是上表，则输出结果如下：

+---------+---------+
|    id   | student |
+---------+---------+
|    1    | Doris   |
|    2    | Abbot   |
|    3    | Green   |
|    4    | Emerson |
|    5    | Jeames  |
+---------+---------+
注意：

如果学生人数是奇数，则不需要改变最后一个同学的座位。
*/
#solve 1
select seat_new.id ,(case when seat_new.new_s is null then seat_new.old_s else seat_new.new_s end) as student from
(select s1.id ,s1.student old_s ,s2.student new_s from seat s1 left join
(select (case when id % 2 = 1 then id+1 else id-1 end) as new_id ,student from seat) as s2
on s1.id = s2.new_id
order by s1.id) as seat_new;

#solve 2
#step1
CREATE VIEW seat_new AS
(select s1.id ,s1.student old_s ,s2.student new_s from seat s1 left join
(select (case when id % 2 = 1 then id+1 else id-1 end) as new_id ,student from seat) as s2
on s1.id = s2.new_id
order by s1.id) ;
#step2
select seat_new.id ,(case when seat_new.new_s is null then seat_new.old_s
                     else seat_new.new_s end) as student from seat_new;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#178. Rank Scores
CREATE TABLE Scores(
  id INT PRIMARY KEY AUTO_INCREMENT,
  score FLOAT
);
INSERT INTO Scores(score) VALUES
  (3.50),
  (3.65),
  (4.00),
  (3.85),
  (4.00),
  (3.65);
#solve
SELECT s1.Score ,count(DISTINCT s2.score) Rank from scores s1 JOIN scores s2
ON s1.score <= s2.score
GROUP BY s1.id
ORDER BY s1.score DESC ;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#180. Consecutive Numbers
CREATE TABLE Logs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  Num INT
);
INSERT INTO Logs(Num) VALUES
  (1),(1),(1),(2),(1),(2),(2);
/*
编写一个 SQL 查询，查找所有至少连续出现三次的数字。

+----+-----+
| Id | Num |
+----+-----+
| 1  |  1  |
| 2  |  1  |
| 3  |  1  |
| 4  |  2  |
| 5  |  1  |
| 6  |  2  |
| 7  |  2  |
+----+-----+
例如，给定上面的 Logs 表， 1 是唯一连续出现至少三次的数字。

+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
*/
#solve1
SELECT DISTINCT l1.num FROM Logs l1
JOIN Logs l2 ON l1.Id = l2.Id - 1
JOIN Logs l3 ON l1.Id = l3.Id - 2
WHERE l1.Num = l2.Num AND l2.Num = l3.Num;

#solve2
SELECT DISTINCT l1.Num FROM Logs l1, Logs l2, Logs l3
WHERE l1.Id = l2.Id - 1 AND l2.Id = l3.Id - 1
AND l1.Num = l2.Num AND l2.Num = l3.Num;

#solve3
SELECT DISTINCT new_logs.num as Num FROM
  (SELECT num ,@count := if(@a = num ,@count + 1, 1) AS continue_n ,@a := num FROM logs,
  (SELECT @count := 0 ,@a := -1) AS init) AS new_logs
WHERE new_logs.continue_n >= 3;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#177. Nth Highest Salary
CREATE TABLE salary_177 (
  id  INT PRIMARY KEY  AUTO_INCREMENT,
  salary INT
);
INSERT INTO salary_177(salary) VALUES
  (100),(200),(300);
/*
编写一个 SQL 查询，获取 Employee 表中第 n 高的薪水（Salary）。

+----+--------+
| Id | Salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
例如上述 Employee 表，n = 2 时，应返回第二高的薪水 200。如果不存在第 n 高的薪水，那么查询应返回 null。

+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
*/
#solve1
CREATE FUNCTION getNthHighestSalary1(N INT) RETURNS INT
BEGIN
SET N = N -1;
RETURN (SELECT DISTINCT salary FROM Employee
  ORDER BY salary DESC
  LIMIT N,1
);
END;
SELECT getNthHighestSalary1(2);

#solve2
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      SELECT MAX(Salary) FROM Employee E1
      WHERE N - 1 =
      (SELECT COUNT(DISTINCT(E2.Salary)) FROM Employee E2
      WHERE E2.Salary > E1.Salary)
  );
END;
SELECT getNthHighestSalary(2);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#184. Department Highest Salary
CREATE TABLE Employee_184 (
  Id INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(255),
  Salary INT,
  DepartmentId INT
);
INSERT INTO Employee_184(Name, Salary ,DepartmentId) VALUES
  ('Joe' ,70000,1),
  ('Henry',80000,2),
  ('Sam',60000,2),
  ('Max',90000,1);
CREATE TABLE Department (
  id INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(255)
);
INSERT INTO Department(Name) VALUES
  ('IT'),('Sales');
/*
Employee 表包含所有员工信息，每个员工有其对应的 Id, salary 和 department Id。

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department 表包含公司所有部门的信息。

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
编写一个 SQL 查询，找出每个部门工资最高的员工。例如，根据上述给定的表格，Max 在 IT 部门有最高工资，Henry 在 Sales 部门有最高工资。

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |
+------------+----------+--------+
*/
#slove
select d.Name Department ,e1.Name Employee ,e1.Salary
from Employee_184 e1 inner join Department d
on e1.DepartmentId = d.Id
where e1.salary in
(select max(e2.salary) max_salary from Employee_184 e2
group by DepartmentId);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#601. Human Traffic of Stadium
CREATE TABLE stadium(
  id INT PRIMARY KEY AUTO_INCREMENT,
  date DATE,
  people INT
);INSERT INTO stadium(date, people) VALUES
  ('2017-01-01',10),
  ('2017-01-02',109),
  ('2017-01-03',150),
  ('2017-01-04',99),
  ('2017-01-05',145),
  ('2017-01-06',1455),
  ('2017-01-07',199),
  ('2017-01-08',188);
/*
X 市建了一个新的体育馆，每日人流量信息被记录在这三列信息中：序号 (id)、日期 (date)、 人流量 (people)。

请编写一个查询语句，找出高峰期时段，要求连续三天及以上，并且每天人流量均不少于100。

例如，表 stadium：

+------+------------+-----------+
| id   | date       | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
对于上面的示例数据，输出为：

+------+------------+-----------+
| id   | date       | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-08 | 188       |
+------+------------+-----------+
Note:
每天只有一行记录，日期随着 id 的增加而增加。
*/
#solve
select id,date,people
from(
    select *,
        if( (continue_days>= 3 ) or (@yesterday_flag = 1 and continue_days > 0), @flag := 1, @flag := 0) as flag,
        (@yesterday_flag := @flag) as yesterday_flag
    from (
        select *
        from (
            select stadium.*,
                if(people >= 100, @continue_days := @continue_days + 1, @continue_days := 0) as continue_days
            from
                stadium,
                (select(@continue_days := 0)) b
            ) c
        order by date desc) d,
        (select(@flag := 0)) e,
        (select(@yesterday_flag := 0)) f
    ) g
where flag = 1
order by id ;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#262. Trips and Users
CREATE TABLE Trips(
  id INT PRIMARY KEY AUTO_INCREMENT,
  Client_Id INT,
  Driver_Id INT,
  City_Id INT,
  Status VARCHAR(255),
  Request_at DATE
);
INSERT INTO Trips(Client_Id,Driver_Id,City_Id,Status,Request_at) VALUES
  (1 ,10 ,1 ,'completed' ,'2013-10-01'),
  (2 ,11 ,1 ,'cancelled_by_driver' ,'2013-10-01'),
  (3 ,12 ,6 ,'completed' ,'2013-10-01'),
  (4 ,13 ,6 ,'cancelled_by_client' ,'2013-10-01'),
  (1 ,10 ,1 ,'completed' ,'2013-10-02'),
  (2 ,11 ,6 ,'completed' ,'2013-10-02'),
  (3 ,12 ,6 ,'completed' ,'2013-10-02'),
  (2 ,12 ,12 ,'completed' ,'2013-10-03'),
  (3 ,10 ,12 ,'completed' ,'2013-10-03'),
  (4 ,13 ,12 ,'cancelled_by_driver' ,'2013-10-03');
CREATE TABLE Users(
  Users_Id INT PRIMARY KEY,
  Banned VARCHAR(255),
  Role VARCHAR(255)
);
INSERT INTO Users VALUES
  (1,'No', 'client'),
  (2,'Yes', 'client'),
  (3,'No', 'client'),
  (4,'No', 'client'),
  (10,'No', 'driver'),
  (11,'No', 'driver'),
  (12,'No', 'driver'),
  (13,'No', 'driver');
/*
Trips 表中存所有出租车的行程信息。每段行程有唯一健 Id，Client_Id 和 Driver_Id 是 Users 表中 Users_Id 的外键。Status 是枚举类型，枚举成员为 (‘completed’, ‘cancelled_by_driver’, ‘cancelled_by_client’)。

+----+-----------+-----------+---------+--------------------+----------+
| Id | Client_Id | Driver_Id | City_Id |        Status      |Request_at|
+----+-----------+-----------+---------+--------------------+----------+
| 1  |     1     |    10     |    1    |     completed      |2013-10-01|
| 2  |     2     |    11     |    1    | cancelled_by_driver|2013-10-01|
| 3  |     3     |    12     |    6    |     completed      |2013-10-01|
| 4  |     4     |    13     |    6    | cancelled_by_client|2013-10-01|
| 5  |     1     |    10     |    1    |     completed      |2013-10-02|
| 6  |     2     |    11     |    6    |     completed      |2013-10-02|
| 7  |     3     |    12     |    6    |     completed      |2013-10-02|
| 8  |     2     |    12     |    12   |     completed      |2013-10-03|
| 9  |     3     |    10     |    12   |     completed      |2013-10-03|
| 10 |     4     |    13     |    12   | cancelled_by_driver|2013-10-03|
+----+-----------+-----------+---------+--------------------+----------+
Users 表存所有用户。每个用户有唯一键 Users_Id。Banned 表示这个用户是否被禁止，Role 则是一个表示（‘client’, ‘driver’, ‘partner’）的枚举类型。

+----------+--------+--------+
| Users_Id | Banned |  Role  |
+----------+--------+--------+
|    1     |   No   | client |
|    2     |   Yes  | client |
|    3     |   No   | client |
|    4     |   No   | client |
|    10    |   No   | driver |
|    11    |   No   | driver |
|    12    |   No   | driver |
|    13    |   No   | driver |
+----------+--------+--------+
写一段 SQL 语句查出 2013年10月1日 至 2013年10月3日 期间非禁止用户的取消率。基于上表，你的 SQL 语句应返回如下结果，取消率（Cancellation Rate）保留两位小数。

+------------+-------------------+
|     Day    | Cancellation Rate |
+------------+-------------------+
| 2013-10-01 |       0.33        |
| 2013-10-02 |       0.00        |
| 2013-10-03 |       0.50        |
+------------+-------------------+
*/
#solve
SELECT Request_at Day, ROUND(COUNT(IF(Status != 'completed', TRUE, NULL)) / COUNT(*), 2) 'Cancellation Rate'
FROM Trips WHERE (Request_at between '2013-10-01' and '2013-10-03')
and Client_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
and Driver_Id IN (SELECT Users_Id FROM Users WHERE Banned = 'No')
GROUP BY Request_at;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#185. Department Top Three Salaries
CREATE TABLE Employee_185(
    Id INT PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(255),
  Salary INT,
  DepartmentId INT
);
INSERT INTO Employee_185(Name, Salary ,DepartmentId) VALUES
  ('Joe' ,70000,1),
  ('Henry',80000,2),
  ('Sam',60000,2),
  ('Max',90000,1),
  ('Janet',69000,1),
  ('Randy',85000,1);
/*
Employee 表包含所有员工信息，每个员工有其对应的 Id, salary 和 department Id 。

+----+-------+--------+--------------+
| Id | Name  | Salary | DepartmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
+----+-------+--------+--------------+
Department 表包含公司所有部门的信息。

+----+----------+
| Id | Name     |
+----+----------+
| 1  | IT       |
| 2  | Sales    |
+----+----------+
编写一个 SQL 查询，找出每个部门工资前三高的员工。例如，根据上述给定的表格，查询结果应返回：

+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Randy    | 85000  |
| IT         | Joe      | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
*/
#solve1
SELECT d.name Department ,E1.Name Employee,  E1.Salary
FROM Employee_185 E1, Employee_185 E2 ,Department d
WHERE E1.DepartmentID = E2.DepartmentID
AND d.id = E1.DepartmentId
AND E2.Salary >= E1.Salary
GROUP BY E1.Name
HAVING COUNT(DISTINCT E2.Salary) <= 3
ORDER BY E1.departmentid, E1.Salary DESC;

#slove2
SELECT d.name Department ,e1.Name AS Employee, e1.Salary
FROM employee_185 e1,Department d
WHERE 3 > (SELECT COUNT(DISTINCT e2.Salary)  FROM employee_185 e2
           WHERE e2.Salary > e1.Salary AND e1.DepartmentId = e2.DepartmentId)
AND e1.DepartmentId = d.id;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************//******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#补充的牛客的mysql题
CREATE DATABASE mysql_sup;
use mysql_sup;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#获取所有非manager的员工emp_no
CREATE TABLE `dept_manager` (
`dept_no` char(4) NOT NULL,
`emp_no` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
INSERT INTO dept_manager VALUES('d001',10002,'1996-08-03','9999-01-01');
INSERT INTO dept_manager VALUES('d002',10006,'1990-08-05','9999-01-01');
INSERT INTO dept_manager VALUES('d003',10005,'1989-09-12','9999-01-01');
INSERT INTO dept_manager VALUES('d004',10004,'1986-12-01','9999-01-01');
INSERT INTO dept_manager VALUES('d005',10010,'1996-11-24','2000-06-26');
INSERT INTO dept_manager VALUES('d006',10010,'2000-06-26','9999-01-01');
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');
#solve1
select e.emp_no from
employees e left join dept_manager d
on e.emp_no = d.emp_no
where d.emp_no is null;

#solve2
select emp_no from
employees
WHERE emp_no NOT IN
      (SELECT emp_no FROM dept_manager);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#构造一个触发器audit_log，在向employees_test表中插入一条数据的时候，触发插入相关的数据到audit中。
CREATE TABLE employees_test(
ID INT PRIMARY KEY NOT NULL,
NAME TEXT NOT NULL,
AGE INT NOT NULL,
ADDRESS CHAR(50),
SALARY REAL
);
CREATE TABLE audit(
EMP_no INT NOT NULL,
NAME TEXT NOT NULL
);
#slove
DROP trigger if exists audit_log;

create trigger audit_log after insert on employees_test
  FOR EACH ROW
begin
     insert into audit values(new.id,new.name);
end;

INSERT IGNORE INTO employees_test VALUES
(1,'heinrich',18,'zzz',200000);
/*
1.创建触发器使用语句：CREATE TRIGGER trigname;
2.指定触发器触发的事件在执行某操作之前还是之后，使用语句：BEFORE/AFTER [INSERT/UPDATE/ADD] ON tablename
3.触发器触发的事件写在BEGIN和END之间；
4.触发器中可以通过NEW获得触发事件之后2对应的tablename的相关列的值，OLD获得触发事件之前的2对应的tablename的相关列的值
*/
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#replace的使用
REPLACE INTO employees_test VALUES
  (1,'heinrich',20,'zzz',500000);
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#rename的使用
alter table employees_test rename to employees_test;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#查找字符串'awasdjxhyalksjxhyaskhjkzxhkjlxhyhxahlkas' 中逗号'xhy'出现的次数cnt
select round((length('awasdjxhyalksjxhyaskhjkzxhkjlxhyhxahlkas')-
        length(replace('awasdjxhyalksjxhyaskhjkzxhkjlxhyhxahlkas','xhy','')))/length('xhy'),0) as cnt;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#按照dept_no进行汇总，属于同一个部门的emp_no按照逗号进行连接，结果给出dept_no以及连接出的结果employees
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
INSERT INTO dept_emp VALUES(10001,'d001','1986-06-26','9999-01-01');
INSERT INTO dept_emp VALUES(10002,'d001','1996-08-03','9999-01-01');
INSERT INTO dept_emp VALUES(10003,'d004','1995-12-03','9999-01-01');
INSERT INTO dept_emp VALUES(10004,'d004','1986-12-01','9999-01-01');
INSERT INTO dept_emp VALUES(10005,'d003','1989-09-12','9999-01-01');
INSERT INTO dept_emp VALUES(10006,'d002','1990-08-05','9999-01-01');
INSERT INTO dept_emp VALUES(10007,'d005','1989-02-10','9999-01-01');
INSERT INTO dept_emp VALUES(10008,'d005','1998-03-11','2000-07-31');
INSERT INTO dept_emp VALUES(10009,'d006','1985-02-18','9999-01-01');
INSERT INTO dept_emp VALUES(10010,'d005','1996-11-24','2000-06-26');
INSERT INTO dept_emp VALUES(10010,'d006','2000-06-26','9999-01-01');
#slove
SELECT dept_no, group_concat(emp_no) AS employees
FROM dept_emp GROUP BY dept_no;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#按照salary的累计和running_total，其中running_total为前两个员工的salary累计和，其他以此类推。
CREATE TABLE `salaries` ( `emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO salaries VALUES(10001,60117,'1986-06-26','1987-06-26');
INSERT INTO salaries VALUES(10002,62102,'1987-06-26','1988-06-25');
INSERT INTO salaries VALUES(10003,66074,'1988-06-25','1989-06-25');
INSERT INTO salaries VALUES(10004,66596,'1989-06-25','1990-06-25');
INSERT INTO salaries VALUES(10005,66961,'1990-06-25','1991-06-25');
INSERT INTO salaries VALUES(10006,71046,'1991-06-25','1992-06-24');
INSERT INTO salaries VALUES(10001,74333,'1992-06-24','1993-06-24');
#slove
select s1.emp_no ,s1.salary ,(select sum(s2.salary) from salaries s2
                             where s2.emp_no <= s1.emp_no ) as running_total
from salaries s1
order by s1.emp_no;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#常见查询--生成新老用户数
CREATE TABLE IF NOT EXISTS user(
  id INT PRIMARY KEY,
  registered INT,
  login INT
);
INSERT IGNORE INTO user VALUES
  (1,1,2),(1,2,2),(3,3,5),(4,2,4),(5,5,5),(6,12,17),(7,11,11);
#slove
SELECT sum(u1.old_new) AS new_user ,count(*)-sum(u1.old_new) as old_user
from (SELECT * ,CASE WHEN registered = login THEN 1 ELSE 0 END AS old_new from user) as u1; #1表示新用户，0表示老用户
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#根据已有表生成新表
CREATE TABLE user_copy AS
  (SELECT id ,registered FROM user);
DROP TABLE if exists user_copy;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#索引
#增加主键的方式
ALTER TABLE user ADD PRIMARY KEY (id);
ALTER TABLE user DROP PRIMARY KEY ;
#增加索引的方式
CREATE UNIQUE INDEX id_unique_index ON user(id);
DROP INDEX id_unique_index ON user;
ALTER TABLE user ADD UNIQUE id_unique_index_2 (id) ;
ALTER TABLE user DROP INDEX id_unique_index_2;
SHOW KEYS FROM user;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#去重，对于重复的选择最小的id
SELECT * FROM user
WHERE id IN (SELECT min(id) FROM user GROUP BY login)
GROUP BY login;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#查询某个库中的信息
SELECT
TABLE_NAME,            -- 表名
COLUMN_NAME,           -- 字段名
DATA_TYPE,             -- 字段类型
COLUMN_COMMENT         -- 字段注释
FROM
INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'mysql_sup';
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#对所有表写select * from table_name
SELECT concat("select count(*) from ",new.table_name,";") AS sql_quire
FROM
(SELECT DISTINCT TABLE_NAME FROM information_schema.columns WHERE table_schema = 'mysql_sup') AS new;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#生成自增序列
#solve1
SELECT @rownum:=@rownum+1 AS seq, user.* FROM  user ,(SELECT @rownum:=0) r;

#solve2
SET @rowNo=0;
select (@rowNo := @rowNo+1) AS seq,u2.* from user u2 ;
/******************************************************************************************************************/
/******************************************************************************************************************/
/******************************************************************************************************************/
#字符类型转化--BINARY 、CHAR() 、DATE、TIME、DATETIME、DECIMAL、SIGNED、UNSIGNED
SELECT CAST(123.45 AS CHAR);
SELECT convert(123.45,char(10));
SELECT cast('123.45' AS DECIMAL(10,2));
select convert(123.45,decimal(10,2));
SELECT truncate(123.45,2);
#特定字符拼接
select substring_index(cast(123.4554648 as CHAR),'.',1);
select substring_index('12356.5698745','.',1) + substring('12356.5698745',locate('.','12356.5698745'),3);
SELECT locate('.','12356.5698745');
