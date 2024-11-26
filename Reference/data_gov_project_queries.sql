-- select-alls
SELECT * FROM air_temp;
SELECT * FROM resale_flat_txn;

-- query to find the town_names with the lowest average yearly temperature
SELECT 
air_temp.station_id, ROUND(AVG(temperature), 1) AS avg_annual_temperature,
town_name
FROM air_temp
INNER JOIN locations
ON air_temp.station_id = locations.station_id
WHERE
air_temp.airtemp_date >= '2023-11-01' 
AND air_temp.airtemp_date <= '2024-11-01'
GROUP BY 
air_temp.station_id, town_name
ORDER BY 
avg_annual_temperature ASC
;

-- query to find the avg_resale_price over the past 1 year
-- of a particular town_name and flat_type
SELECT town_name, flat_type, TO_CHAR(ROUND(AVG(resale_price), 2), 'FM$999,999,990.00') AS avg_resale_price 
FROM resale_flat_txn
WHERE 
town_name = 'CHOA CHU KANG' 
AND resale_date >= '2023-11-01' AND resale_date <= '2024-11-01'
GROUP BY town_name, flat_type
ORDER BY AVG(resale_price); 

-- query for how can I now find the flat_type, block_nos and street_name
-- which have the latest 3 month average resale_price
-- which is less than the 1 year AVG(resale_price)?
WITH avg_prices -- Calculate 1-year average resale price for each flat_type and town_name
    AS (
    SELECT 
        town_name, 
        flat_type, 
        ROUND(AVG(resale_price), 2) AS avg_resale_price
    FROM 
        resale_flat_txn
    WHERE 
        town_name = 'CHOA CHU KANG' 
        AND resale_date >= '2023-11-01' 
        AND resale_date <= '2024-11-01'
    GROUP BY 
        town_name, flat_type
),
three_month_avg -- Calculate the 3-month rolling average resale price for each flat_type, block_no, and street_name
    AS (
    SELECT 
        resale_flat_txn.town_name,
        resale_flat_txn.flat_type,
        resale_flat_txn.block_no,
        resale_flat_txn.street_name,
        AVG(resale_flat_txn.resale_price) OVER (
            PARTITION BY resale_flat_txn.flat_type, resale_flat_txn.block_no, resale_flat_txn.street_name
            ORDER BY resale_flat_txn.resale_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_month_avg_resale_price,
        resale_flat_txn.resale_date
    FROM 
        resale_flat_txn
    WHERE 
        resale_flat_txn.town_name = 'CHOA CHU KANG'
        AND resale_flat_txn.resale_date >= '2023-11-01' 
        AND resale_flat_txn.resale_date <= '2024-11-01'
)
SELECT 
    three_month_avg.flat_type,
    three_month_avg.block_no,
    three_month_avg.street_name,
    TO_CHAR(ROUND(three_month_avg.three_month_avg_resale_price, 2), 'FM$999,999,990.00') AS three_month_avg_resale_price,
    TO_CHAR(ROUND(avg_prices.avg_resale_price, 2), 'FM$999,999,990.00') AS avg_resale_price
FROM 
    three_month_avg
JOIN 
    avg_prices
ON 
    three_month_avg.town_name = avg_prices.town_name
    AND three_month_avg.flat_type = avg_prices.flat_type
WHERE 
    three_month_avg.three_month_avg_resale_price < avg_prices.avg_resale_price
    AND three_month_avg.resale_date = (
        SELECT MAX(resale_date)
        FROM resale_flat_txn 
        WHERE resale_flat_txn.flat_type = three_month_avg.flat_type
        AND resale_flat_txn.block_no = three_month_avg.block_no
        AND resale_flat_txn.street_name = three_month_avg.street_name
    )
ORDER BY 
    three_month_avg.flat_type;

-- query for how can I now find the flat_type, block_nos and street_name
-- which have the latest 3 month average resale_price
-- which is less than the 1 year AVG(resale_price)?
-- with additional condition that the flat has to have remaining_lease >= '85 years 00 months'?
WITH avg_prices AS (
    -- Calculate 1-year average resale price for each flat_type and town_name
    SELECT 
        town_name, 
        flat_type, 
        ROUND(AVG(resale_price), 2) AS avg_resale_price
    FROM 
        resale_flat_txn
    WHERE 
        town_name = 'CHOA CHU KANG' 
        AND resale_date >= '2023-11-01' 
        AND resale_date <= '2024-11-01'
        AND remaining_lease >= '85 years 00 months'  -- Add condition for remaining lease
    GROUP BY 
        town_name, flat_type
),
three_month_avg AS (
    -- Calculate the 3-month rolling average resale price for each flat_type, block_no, and street_name
    SELECT 
        resale_flat_txn.town_name,
        resale_flat_txn.flat_type,
        resale_flat_txn.block_no,
        resale_flat_txn.street_name,
		resale_flat_txn.remaining_lease,
        AVG(resale_flat_txn.resale_price) OVER (
            PARTITION BY resale_flat_txn.flat_type, resale_flat_txn.block_no, resale_flat_txn.street_name
            ORDER BY resale_flat_txn.resale_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS three_month_avg_resale_price,
        resale_flat_txn.resale_date
    FROM 
        resale_flat_txn
    WHERE 
        resale_flat_txn.town_name = 'CHOA CHU KANG'
        AND resale_flat_txn.resale_date >= '2023-11-01' 
        AND resale_flat_txn.resale_date <= '2024-11-01'
        AND resale_flat_txn.remaining_lease >= '85 years 00 months'  -- Add condition for remaining lease
)
SELECT 
    three_month_avg.flat_type,
    three_month_avg.block_no,
    three_month_avg.street_name,
	three_month_avg.remaining_lease,
    -- Format the 3-month rolling average resale price in dollars and cents with flush left alignment
    TO_CHAR(ROUND(three_month_avg.three_month_avg_resale_price, 2), 'FM$999,999,990.00') AS three_month_avg_resale_price,
    -- Format the 1-year average resale price in dollars and cents with flush left alignment
    TO_CHAR(ROUND(avg_prices.avg_resale_price, 2), 'FM$999,999,990.00') AS avg_resale_price
FROM 
    three_month_avg
JOIN 
    avg_prices
ON 
    three_month_avg.town_name = avg_prices.town_name
    AND three_month_avg.flat_type = avg_prices.flat_type
WHERE 
    three_month_avg.three_month_avg_resale_price < avg_prices.avg_resale_price
    AND three_month_avg.resale_date = (
        SELECT MAX(resale_date)
        FROM resale_flat_txn 
        WHERE resale_flat_txn.flat_type = three_month_avg.flat_type
        AND resale_flat_txn.block_no = three_month_avg.block_no
        AND resale_flat_txn.street_name = three_month_avg.street_name
    )
ORDER BY 
    three_month_avg.flat_type;  -- Order by flat_type