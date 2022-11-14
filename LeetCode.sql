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


--Finding the fraction of players who logged into this video game for at least two_consecutive days 
--CTEs, Joins, Dates

with first_logins AS (select 

a.player_id,
min(a.event_date) first_login

from Activity a 
group by a.player_id),


conseq_logins as (select 
count(a.player_id) AS num_logins

from first_logins f 
JOIN Activity a ON f.player_id = a.player_id 
AND f.first_login = date_sub(a.event_date, INTERVAL 1 DAY))

select 

round((select num_logins from conseq_logins) / (select count(player_id) from first_logins) ,2 ) fraction 
