CREATE TABLE locations (
town_id INTEGER PRIMARY KEY,
town_name VARCHAR(20) UNIQUE,
region VARCHAR(10),
station_id VARCHAR(4),
FOREIGN KEY (station_id) REFERENCES station(station_id)
);

CREATE TABLE air_temp (
airtemp_id SERIAL PRIMARY KEY,
station_id VARCHAR(4),
temperature DECIMAL(3,1),
airtemp_date TIMESTAMP,
FOREIGN KEY (station_id) REFERENCES station(station_id)
);

CREATE TABLE resale_flat_txn (
resale_id INTEGER PRIMARY KEY,
resale_date DATE,
town_name VARCHAR(20),
flat_type VARCHAR(20),
block_no VARCHAR(5),
street_name VARCHAR(30),
storey_range VARCHAR(10),
floor_area_sqm INTEGER,
flat_model VARCHAR(30),
lease_commence_year INTEGER,
remaining_lease	VARCHAR(20),
resale_price INTEGER,
FOREIGN KEY (town_name) REFERENCES locations(town_name));

CREATE TABLE station (
station_id VARCHAR(4) PRIMARY KEY,
station_name VARCHAR(30),
device_id VARCHAR(4),
latitude DECIMAL,
longitude DECIMAL);

CREATE TABLE humidity (
humidity_id SERIAL PRIMARY KEY,
station_id VARCHAR(4),
humidity_date TIMESTAMP,
humidity_readings DECIMAL(3,1),
FOREIGN KEY (station_id) REFERENCES station(station_id)
);


INSERT INTO locations VALUES (1, 'ANG MO KIO', 'North', 'S109');
INSERT INTO locations VALUES (2, 'BEDOK', 'East', 'S107');
INSERT INTO locations VALUES (3, 'BISHAN', 'Central', 'S43');
INSERT INTO locations VALUES (4, 'BUKIT BATOK', 'West', 'S121');
INSERT INTO locations VALUES (5, 'BUKIT MERAH', 'Central', 'S60');
INSERT INTO locations VALUES (6, 'BUKIT PANJANG', 'West', 'S121');
INSERT INTO locations VALUES (7, 'BUKIT TIMAH', 'Central', 'S111');
INSERT INTO locations VALUES (8, 'CENTRAL AREA', 'Central', 'S108');
INSERT INTO locations VALUES (9, 'CHOA CHU KANG', 'West', 'S121');
INSERT INTO locations VALUES (10, 'CLEMENTI', 'West', 'S50');
INSERT INTO locations VALUES (11, 'GEYLANG', 'Central', 'S43');
INSERT INTO locations VALUES (12, 'HOUGANG', 'North', 'S43');
INSERT INTO locations VALUES (13, 'JURONG EAST', 'West', 'S117');
INSERT INTO locations VALUES (14, 'JURONG WEST', 'West', 'S44');
INSERT INTO locations VALUES (15, 'KALLANG/WHAMPOA', 'Central', 'S108');
INSERT INTO locations VALUES (16, 'MARINE PARADE', 'Central', 'S108');
INSERT INTO locations VALUES (17, 'PASIR RIS', 'East', 'S24');
INSERT INTO locations VALUES (18, 'PUNGGOL', 'North', 'S24');
INSERT INTO locations VALUES (19, 'QUEENSTOWN', 'Central', 'S116');
INSERT INTO locations VALUES (20, 'SEMBAWANG', 'North', 'S104');
INSERT INTO locations VALUES (21, 'SENGKANG', 'North', 'S109');
INSERT INTO locations VALUES (22, 'SERANGOON', 'North', 'S43');
INSERT INTO locations VALUES (23, 'TAMPINES', 'East', 'S24');
INSERT INTO locations VALUES (24, 'TOA PAYOH', 'Central', 'S43');
INSERT INTO locations VALUES (25, 'WOODLANDS', 'North', 'S104');
INSERT INTO locations VALUES (26, 'YISHUN', 'North', 'S104');

INSERT INTO Station VALUES ('S109','Ang Mo Kio Avenue 5','S109',1.3764,103.8492);
INSERT INTO Station VALUES ('S117','Banyan Road','S117',1.256,103.679);
INSERT INTO Station VALUES ('S50','Clementi Road','S50',1.3337,103.7768);
INSERT INTO Station VALUES ('S107','East Coast Parkway','S107',1.3135,103.9625);
INSERT INTO Station VALUES ('S43','Kim Chuan Road','S43',1.3399,103.8878);
INSERT INTO Station VALUES ('S108','Marina Gardens Drive','S108',1.2799,103.8703);
INSERT INTO Station VALUES ('S44','Nanyang Avenue','S44',1.34583,103.68166);
INSERT INTO Station VALUES ('S121','Old Choa Chu Kang Road','S121',1.37288,103.72244);
INSERT INTO Station VALUES ('S111','Scotts Road','S111',1.31055,103.8365);
INSERT INTO Station VALUES ('S60','Sentosa','S60',1.25,103.8279);
INSERT INTO Station VALUES ('S24','Upper Changi Road North','S24',1.3678,103.9826);
INSERT INTO Station VALUES ('S116','West Coast Highway','S116',1.281,103.754);
INSERT INTO Station VALUES ('S104','Woodlands Avenue 9','S104',1.44387,103.78538);
INSERT INTO Station VALUES ('S102','Semakau Landfill','S102',1.20525,103.77117);
INSERT INTO Station VALUES ('S115','Tuas South Avenue 3','S115',1.29377,103.68166);
