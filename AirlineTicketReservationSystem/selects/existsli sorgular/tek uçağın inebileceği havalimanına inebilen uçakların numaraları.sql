select b.Airplane_id, b.Total_number_of_seats, c.Company, b.Airplane_type
from airplane b, airplane_type c
where b.Airplane_type=c.Airplane_type_name and exists
(select a.Airport_code, a.Airplane_type_name
from  can_land a
group by a.Airport_code
having count(a.Airplane_type_name)<2 and a.Airplane_type_name=b.Airplane_type
)