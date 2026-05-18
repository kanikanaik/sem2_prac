-- create database site1;
-- create database site2;

create table employee (
emp_id int primary key,
name text,
dept_id int,
salary int
);

insert into employee values (1,'Kanika',101,9998), (2,'Prathamesh',101,9999),(3,'Meow',102,1222);

create extension postgres_fdw;

create server site2_server
foreign data wrapper postgres_fdw
options (host'localhost',dbname'site2',port'5432');

create user mapping for current_user
server site2_server
options (user'postgres',password'root');

create foreign table dept_fdw(
	dept_id int,
	dept_name text
) server site2_server
options(table_name'department');

select * from dept_fdw;

select e.emp_id,e.name,e.salary,d.dept_name 
from employee e join dept_fdw d 
on e.dept_id = d.dept_id;
