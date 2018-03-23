select a.Airplane_id, b.Airline
from airlinesystem.airplane a, airlinesystem.flight b, airlinesystem.leg_instance c
where a.Airplane_id=c.Airplane_id and c.Flight_number=b.Flight_number