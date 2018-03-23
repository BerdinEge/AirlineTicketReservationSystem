select distinct a.Airline, d.Company, c.Airplane_type, count(a.Flight_number)
from flight a, leg_instance b, airplane c, airplane_type d
where a.Flight_number=b.Flight_number and b.Airplane_id=c.Airplane_id and c.Airplane_type=d.Airplane_type_name
group by a.Flight_number