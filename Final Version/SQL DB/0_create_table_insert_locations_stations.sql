CREATE TABLE locations (
town_name VARCHAR(20) PRIMARY KEY,
station_id VARCHAR(4),
FOREIGN KEY (station_id) REFERENCES station(station_id)
);

CREATE TABLE air_temp (
airtemp_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
station_id VARCHAR(4),
temperature DECIMAL(3,1),
airtemp_date TIMESTAMP,
FOREIGN KEY (station_id) REFERENCES station(station_id)
);

CREATE TABLE resale_flat_txn (
resale_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
resale_date DATE,
town_name VARCHAR(20),
flat_type VARCHAR(20),
block_no VARCHAR(5),
street_name VARCHAR(30),
storey_range VARCHAR(10),
floor_area_sqm FLOAT,
flat_model VARCHAR(30),
lease_commence_year INTEGER,
remaining_lease	VARCHAR(20),
resale_price FLOAT,
FOREIGN KEY (town_name) REFERENCES locations(town_name));

CREATE TABLE station (
station_id VARCHAR(4) PRIMARY KEY,
station_name VARCHAR(30),
latitude DECIMAL,
longitude DECIMAL);

CREATE TABLE humidity (
humidity_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
station_id VARCHAR(4),
humidity_date TIMESTAMP,
humidity_readings DECIMAL(3,1),
FOREIGN KEY (station_id) REFERENCES station(station_id)
);


INSERT INTO locations VALUES ('ANG MO KIO', 'S109');
INSERT INTO locations VALUES ('BEDOK', 'S107');
INSERT INTO locations VALUES ('BISHAN', 'S109');
INSERT INTO locations VALUES ('BUKIT BATOK', 'S121');
INSERT INTO locations VALUES ('BUKIT MERAH', 'S60');
INSERT INTO locations VALUES ('BUKIT PANJANG', 'S121');
INSERT INTO locations VALUES ('BUKIT TIMAH', 'S111');
INSERT INTO locations VALUES ('CENTRAL AREA', 'S108');
INSERT INTO locations VALUES ('CHOA CHU KANG', 'S121');
INSERT INTO locations VALUES ('CLEMENTI', 'S50');
INSERT INTO locations VALUES ('GEYLANG', 'S43');
INSERT INTO locations VALUES ('HOUGANG', 'S43');
INSERT INTO locations VALUES ('JURONG EAST', 'S117');
INSERT INTO locations VALUES ('JURONG WEST', 'S44');
INSERT INTO locations VALUES ('KALLANG/WHAMPOA', 'S108');
INSERT INTO locations VALUES ('MARINE PARADE', 'S108');
INSERT INTO locations VALUES ('PASIR RIS', 'S24');
INSERT INTO locations VALUES ('PUNGGOL', 'S43');
INSERT INTO locations VALUES ('QUEENSTOWN', 'S116');
INSERT INTO locations VALUES ('SEMBAWANG', 'S104');
INSERT INTO locations VALUES ('SENGKANG', 'S43');
INSERT INTO locations VALUES ('SERANGOON', 'S43');
INSERT INTO locations VALUES ('TAMPINES', 'S24');
INSERT INTO locations VALUES ('TOA PAYOH', 'S43');
INSERT INTO locations VALUES ('WOODLANDS', 'S104');
INSERT INTO locations VALUES ('YISHUN', 'S104');

INSERT INTO Station VALUES ('S109','Ang Mo Kio Avenue 5',1.3764,103.8492);
INSERT INTO Station VALUES ('S117','Banyan Road',1.256,103.679);
INSERT INTO Station VALUES ('S50','Clementi Road',1.3337,103.7768);
INSERT INTO Station VALUES ('S107','East Coast Parkway',1.3135,103.9625);
INSERT INTO Station VALUES ('S43','Kim Chuan Road',1.3399,103.8878);
INSERT INTO Station VALUES ('S108','Marina Gardens Drive',1.2799,103.8703);
INSERT INTO Station VALUES ('S44','Nanyang Avenue',1.34583,103.68166);
INSERT INTO Station VALUES ('S121','Old Choa Chu Kang Road',1.37288,103.72244);
INSERT INTO Station VALUES ('S111','Scotts Road',1.31055,103.8365);
INSERT INTO Station VALUES ('S60','Sentosa',1.25,103.8279);
INSERT INTO Station VALUES ('S24','Upper Changi Road North',1.3678,103.9826);
INSERT INTO Station VALUES ('S116','West Coast Highway',1.281,103.754);
INSERT INTO Station VALUES ('S104','Woodlands Avenue 9',1.44387,103.78538);
INSERT INTO Station VALUES ('S102','Semakau Landfill',1.20525,103.77117);
INSERT INTO Station VALUES ('S115','Tuas South Avenue 3',1.29377,103.68166);
INSERT INTO Station VALUES ('S106','Pulau Ubin',1.412382,103.958509);
