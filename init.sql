CREATE SCHEMA campaigns;
SET search_path TO campaigns;

CREATE TABLE customers (
  id SERIAL NOT NULL PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  currency VARCHAR(3) NOT NULL
);
ALTER SEQUENCE customers_id_seq RESTART WITH 101;
ALTER TABLE customers REPLICA IDENTITY FULL;

INSERT INTO customers
VALUES (default,'Jermaine','Bakes','jbakes0@purevolume.com','USD'),
       (default,'Lewes','Gasker','lgasker1@typepad.com','UYU'),
       (default,'Ashia','Toulch','atoulch2@yellowbook.com','CZK'),
       (default,'Mora','Greguoli','mgreguoli3@ft.com','EUR'),
       (default,'Stan','Tweddle','stweddle4@businessweek.com','MXN');

CREATE TABLE campaigns (
  id SERIAL NOT NULL PRIMARY KEY,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  customer INTEGER NOT NULL,
  budget INTEGER NOT NULL,
  last_change TIMESTAMP NOT NULL,
  FOREIGN KEY (customer) REFERENCES customers(id)
);
ALTER SEQUENCE campaigns_id_seq RESTART WITH 1001;
ALTER TABLE campaigns REPLICA IDENTITY FULL;

INSERT INTO campaigns
VALUES (default, '2021-10-16','2021-10-22', 101, 1000000,'2021-09-22 02:26:20'),
       (default, '2021-09-17','2021-10-01', 102, 200000,'2021-09-01 02:26:20'),
       (default, '2012-09-19','2021-10-29', 102, 2000,'2021-09-24 02:26:20'),
       (default, '2021-09-21','2021-10-01', 104, 1337,'2021-09-01 02:26:20');

CREATE TABLE line_items (
  id SERIAL NOT NULL PRIMARY KEY,
  campaign INTEGER NOT NULL,
  creative_url VARCHAR(255) NOT NULL,
  target_audience_id INTEGER NOT NULL,
  max_bid INTEGER NOT NULL,
  compensation_method VARCHAR(3) NOT NULL,
  last_change TIMESTAMP NOT NULL,
  FOREIGN KEY (campaign) REFERENCES campaigns(id)
);
ALTER SEQUENCE line_items_id_seq RESTART WITH 10001;
ALTER TABLE line_items REPLICA IDENTITY FULL;

INSERT INTO line_items
VALUES (default, 1001,'https://somecdn.io/1001/13549513.png', 9513, 300, 'CPC', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/65132486.png', 2486, 250, 'CPC', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/21021658.png', 1658, 100, 'CPC', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/88421354.png', 1354, 150, 'CPC', '2021-09-24 02:26:00'),
       (default, 1002,'https://somecdn.io/1002/23246871.png', 6871, 3000, 'CPA', '2021-09-24 02:26:00'),
       (default, 1002,'https://somecdn.io/1002/23564892.png', 4892, 3500, 'CPA', '2021-09-24 02:26:00'),
       (default, 1003,'https://somecdn.io/1003/65186515.png', 6515, 5100, 'CPA', '2021-09-24 02:26:00'),
       (default, 1004,'https://somecdn.io/1004/56214968.png', 4968, 6200, 'CPA', '2021-09-24 02:26:00'),
       (default, 1004,'https://somecdn.io/1004/45646875.png', 6875, 5600, 'CPA', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/12616875.png', 6875, 20, 'CPM', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/58132035.png', 2035, 10, 'CPM', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/03548795.png', 8795, 50, 'CPM', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/21357478.png', 7478, 10, 'CPM', '2021-09-24 02:26:00'),
       (default, 1001,'https://somecdn.io/1001/21354658.png', 4658, 13, 'CPM', '2021-09-24 02:26:00');
