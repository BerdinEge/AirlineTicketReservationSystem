select a.Flight_number, a.Leg_number, b.Customer_name, c.City, d.City
from airlinesystem.leg_instance a, airlinesystem.seat_reservation b, airlinesystem.airport c, airlinesystem.airport d
where b.Flight_number=a.Flight_number and a.Departure_airport_code=c.Airport_code and a.Arrival_airport_code=d.Airport_code
group by Customer_name, Leg_number