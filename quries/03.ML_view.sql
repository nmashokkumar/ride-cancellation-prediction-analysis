create view ml_features_view as

with user_ride_counts as (
    select 
        user_id,
        count(*) as total_rides
    from rides_cleaned
    group by user_id
),

user_segments as (
    select 
        user_id,
        case 
            when total_rides <= 5 then 'new'
            when total_rides between 6 and 20 then 'regular'
            else 'power'
        end as user_segment
    from user_ride_counts
)

select distinct  -- prevents accidental duplicates
	r.user_id,
    r.ride_date,
    r.ride_hour,

    r.distance_km,
    r.surge_multiplier,

    -- optional but useful
    r.estimated_duration_min,

    coalesce(d.avg_rating, 0) as driver_rating,

    coalesce(l.city, 'unknown') as city,

    coalesce(r.event_type, 'normal') as event_type,

    coalesce(us.user_segment, 'new') as user_segment,

    case 
        when r.ride_status = 'cancelled' then 1 
        else 0 
    end as is_cancelled

from rides_cleaned r

left join drivers d 
    on r.driver_id = d.driver_id

left join locations l 
    on r.pickup_location_id = l.location_id

left join user_segments us
    on r.user_id = us.user_id

where 
    r.distance_km is not null
    and r.surge_multiplier is not null
    and r.ride_date is not null;