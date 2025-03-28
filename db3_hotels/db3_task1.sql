-- Задача 1
select
    c.name customer_name,
    email customer_email,
    phone customer_phone,
    count(b.id_booking) bookin_count,
    string_agg(distinct h.name, ',' order by h.name) hotels,
    round(avg(date(b.check_out_date) - date(b.check_in_date)), 4) avg_duration
from customer c
join booking b on b.id_customer = c.id_customer
join room r on b.id_room = r.id_room
join hotel h on r.id_hotel = h.id_hotel
group by c.id_customer
having count(distinct h.id_hotel) > 1 and
       count(b.id_booking) > 2
order by bookin_count desc ;