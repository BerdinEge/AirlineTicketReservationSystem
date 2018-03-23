select b.Airline, b.Flight_number, c.Leg_number
from flight b, flight_leg c
where b.Flight_number=c.Flight_number and (c.Flight_number, c.Leg_number ) in (
	select a.Flight_number, a.Leg_number
	from flight_leg a
	where  (a.Scheduled_departure_time>'19:00:00' and a.Scheduled_arrival_time<'23:59:59') or (a.Scheduled_departure_time>'19:00:00' and a.Scheduled_arrival_time<'06:30:00') or (a.Scheduled_departure_time<'06:30:00' and a.Scheduled_arrival_time<'06:30:00')
)