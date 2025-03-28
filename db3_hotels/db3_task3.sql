-- Задача 3
with hotel_categories as (select
    h.id_hotel,
    h.name,
    case
        when avg(r.price) < 175 then 'Дешевый'
        when avg(r.price) between 175 and 300 then 'Средний'
        when avg(r.price) > 300 then 'Дорогой'
    end as hotel_category
from hotel h
join room r on h.id_hotel = r.id_hotel
group by h.id_hotel),
customer_preferencies as(
    select
        c.id_customer,
        c.name,
        count(distinct case when hc.hotel_category = 'Дешевый' then hc.id_hotel end) cheap_count ,
        count(distinct case when hc.hotel_category = 'Средний' then hc.id_hotel end) average_count,
        count(distinct case when hc.hotel_category = 'Дорогой' then hc.id_hotel end) expensive_count,
        string_agg(distinct hc.name, ',' order by hc.name) visited_hotels
    from customer c
    join booking b on c.id_customer = b.id_customer
    join room r on b.id_room = r.id_room
    join hotel_categories hc on hc.id_hotel = r.id_hotel
    group by c.id_customer
)
select
    id_customer,
    name,
    case
        when expensive_count > 0 then 'Дорогой'
        when average_count > 0 then 'Средний'
        when cheap_count > 0 then 'Дешевый'
        end as preferred_hotel_type,
    visited_hotels
from customer_preferencies cp
order by case
    when expensive_count > 0 then 3
    when average_count > 0 then 2
    when cheap_count > 0 then 1
end;