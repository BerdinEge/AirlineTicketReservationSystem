 select a.Airline, b.Customer_name, b.Date, e.Company, c.Airplane_type
 from  flight a, seat_reservation b, airplane c, leg_instance d, airplane_type e
 where a.Flight_number=b.Flight_number and d.Flight_number=b.Flight_number and d.Airplane_id=c.Airplane_id and c.Airplane_type=e.Airplane_type_name
 group by b.Customer_name