select distinct a.*
from can_land a, airplane b, airplane_type c
where b.Airplane_type=c.Airplane_type_name and c.Airplane_type_name=a.Airplane_type_name and c.Max_seats<200 