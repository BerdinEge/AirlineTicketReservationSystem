select distinct a.Company, a.Airplane_type_name, b.City
from airplane_type a, airport b
where a.Max_seats<b.Capacity