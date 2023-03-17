sqoop import --connect jdbc:mysql://<database host>/etl_data --table atm_data --columns 
"year,month,day,weekday,hour,atm_status,atm_id,atm_manufacturer,atm_location,atm_streetn
ame,atm_street_number,atm_zipcode,atm_lat,atm_lon,currency,card_type,service,message_co
de,message_text,weather_lat,weather_lon,weather_city_id,weather_city_name,temp,pressure,h
umidity,wind_speed,wind_deg,rain_3h,clouds_all,weather_id,weather_main,weather_descriptio
n" --username admin --target-dir /user/root/atm_dataset -m 1 -P