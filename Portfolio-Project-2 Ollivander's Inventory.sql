-- A Harry Potter challenge from HackerRank - we are looking for the smallest number of coins needed to buy each wand of interest 

select 
w.id, 
wp.age, 
w.coins_needed, 
w.power
from wands w
inner join wands_property wp
on w.code = wp.code
where (w.power, wp.age, w.coins_needed) in
(select w.power, wp.age, min(w.coins_needed)
from wands w
inner join wands_property wp
on w.code = wp.code
where wp.is_evil = 0
group by wp.age, w.power)
order by w.power desc, wp.age desc
