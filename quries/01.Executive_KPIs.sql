/*
=====================================================
project: rapido data analysis
section: executive kpis
objective: high-level business performance overview
=====================================================
*/

-- -----------------------------------------------------
-- 1. total rides_cleaned (demand indicator)
-- -----------------------------------------------------
select 
    count(*) as total_rides
from rides_cleaned;



-- -----------------------------------------------------
-- 2. ride completion rate (operational efficiency)
-- -----------------------------------------------------
select 
    round(sum(
			case 
				when ride_status = 'completed' then 1 else 0 end) * 100.0 / count(*),2
    ) as completion_rate_pct
from rides_cleaned;



-- -----------------------------------------------------
-- 3. cancellation rate (core problem metric)
-- -----------------------------------------------------
select 
    round(sum(
			case 
				when ride_status = 'cancelled' then 1 else 0 end) * 100.0 / count(*),2
    ) as cancellation_rate_pct
from rides_cleaned;



-- -----------------------------------------------------
-- 4. total revenue (from completed rides_cleaned only)
-- -----------------------------------------------------
select 
    round(sum(total_fare), 2) as total_revenue
from rides_cleaned
where ride_status = 'completed';



-- -----------------------------------------------------
-- 5. revenue per completed ride (unit economics)
-- -----------------------------------------------------
select 
    round(
        sum(total_fare) / count(*),2
    ) as revenue_per_ride
from rides_cleaned
where ride_status = 'completed';



-- =====================================================
-- final combined kpi query (dashboard-ready output)
-- =====================================================

select 
    count(*) as total_rides_cleaned,

    round(sum(
			case 
				when ride_status = 'completed' then 1 else 0 end) * 100.0 / count(*),2
    ) as completion_rate_pct,

    round(sum(
			case 
				when ride_status = 'cancelled' then 1 else 0 end) * 100.0 / count(*),2
    ) as cancellation_rate_pct,

    round(sum(
			case 
				when ride_status = 'completed' then total_fare else 0 end),2
    ) as total_revenue,

    round(sum(
			case 
				when ride_status = 'completed' then total_fare else 0 end) /
        nullif(sum(
			case 
				when ride_status = 'completed' then 1 else 0 end), 0),2
    ) as revenue_per_ride

from rides_cleaned;