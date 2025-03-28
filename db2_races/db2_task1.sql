-- Задача 1
with car_avg_pos as (select cars.name car_name,
                        cars.class car_class,
                        avg(res.position) avg_pos,
                        count(res.race) race_count
    from cars
    join results res on cars.name = res.car
    group by cars.name, cars.class
    ),
    min_pos_class as (select car_class,
                             min(avg_pos) as min_avg_pos
    from car_avg_pos
    group by car_class)
select cap.car_name,
       cap.car_class,
       round(cap.avg_pos, 4) as average_position,
       cap.race_count
from car_avg_pos cap
join min_pos_class mpc on cap.car_class = mpc.car_class
                              and cap.avg_pos = mpc.min_avg_pos
order by avg_pos;