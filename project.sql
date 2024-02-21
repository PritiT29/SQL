-- to retrieve  the data from the employees table
select * from employees;

--to find  highest salary in each deapartment

select  e.department_id, max(salary)
  from employees e
 group by e.department_id
 order by e.department_id;
 
 
 --to find employees hire date after 1998 and salary between 10000-20000
 
 select * from employees e where to_char(e.hire_date,'yyyy')>1998 and salary between 10000 and 20000
  
 
 --to find the employee getting the nth salary
  
 SELECT EMPLOYEE_ID, FIRST_NAME
   FROM (SELECT E.EMPLOYEE_ID,
                E.FIRST_NAME,
                DENSE_RANK() OVER(ORDER BY SALARY DESC) R
           FROM EMPLOYEES E)
  WHERE R = &N 
   
  
  
SELECT *
  FROM EMPLOYEES 
 WHERE (&N - 1) = (SELECT COUNT(DISTINCT SALARY)
                   FROM EMPLOYEES E1
                  WHERE E1.SALARY > E.SALARY);
  

 -- to find employees who are earning more than avg in their department
 
 select *
   from employees e
  where salary > (select avg(salary)
                    from employees e1
                   where e.department_id = e1.department_id
                   group by department_id)
  order by e.employee_id;
   
  
  --employee,employees department id ,total count of his department,employees managers name,department and count in his department using with clause
with dep_cnt as
 (select department_id, count(1) cnt from employees group by department_id)

select e.employee_id    emp_id,
       e.first_name     emp_name,
       d.cnt            dep_count,
       m.first_name     manager_name,
       md.department_id mgr_dept,
       md.cnt           mgr_dep_cnt
  from employees e, dep_cnt d, employees m, dep_cnt md
 where e.department_id = d.department_id
   and e.manager_id = m.employee_id
   and m.department_id = md.department_id
 order by e.employee_id
 
 
 --to join employees table and department table to get department name
 
 select *
   from employees e
  inner join departments d
     on e.department_id = d.department_id

