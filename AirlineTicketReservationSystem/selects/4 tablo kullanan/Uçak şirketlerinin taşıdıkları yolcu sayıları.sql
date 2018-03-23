select c.Company, count(distinct d.Customer_phone)
from leg_instance a, airplane b, airplane_type c, seat_reservation d
where a.Flight_number=d.Flight_number and a.Airplane_id=b.Airplane_id and b.Airplane_type=c.Airplane_type_name
group by c.Company