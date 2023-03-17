-- Top 10 ATMs where most transactions are in the 'inactive' state

select dim.atm_id,dim.atm_number,count(dim.atm_id) as count 
from atm.fact_atm_tran fact left join atm.dim_atm dim 
on fact.atm_id=dim.atm_id 
where fact.atm_status='Inactive' 
group by dim.atm_id,dim.atm_number 
order by count desc 
limit 10;

-- Number of ATM failures corresponding to the different weather conditions recorded at the time of the transactions

select weather_main,weather_description,count(atm_status) as failure_count 
from atm.fact_atm_tran 
where atm_status ='Inactive' 
group by weather_main,weather_description 
order by failure_count desc; 

-- Top 10 ATMs with the most number of transactions throughout the year

select dim.atm_number,count(fact.atm_id) as count 
from atm.fact_atm_tran as fact left join atm.dim_atm as dim 
on fact.atm_id=dim.atm_id 
group by dim.atm_number 
order by count desc 
limit 10;

-- Number of overall ATM transactions going inactive per month for each month

select dim.month,count(fact.atm_status) as Inactive_count 
from atm.fact_atm_tran as fact left join atm.dim_date as dim 
on fact.date_id=dim.date_id 
where fact.atm_status='Active' and fact.message_code<>'0000' 
group by dim.month 
order by Inactive_count desc;

-- Top 10 ATMs with the highest total withdrawn amount throughout the year

select dim.atm_number,sum(fact.transaction_amount) as amount_withdrawn 
from atm.fact_atm_tran fact left join atm.dim_atm dim 
on fact.atm_id=dim.atm_id 
where fact.atm_status='Active' and fact.service='Withdrawal' 
group by fact.atm_id 
order by amount_withdrawn desc 
limit 10;

-- Number of failed ATM transactions across various card types

select dim.card_type,count(fact.message_code) as failure_count 
from atm.fact_atm_tran fact left join atm.dim_card_type dim 
on fact.card_type_id=dim.card_type_id 
where fact.message_code<>'0000' and fact.atm_status='Active' 
group by dim.card_type 
order by failure_count desc;

-- Number of transactions happening on an ATM on weekdays and on weekends throughout the year. Order this by the ATM_number, ATM_manufacturer, location, weekend_flag and then total_transaction_count

select dim_atm.atm_number,dim_atm.atm_manufacturer,dim_loc.location, 
 case dim_date.weekday 
 when 'Saturday' then True 
 when 'Sunday' then True 
 else False 
 end as weekend_flag, 
 count(fact.tran_id) as total_transaction_count 
from atm.fact_atm_tran fact 
left join atm.dim_atm dim_atm 
on fact.atm_id=dim_atm.atm_id 
left join atm.dim_loc dim_loc 
on fact.weather_loc_id=dim_loc.location_id 
left join atm.dim_date dim_date 
on fact.date_id=dim_date.date_id 
where fact.atm_status='Active' 
group by dim_atm.atm_number,dim_atm.atm_manufacturer,dim_loc.location,weekend_flag 
order by 
dim_atm.atm_number,dim_atm.atm_manufacturer,dim_loc.location,weekend_flag,total_transact
ion_count;

-- Most active day in each ATMs from location "Vejgaard"

select dim_atm.atm_number,dim_date.weekday as most_active_day 
from atm.fact_atm_tran fact 
left join atm.dim_atm dim_atm 
on fact.atm_id=dim_atm.atm_id 
left join atm.dim_loc dim_loc 
on fact.weather_loc_id=dim_loc.location_id 
left join atm.dim_date dim_date 
on fact.date_id=dim_date.date_id 
where fact.atm_status='Active' and dim_loc.location='Vejgaard' 
group by dim_atm.atm_number,dim_date.weekday 
order by count(fact.tran_id) desc;
