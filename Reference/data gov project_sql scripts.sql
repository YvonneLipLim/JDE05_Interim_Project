-- Issue: 
-- Loading data from resale_flat_transactions into postgreSQL database
-- Solution:
-- Downloading the .csv from data.gov.sg and loading it into the postgreSQL database via SQL script

CREATE TABLE resale_flat_prices (
    month VARCHAR(100),
    hdb_town VARCHAR(100),
    flat_type VARCHAR(100),
    block VARCHAR(100),
    street_name VARCHAR(100),
    storey_range VARCHAR(100),
    floor_area_sqm DECIMAL(10,2),
    flat_model VARCHAR(100),
	lease_commence_date integer,
    remaining_lease VARCHAR(100),
    resale_price DECIMAL(11,2)
);

COPY resale_flat_prices (month, hdb_town, flat_type, block, street_name, storey_range, floor_area_sqm, flat_model, lease_commence_date, remaining_lease, resale_price)
FROM '/Users/shawnwee/teams notes_Generation SCTP JDE 05/Week 5 Interim Project/ResaleflatpricesbasedonregistrationdatefromJan2017onwards.csv'
DELIMITER ','
CSV HEADER;

-- Issue: 
-- Mapping between air_temperature.station_name and resale_flat_prices.hdb_towns
-- Solution:
-- Create a new column in air temperature table that maps each station_name to a column called hdb_town

ALTER TABLE air_temperature ADD COLUMN hdb_town VARCHAR(100);

UPDATE air_temperature
SET hdb_town = CASE
	WHEN name ILIKE '%Ang Mo Kio Avenue 5%' THEN 'ANG MO KIO'
	WHEN name ILIKE '%Banyan Road%' THEN 'JURONG WEST'
	WHEN name ILIKE '%Clementi Road%' THEN 'CLEMENTI'
	WHEN name ILIKE '%East Coast Parkway%' THEN 'BEDOK'
	WHEN name ILIKE '%Kim Chuan Road%' THEN 'HOUGANG'
	WHEN name ILIKE '%Nanyang Avenue%' THEN 'JURONG WEST'
	WHEN name ILIKE '%Old Choa Chu Kang Road%' THEN 'TENGAH'
	WHEN name ILIKE '%Scotts Road%' THEN 'BUKIT TIMAH'
	WHEN name ILIKE '%Sentosa%' THEN 'BUKIT MERAH'
	WHEN name ILIKE '%Tuas South Avenue 3%' THEN 'JURONG WEST'
	WHEN name ILIKE '%Upper Changi Road North%' THEN 'PASIR RIS'
	WHEN name ILIKE '%West Coast Highway%' THEN 'CLEMENTI'
	WHEN name ILIKE '%Woodlands Avenue 9%' THEN 'WOODLANDS'
	WHEN name ILIKE '%Marina Gardens Drive%' THEN 'CENTRAL AREA'
	WHEN name ILIKE '%Semakau Landfill%' THEN 'NULL'
	ELSE NULL
END; 

-- Issue:
-- How to map multiple hdb_towns to each station_name? 
-- Solution:
-- Create a many-to-many mapping table

CREATE TABLE station_name_to_hdb_town_map ( 
station_name VARCHAR(100), 
hdb_town VARCHAR(100)
);

INSERT INTO station_name_to_hdb_town_map (station_name, hdb_town) 
VALUES 
('Ang Mo Kio Avenue 5', 'ANG MO KIO'),
('Banyan Road', 'JURONG WEST'), 
('Clementi Road', 'CLEMENTI'), 
('East Coast Parkway', 'BEDOK'), 
('Kim Chuan Road', 'HOUGANG'), 
('Nanyang Avenue', 'JURONG WEST'), 
('Old Choa Chu Kang Road', 'TENGAH'), 
('Scotts Road', 'BUKIT MERAH'), 
('Tuas South Avenue 3', 'JURONG WEST'), 
('Upper Changi Road North', 'PASIR RIS'), 
('Upper Changi Road North', 'TAMPINES'), 
('West Coast Highway', 'CLEMENTI'), 
('Woodlands Avenue 9', 'WOODLANDS'), 
('Marina Gardens Drive', 'CENTRAL AREA'), 
('Semakau Landfill', 'NULL')
;