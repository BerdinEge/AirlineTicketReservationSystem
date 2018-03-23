select b.City, a.Flight_number, a.Leg_number, c.City
from airlinesystem.flight_leg a, airlinesystem.airport b, airlinesystem.airport c
where a.Departure_airport_code=b.Airport_code and a.Arrival_airport_code=c.Airport_code