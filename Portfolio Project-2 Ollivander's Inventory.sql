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


-- Same thing, but with a window function

SELECT id, age, coins_needed, power
FROM
    (SELECT 
        W.id,
        Wp.age,
        W.coins_needed,
        W.power,
        DENSE_RANK() OVER(
            PARTITION BY W.power, Wp.age
            ORDER BY W.coins_needed
        ) power_age_rank
    FROM Wands W
    JOIN Wands_Property Wp  ON W.code=Wp.code AND Wp.is_evil=0
) d 
WHERE power_age_rank=1
ORDER BY power DESC, age DESC
