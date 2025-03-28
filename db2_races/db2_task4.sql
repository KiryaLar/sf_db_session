-- Задание 4
with avg_pos_class as (
select
    class,
    avg(position) avg_position,
    count(name)
from cars
join results res on cars.name = res.car
group by class
having count(name) > 1
),
avg_pos as (
select
    name,
    class,
    avg(position) avg_position
from cars
join results res on cars.name = res.car
group by name
)
select
    ap.name car_name,
    ap.class car_class,
    ap.avg_position average_position,
    count(res.race) race_count,
    classes.country car_country
from avg_pos_class apc
join avg_pos ap on apc.class = ap.class
join results res on res.car = ap.name
join classes on classes.class = ap.class
where apc.avg_position > ap.avg_position
group by ap.name, ap.class, ap.avg_position, prod_country;
