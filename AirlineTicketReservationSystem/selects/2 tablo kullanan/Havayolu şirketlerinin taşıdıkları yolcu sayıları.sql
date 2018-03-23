select a.Airline, count(distinct b.Customer_phone)
from flight a, seat_reservation b
where a.Flight_number=b.Flight_number
group by a.Airline