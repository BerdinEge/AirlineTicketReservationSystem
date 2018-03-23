select a.Flight_number, a.Leg_number, a.Date, a.Departure_airport_code, a.Arrival_airport_code, b.Seat_number, b.Customer_name
from leg_instance a
join seat_reservation b on a.Flight_number=b.Flight_number and a.Leg_number=b.Leg_number and a.Date=b.Date