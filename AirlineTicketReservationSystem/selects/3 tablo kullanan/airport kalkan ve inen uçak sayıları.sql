select a.Airport_code, count(b.Flight_number)
from airport a, flight_leg b, flight c
where (a.Airport_code=b.Departure_airport_code or a.Airport_code=b.Arrival_airport_code) and b.Flight_number=c.Flight_number
group by a.Airport_code