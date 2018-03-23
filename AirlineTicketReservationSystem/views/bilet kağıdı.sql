create or replace view Bilet_göster as
select a.Customer_name, a.Customer_phone, a.Date, a.Flight_number, a.Leg_number, a.Seat_number, b.Departure_airport_code, b.Arrival_airport_code
from seat_reservation a
join flight_leg b on a.Flight_number=b.Flight_number and a.Leg_number=b.Leg_number 