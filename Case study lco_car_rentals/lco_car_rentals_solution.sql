show databases;
use lco_car_rentals;
show tables;

select * from equipment;

/* 
Q1) Insert the details of new customer:-
First name : Nancy
Last Name: Perry
Dob : 1988-05-16
License Number: K59042656E
Email : nancy@gmail.com
*/
insert into customer (First_name,Last_name,dob,driver_license_number,email)
values
("Nancy","Perry",19980516,"K59042656E","nancy@gmail.com");
select * from customer;


/*
Q2) The new customer (inserted above) wants to rent a car from 2020-08-25 to 2020-08-30. More details are as follows:
Vehicle Type : Economy SUV
Fuel Option : Market
Pick Up location: 5150 W 55th St , Chicago, IL, zip- 60638
Drop Location: 9217 Airport Blvd, Los Angeles, CA, zip - 90045
*/
select * from rental;
insert into rental(start_date,end_date,customer_id,vehicle_type_id,fuel_option_id,pickup_location_id,drop_off_location_id)
values (
20200825,
20200830,
(select id from customer where driver_license_number='K59042656E'),
(select id from vehicle_type where name='Economy SUV' ),
(select id from fuel_option where name='Market'),
(select id from location where concat(street_address,city,state,zipcode)="5150 W 55th StChicagoIL60638"),
( select id from location where concat(street_address,city,state,zipcode)="9217 Airport BlvdLos AngelesCA90045")
)
;
select * from vehicle_type;
select * from location;

-- Q3) The customer with the driving license W045654959 changed his/her drop off location to 1001 Henderson St,  Fort Worth, TX, zip - 76102  and wants to extend the rental upto 4 more days. Update the record.
update rental
set 
drop_off_location_id=(select id from location where street_address='1001 Henderson St'),
end_date=(select date_add(end_date, interval 10 day))
where customer_id=(select id from customer where driver_license_number='W045654959');

-- Q4) Fetch all rental details with their equipment type.
select * from rental;
select * from equipment;
select * from rental r
join
(select vehicle_type_id,name from equipment e
join (
select * from vehicle v
join vehicle_has_equiment ve
where v.id=ve.vehicle_id) s
where s.equipment_id=e.equipment_type_id) s
where s.vehicle_type_id=r.vehicle_type_id;
;
select * from vehicle_has_equiment;

-- Q5) Fetch all details of vehicles.
select id,street_address,city,state,zipcode,brand,model,model_year,mileage,color,name,rental_value from location l
join
(select brand,model,model_year,mileage,color,current_location_id,name,rental_value from vehicle v
join vehicle_type vt
where v.vehicle_type_id=vt.id) s
where l.id=s.current_location_id;

-- Q6) Get driving license of the customer with most rental insurances.
select driver_license_number from customer where id in (
select customer_id from rental r
join(
select rental_id from rental_has_insurance where insurance_id=(
select id from insurance where cost =(select max(cost) from insurance)
)) s
where s.rental_id=r.id)
;

/*
Q7) Insert a new equipment type with following details.
Name : Mini TV
Rental Value : 8.99
*/
select * from equipment_type;
insert into equipment_type(name,rental_value)
values
('Mini TV',8.99);

/* Q8) Insert a new equipment with following details:
Name : Garmin Mini TV
Equipment type : Mini TV
Current Location zip code : 60638
*/
insert into equipment(name,equipment_type_id,current_location_id)
values(
"Garmin Mini TV",
(select id from equipment_type where name='Mini TV'),
(select id from location where zipcode=60638)
);
select * from equipment;

