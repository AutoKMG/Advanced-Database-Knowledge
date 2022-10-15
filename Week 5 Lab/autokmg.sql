select *
from CARMECHANIC.m_car c, CARMECHANIC.m_car_type t
where c.type_id = t.id and t.brand = 'Opel';



select cr.*

from carmechanic.m_car c, CARMECHANIC.m_car_revaluation cr

where c.id  = cr.car_id and c.license_plate = 'PAP270'; 


select ow.id, ow.name
from carmechanic.m_car ca inner join
carmechanic.m_car_owner co
on ca.id = co.car_id
inner join carmechanic.m_owner ow
on ow.id = co.owner_id
where ca.license_plate = 'PAP270';


select ws.name, m.name
from carmechanic.m_workshop ws inner join
carmechanic.m_works w
on w.workshop_id = ws.id
inner join carmechanic.m_mechanic m
on w.mechanic_id = m.id 
where ws.name  = 'Brake Pedal CIC';

-- List all the cars and their types

select c.id, c.license_plate, ct.brand
from carmechanic.m_car c left outer join carmechanic.m_car_type ct
on c.type_id = ct.id


select c.color, count(*)
from carmechanic.m_car c
group by c.color;


select c.id, count(*)
from carmechanic.m_car c left outer join CARMECHANIC.m_repair cr
on c.id = cr.car_id
group by cr.car_id 


select ca.id, ca.license_plate,count(r.car_id)
from carmechanic.m_car ca left outer join
carmechanic.m_repair r
on ca.id = r.car_id
group by ca.id,ca.license_plate

select c.color, count(*)
from carmechanic.m_car c
group by c.color
having count(*) < 5;
