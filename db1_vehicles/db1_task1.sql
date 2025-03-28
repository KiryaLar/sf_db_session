-- Задача 1
select maker, m.model
from vehicle v
join motorcycle m on v.model = m.model
where horsepower > 150
  and price < 20000
  and m.type = 'Sport'
order by horsepower desc;