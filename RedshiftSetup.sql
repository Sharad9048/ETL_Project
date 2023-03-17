-- Schema Creation
create schema atm;


-- Tables creation

create table atm.dim_loc 
( 
 location_id int primary key, 
 location varchar(30), 
 streetname varchar(30), 
 street_number int, 
 zipcode int, 
 lat decimal(10,3), 
 lon decimal(10,3) 
);

create table atm.dim_atm 
( 
 atm_id int primary key, 
 atm_number varchar(20), 
 atm_manufacturer varchar(20), 
 atm_location_id int references atm.dim_loc(location_id) 
); 

create table atm.dim_date 
( 
 date_id int primary key, 
 full_date_time timestamp, 
 "year" int, 
 month varchar(20), 
 day int, 
 hour int, 
 weekday varchar(20) 
); 

create table atm.dim_card_type 
( 
 card_type_id int primary key, 
 card_type varchar(30) 
); 

create table atm.fact_atm_tran 
( 
 tran_id bigint primary key, 
 atm_id int references atm.dim_atm(atm_id), 
 weather_loc_id int references atm.dim_loc(location_id), 
 date_id int references atm.dim_date(date_id), 
 card_type_id int references atm.dim_card_type(card_type_id), 
 atm_status varchar(20), 
 currency varchar(10), 
 service varchar(20), 
 transaction_amount int, 
 message_code varchar(255), 
 message_text varchar(255), 
 rain_3h decimal(10,3), 
 clouds_all int, 
 weather_id int, 
 weather_main varchar(50), 
 weather_description varchar(255) 
);