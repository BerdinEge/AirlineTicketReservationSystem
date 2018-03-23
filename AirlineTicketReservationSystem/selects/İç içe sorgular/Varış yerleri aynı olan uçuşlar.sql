select b.Flight_number, b.Leg_number, b.Arrival_airport_code
from flight_leg b
where b.Arrival_airport_code in (

select a.Arrival_airport_code
from flight_leg a
group by a.Arrival_airport_code
having count(a.Arrival_airport_code)>1

)