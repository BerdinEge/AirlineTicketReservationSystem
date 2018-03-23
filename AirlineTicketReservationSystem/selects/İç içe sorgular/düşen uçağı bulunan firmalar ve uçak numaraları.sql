select *
from flight b
where b.Flight_number in (select a.Flight_number
						  from leg_instance a
						  where a.Arrival_airport_code is null)