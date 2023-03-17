# ETL_Project
- In this project I have used the following AWS services
	- EMR
	- RDS
	- Redshift
	- S3
- You can find the dataset at [Kaggle ATM dataset](https://www.kaggle.com/datasets/sparnord/danish-atm-transactions).

## Extraction
### 1. Sqoop Ingestion
- The data in the RDS database is fetched using the SqoopDataIngestion.sh command.
- The data is stored in HDFS

## Transformation
### 2. Pyspark Data transformation
- The data in extracted and trasformed into 5 tables as follows:
	- fact_atm_tran
	- dim_loc
	- dim_atm
	- dim_date
	- dim_card_type
- The above tables are saved in S3 bucket in CSV format.

## Loading data for analysis
### 3. Creating schema and tables in the Redshift database
- RedshiftSetup.sql has the code to create the schema and table in the Redshif database.
- The table structure is as follows:
#### fact_atm_tran
|Columns|Data Type|Constriant|
|:-|:-|:-|
|tran_id|bigint|**Primary**|
|atm_id|int|**Foreign(dim_atm.atm_id)**|
|weather_loc_id|int|**Foreign(dim_location.location_id)**|
|date_id|int|**Foreign(dim_date.date_id)**|
|card_type_id|int|**Foreign(dim_card_type.card_type_id)**|
|atm_status|string|
|curency|string|
|service|string|
|transaction_amount|int|
|message_code|string|
|message_text|string|
|rain_3h|float|
|cloud_all|int|
|weather_id|int|
|weather_main|string|
|weather_description|string|
#### dim_loc
|Columns|Data Type|Constriant|
| :- | :- |:-|
|location_id|int|**Primary**|
|location|string|
|street_name|string|
|street_number|int|
|zipcode|int|
|lat|double|
|lon|double|
#### dim_atm
|Columns|Data Type|Constriant|
|:-|:-|:-|
|atm_id|int|**Primary**|
|atm_number|string|
|atm_manufacturer|string|
|atm_location_id|int|**Foreign(dim_loc.location_id)**|
#### dim_date
|Columns|Data Type|Constriant|
| :- | :- |:-|
|date_id|int|**Primary**|
|full_date_time|string||
|year|int||
|month|string||
|day|int||
|hour|int||
|weekday|string||
#### dim_card_type
|Columns|Data Type|Constriant|
|:-|:-|:-|
|card_type_id|int|**Primary**|
|card_type|string|
### 4. Data Analysis in Redshift
- RedshiftQueries.sql contain the problem statement and the code for analysis.