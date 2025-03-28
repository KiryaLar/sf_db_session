-- Задача 2
with car_avg_pos as (select cars.name car_name,
                            cars.class car_class,
                            avg(position) avg_pos,
                            count(*) race_count,
                            classes.country prod_country
        from results
        join cars on cars.name = results.car
        join classes on cars.class = classes.class
        group by car_name, car_class, prod_country
        )
select car_name,
       car_class,
       round(avg_pos, 4) as avg_pos,
       race_count,
       prod_country
from car_avg_pos
order by avg_pos, car_name
limit 1;