with class_data as (
select
    cars.class car_class,
    count(cars.name) car_count,
    count(res.race) total_races
from cars
join results res on res.car = cars.name
group by cars.class
),
car_data as (
    select
        cars.name car_name,
        cars.class car_class,
        avg(res.position) average_position,
        count(res.race) race_count,
        classes.country car_country
    from cars
    join results res on res.car = cars.name
    join classes on cars.class = classes.class
    group by cars.name, cars.class, classes.country
    having avg(res.position) > 3.0
)
select
    cd.car_name,
    cd.car_class,
    cd.average_position,
    cd.car_country,
    cld.total_races,
    cld.car_count low_position_count
from car_data cd
join class_data cld on cd.car_class = cld.car_class
order by low_position_count desc;