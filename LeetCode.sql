--I thought it could be interesting including LeetCode solutions that showcase some of my SQL problem solving skills


--We were asked to find the employees who have the highest salary in each department
--Subqueries, Window Functions, Joins

select 

Department, 
Employee,
salary

FROM 

(

select 
d.name Department, 
e.name Employee,
salary,
rank() OVER(partition by d.name order by salary desc) rnk 

from Employee e 
JOIN Department d ON e.departmentId = d.id 
) d 

where rnk = 1
