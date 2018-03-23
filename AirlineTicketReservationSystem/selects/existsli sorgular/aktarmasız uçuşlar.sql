select b.Flight_number, b.Airline
from flight b
where not exists (
	select a.Flight_number
	from flight_leg a
	group by a.Flight_number
	having count(Leg_number)>1 and b.Flight_number=a.Flight_number
)