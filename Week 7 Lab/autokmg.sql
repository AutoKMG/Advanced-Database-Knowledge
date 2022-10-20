---- Delete the red cars;
/*
create table c_car as select * from carmechanic.m_car;

delete from c_car
where color = 'red';
rollback;

-- Delete the cars which brand is Opel or Ford and which color is red or blue or grey;

select *
from c_car
where color in ('red','blue','grey')
and type_id in (select id from carmechanic.m_car_type where brand in ('Opel','Ford'));
rollback;
*/
-- Delete the car_owning (car_owner) where the car is opel and the owner city is Debrecen
/*----
create table c_car_owner as select * from carmechanic.m_car_owner;

delete from c_car_owner
where owner_id in (select id from carmechanic.m_owner where city ='Debrecen')
and car_id in (select id from carmechanic.m_car where type_id in (select id from carmechanic.m_car_type where brand = 'Opel'));
rollback;
----- */
--- Delete the repairs in which Opel branded cars was repaired in workshops which city is Debrecen;
/*
create table m_repair as select * from carmechanic.m_repair;

delete
from m_repair 
where workshop_id in (select id from carmechanic.m_workshop where city ='Debrecen')
and car_id in ( select id from carmechanic.m_car where type_id in (select id from carmechanic.m_car_type where brand = 'Opel'));
rollback;
*/

-- Delete the repairs which repair price is more than the 10% of the first_buying_price of the repaired car;
/*
delete
from m_repair re
where repair_price>(select 0.1*first_buying_price from carmechanic.m_car ca where re.car_id = ca.id);
rollback;
*/

-- delete the car revaluations which price is less thean the 10% of the first_buying_price of the car;
/*
create table c_car_rev as select * from carmechanic.m_car_revaluation;

delete
from c_car_rev cr where price < (select 0.1*first_buying_price from carmechanic.m_car ca where cr.car_id = ca.id);
rollback;
*/ 


-- increase the repair prices of the repairs where the workshop city is Debrece.;
/*
update m_repair
set repair_price = repair_price *1.1
where workshop_id in (select id from carmechanic.m_workshop where city ='Debrecen');
rollback;
*/

-- Decrease the repair prices with 10% of the repairs in which Opel branded cars was repaired;
/*
update m_repair 
set repair_price = repair_price*0.9
where car_id in (select id from carmechanic.m_car where type_id in (select id from carmechanic.m_car_type where brand = 'Opel'));
rollback;
*/
/*
-- Increase the repair prices of the repair with 1% of the first_buying_price of the car in which the car color is red or blue or grey;

update m_repair mr
set repair_price = repair_price + 0.01 * ( select first_buying_price from carmechanic.m_car ca where mr.car_id = ca.id)
where car_id in (select id from carmechanic.m_car where color in ('red','blue','grey'));
rollback;
*/

-- Increase the price of the revaluations with 1% of the sum repair price of the car for the cars which has more than 3 owners 

update c_car_rev cr 
set price = price +0.01 * (select nvl(sum(repair_price),0) from carmechanic.m_repair re where cr.car_id = re.car_id)
where car_id in (select car_id from carmechanic.m_car_owner group by car_id having count(*) > 3);
rollback;
