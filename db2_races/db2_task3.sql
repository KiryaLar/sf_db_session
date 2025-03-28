with avg_pos_car as (
    select
        cars.class car_class,
        avg(res.position) avg_pos,
        count(res.race) race_count_class,
        classes.country car_country
    from cars
    join results res on res.car = cars.name
    join classes on cars.class = classes.class
    group by cars.class, classes.country
),
min_avg_pos as (
    select
        min(avg_pos) as avg_pos
    from avg_pos_car
),
race_count as (
    select car, count(race) race_count
    from results
    group by car
)
select
    cars.name car_name,
    apc.car_class,
    round(apc.avg_pos, 4) average_position,
    race_count.race_count,
    apc.car_country,
    apc.race_count_class total_races
    from cars
join avg_pos_car apc on apc.car_class = cars.class
join results res on res.car = cars.name
join race_count on race_count.car = cars.name
join min_avg_pos on apc.avg_pos = min_avg_pos.avg_pos;