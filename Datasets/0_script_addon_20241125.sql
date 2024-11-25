INSERT INTO Station VALUES ('S102','Semakau Landfill','S102',1.20525,103.77117);
INSERT INTO Station VALUES ('S115','Tuas South Avenue 3','S115',1.29377,103.68166);

ALTER TABLE locations
ADD CONSTRAINT unique_town_name UNIQUE (town_name);
 
ALTER TABLE resale_flat_txn
ADD CONSTRAINT fk_town_name
FOREIGN KEY (town_name)
REFERENCES locations (town_name);

ALTER TABLE air_temp
ADD CONSTRAINT fk_station_id
FOREIGN KEY (station_id)
REFERENCES station (station_id);

ALTER TABLE humidity
ADD CONSTRAINT fk_station_id
FOREIGN KEY (station_id)
REFERENCES station (station_id);

ALTER TABLE locations
ADD CONSTRAINT fk_station_id
FOREIGN KEY (station_id)
REFERENCES station (station_id);