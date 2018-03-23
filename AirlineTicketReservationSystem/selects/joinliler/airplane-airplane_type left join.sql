select a.Airplane_id, b.Airplane_type_name, b.Company, b.Max_seats
from airplane a
left join airplane_type b on a.Airplane_type=b.Airplane_type_name