select a.Flight_number, a.Airline, b.Leg_number, b.Date, b.Airplane_id, b.Departure_airport_code, b.Departure_time, b.Arrival_airport_code, b.Arrival_time
from flight a
right join leg_instance b on a.Flight_number=b.Flight_number