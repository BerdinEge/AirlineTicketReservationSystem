select b.Flight_number, b.Leg_number, b.Departure_airport_code
from flight_leg b
where b.Departure_airport_code in (
	select a.Departure_airport_code
	from flight_leg a
	group by Departure_airport_code
	having count(a.Departure_airport_code)>1
)