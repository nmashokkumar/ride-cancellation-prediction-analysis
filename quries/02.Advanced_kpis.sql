-- =====================================================
-- project: rapido data analysis
-- section: advanced kpis
-- objective: identify key drivers of ride cancellations
-- =====================================================


-- =====================================================
-- kpi 1: peak hour cancellation ranking
-- business question:
-- which hours have the highest cancellation risk?
-- =====================================================

with hourly_stats as (
    select 
        ride_hour,
        count(*) as total_rides,
        sum(case when ride_status = 'cancelled' then 1 else 0 end) as cancelled_rides
    from rides_cleaned
    group by ride_hour
)

select 
    ride_hour,
    total_rides,
    cancelled_rides,
    round(cancelled_rides * 100.0 / total_rides, 2) as cancellation_rate_pct,
    rank() over (order by cancelled_rides * 1.0 / total_rides desc) as risk_rank
from hourly_stats;

-- =====================================================
-- kpi 2: surge impact on cancellations
-- business question:
-- does surge pricing increase cancellation probability?
-- =====================================================

select 
    case 
        when surge_multiplier = 1 then 'no_surge'
        when surge_multiplier <= 1.5 then 'low_surge'
        else 'high_surge'
    end as surge_bucket,

    count(*) as total_rides,

    round(
        sum(case when ride_status = 'cancelled' then 1 else 0 end) * 100.0 / count(*),
        2
    ) as cancellation_rate_pct

from rides_cleaned
group by surge_bucket
order by cancellation_rate_pct desc;



-- =====================================================
-- kpi 3: driver rating vs cancellation behavior
-- business question:
-- do low-rated drivers contribute to higher cancellations?
-- =====================================================

select 
    case 
        when d.avg_rating < 3.5 then 'low_rating'
        when d.avg_rating < 4.5 then 'medium_rating'
        else 'high_rating'
    end as driver_segment,

    count(*) as total_rides,

    round(
        sum(case when r.ride_status = 'cancelled' then 1 else 0 end) * 100.0 / count(*),
        2
    ) as cancellation_rate_pct

from rides_cleaned r

left join drivers d
    on r.driver_id = d.driver_id

group by driver_segment
order by cancellation_rate_pct desc;



-- =====================================================
-- kpi 4: distance vs cancellation behavior
-- business question:
-- are shorter rides more likely to be cancelled?
-- =====================================================

select 
    case 
        when distance_km < 5 then 'short_distance'
        when distance_km < 15 then 'medium_distance'
        else 'long_distance'
    end as distance_bucket,

    count(*) as total_rides,

    round(
        sum(case when ride_status = 'cancelled' then 1 else 0 end) * 100.0 / count(*),
        2
    ) as cancellation_rate_pct

from rides_cleaned
group by distance_bucket
order by cancellation_rate_pct desc;



-- =====================================================
-- kpi 5: revenue loss due to cancellations
-- business question:
-- how much potential revenue is lost due to cancellations?
-- =====================================================

select 
    round(sum(total_fare), 2) as potential_revenue,

    round(
        sum(case when ride_status = 'cancelled' then total_fare else 0 end),
        2
    ) as lost_revenue,

    round(
        sum(case when ride_status = 'cancelled' then total_fare else 0 end) * 100.0
        / nullif(sum(total_fare), 0),
        2
    ) as revenue_loss_pct

from rides_cleaned;