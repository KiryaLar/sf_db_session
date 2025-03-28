-- Задача 2
select v.maker, v.model, car.horsepower, car.engine_capacity, v.type
from vehicle v
join car on v.model = car.model
where car.horsepower > 150 and car.engine_capacity < 3 and car.price < 35000

union all

select v.maker, v.model, m.horsepower, m.engine_capacity, v.type
from vehicle v
join motorcycle m on v.model = m.model
where m.horsepower > 150 and m.engine_capacity < 1.5 and m.price < 20000

union all

select v.maker, v.model, null as horsepower, null as engine_capacity, v.type
from vehicle v
join bicycle b on v.model = b.model
where b.gear_count > 18 and b.price < 4000

order by horsepower desc nulls last;