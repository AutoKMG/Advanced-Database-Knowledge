--- who is the oldest mechanic

select *
from CARMECHANIC.m_mechanic
where birth_date = (select min(birth_date) from CARMECHANIC.m_mechanic);


select *
from carmechanic.m_mehcanic
order by birth_date asc nulls last
fetch first row with ties;

-------------
-- which red car has the highest first buying price?

select *
from carmechanic.m_car
where color ='red' and first_buying_price = (select max(first_buying_price) from carmechanic.m_car where color = 'red');


select *
from carmechanic.m_car
where color='red'
order by first_buying_price desc nulls last
fetch first row with ties;


select color, count(*)
from carmechanic.m_car
group by color
having count(*) = (select max(count(*)) from carmechanic.m_car group by color);


not working
select ow.name, ow.id, count(*)
from carmechanic.m_owner ow left join carmechanic.m_car_owner caow
on ow.id = caow.owner_id
group by car_id;


select ow.name,ow.id, count(car_id) nu
from carmechanic.m_owner ow left outer join
carmechanic.m_car_owner co
on ow.id = co.owner_id
group by ow.name,ow.id
order by nu desc 
fetch first rows with ties;


select ow.name,ow.id, count(car_id) nu
from carmechanic.m_owner ow left outer join
carmechanic.m_car_owner co
on ow.id = co.owner_id
group by ow.name,ow.id
having count(car_id) = (select max(count(car_id)) from carmechanic.m_owner ow left outer join carmechanic.m_car owner co on ow.id = co.owner_id group by ow.name, ow.id);*/


select car.id, car.license_plate, count(rep.repair_start) rs
from carmechanic.m_car car left outer join carmechanic.m_repair rep 
on car.id = rep.car_id
group by car.id, car.license_plate
order by rs asc
fetch first rows with ties;


-- who is the last owner of each car?


select *
from carmechanic.m_car_owner
where (car_id,buying_date) in (
select car_id, max(buying_date)
from carmechanic.m_car_owner
group by car_id);


---------------- in which workshop (name) was each car (license plate) repaired last time?

select *
from carmechanic.m_workshop work left outer join carmechanic.m_repair rep
on work.id = rep.workshop_id
join carmechanic.m_car car on rep.car_id = car.id
having work.id in (select *
                    from carmechanic.m_workshop work left outer join carmechanic.m_repair rep
                    on work.id = rep.workshop_id
                    join carmechanic.m_car car on rep.car_id = car.id);*/


select license_plate, w.name wsh_name, repair_start
from carmechanic.m_car ca left outer join carmechanic.m_repair re
on ca.id = re.car_id left outer join carmechanic.m_workshop w
on re.workshop_id = w.id
where (car_id, repair_start) in (select car_id, max(repair_start)
                                    from carmechanic.m_repair
                                    group by car_id)
or car_id is null



-- copy the car table, put the pk fir the table;
-- create a table which name is insurance 
-- id pk;
-- type varchar2(30)
-- when date not null;
-- car_id reference to car table
-- amount number (ft) >3000,
-- car_owner name
-- unique: car_owner_name,, car_id

create table m_car as select * from carmechanic.m_car;
alter table m_car add constraint mc_pk primary key (id);
create table m_insurance
(id number(5),
type varchar2(30),
ins_date date not null,
car_id number(5),
amount number(8,2),
car_owner_name varchar2(30),
constraint mi_pk primary key (id),
constraint mi_fk foreign key (car_id) references m_car(id),
constraint mi_ck check (amount>3000),
constraint mi_uq unique (car_id,car_owner_name)
);