-- =====================================================
-- section: data cleaning
-- objective: validate and fix data quality issues
-- =====================================================
use rapido_analytics;

select * from rides;

-- 1.Distance check 
select 
	min(distance_km),
    max(distance_km)
from 
	rides;
    
select 
    count(*) as invalid_distance_rows
from rides
where distance_km <= 0 
   or distance_km > 50;
   
-- 2.0Fare check 
select 
    min(total_fare) as min_fare,
    max(total_fare) as max_fare
from rides;

select 
    count(*) as suspicious_fare_rows
from rides
where total_fare < 10 
   or total_fare > 3000;
   
   
-- 3. fare consistency check

select 
    count(*) as fare_less_than_base
from rides
where total_fare < base_fare;

-- 4. surge_multiplier check
select 
    min(surge_multiplier) as min_surge,
    max(surge_multiplier) as max_surge
from rides;


select 
    count(*) as invalid_surge_rows
from rides
where surge_multiplier < 1 
   or surge_multiplier > 5;
   
   
-- 5. null checks

select 
    count(*) as null_driver
from rides
where driver_id is null;

select 
    count(*) as null_distance
from rides
where distance_km is null;

select 
    count(*) as null_fare
from rides
where total_fare is null;


-- cleanded View

create view rides_cleaned as
select 
    ride_id,
    user_id,
    driver_id,
    pickup_location_id,
    drop_location_id,
    ride_timestamp,
    ride_date,
    ride_hour,

    -- clean distance
    case 
        when distance_km <= 0 or distance_km > 50 then null
        else distance_km
    end as distance_km,

    estimated_duration_min,
    actual_duration_min,

    base_fare,

    -- clean fare
    case 
        when total_fare < 10 or total_fare > 3000 then null
        when total_fare < base_fare then base_fare
        else total_fare
    end as total_fare,

    -- clean surge
    case 
        when surge_multiplier < 1 then 1
        when surge_multiplier > 5 then null
        else surge_multiplier
    end as surge_multiplier,

    ride_status,
    cancellation_reason,
    event_type

from rides;

