-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country_id INT NOT NULL,
  FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE flyers (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT NOT NULL,
  flyer_number TEXT NOT NULL,
  flyer_level TEXT NOT NULL,
  flyer_status TEXT NOT NULL
);

CREATE TABLE airlines (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country_id INT NOT NULL,
  headquarters TEXT NOT NULL,
  website TEXT NOT NULL,
  FOREIGN KEY (country_id) REFERENCES countries(id)
);

CREATE TABLE airports (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  city_id INT NOT NULL,
  FOREIGN KEY (city_id) REFERENCES cities(id)
);

CREATE TABLE planes (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  airline_id INT NOT NULL,
  seats INT NOT NULL,
  year_made INT NOT NULL,
  model TEXT NOT NULL,
  FOREIGN KEY (airline_id) REFERENCES airlines(id)
);

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  plane_id INT NOT NULL,
  airline_id INT NOT NULL,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  from_airport_id INT NOT NULL,
  to_airport_id INT NOT NULL,
  FOREIGN KEY (plane_id) REFERENCES planes(id),
  FOREIGN KEY (airline_id) REFERENCES airlines(id),
  FOREIGN KEY (from_airport_id) REFERENCES airports(id),
  FOREIGN KEY (to_airport_id) REFERENCES airports(id)
);

CREATE TABLE tickets
(
  id SERIAL PRIMARY KEY,
  flyer_id INT NOT NULL,
  flight_id INT NOT NULL,
  seat TEXT NOT NULL,
  FOREIGN KEY (flyer_id) REFERENCES flyers(id),
  FOREIGN KEY (flight_id) REFERENCES flights(id)
);

INSERT INTO countries (name) VALUES
  ('United States'),
  ('Japan'),
  ('United Kingdom'),
  ('Mexico'),
  ('France'),
  ('Morocco'),
  ('UAE'),
  ('China'),
  ('Brazil'),
  ('Chile');

INSERT INTO cities (name, country_id) VALUES
  ('Washington DC', 1),
  ('Seattle', 1),
  ('Los Angeles', 1),
  ('Las Vegas', 1),
  ('New York', 1),
  ('Charlotte', 1),
  ('Cedar Rapids', 1),
  ('Chicago', 1),
  ('Tokyo', 2),
  ('London', 3),
  ('Mexico City', 4),
  ('Paris', 5),
  ('Casablanca', 6),
  ('Dubai', 7),
  ('Beijing', 8),
  ('Sao Paolo', 9),
  ('Santiago', 10);

INSERT INTO airports (name, city_id) VALUES
  ('Washington DC Airport', 1),
  ('Seattle Airport', 2),
  ('Los Angeles Airport', 3),
  ('Las Vegas Airport', 4),
  ('New York Airport', 5),
  ('Charlotte Airport', 6),
  ('Cedar Rapids Airport', 7),
  ('Chicago Airport', 8),
  ('Tokyo Airport', 9),
  ('London Airport', 10),
  ('Mexico City Airport', 11),
  ('Paris Airport', 12),
  ('Casablanca Airport', 13),
  ('Dubai Airport', 14),
  ('Beijing Airport', 15),
  ('Sao Paolo Airport', 16),
  ('Santiago Airport', 17);

INSERT INTO airlines (name, country_id, headquarters, website) VALUES
  ('United', 1, 'Chicago, IL', 'site1'),
  ('British Airways', 3, 'London, UK', 'site2'),
  ('Delta', 1, 'Atlanta, GA', 'site3'),
  ('TUI Fly Belgium', 5, 'Zaventem, Belgium', 'site4'),
  ('Air China', 8, 'Beijing, China', 'site5'),
  ('American Airlines', 1, 'Fort Worth, TX', 'site6'),
  ('Avianca Brasil', 9, 'São Paulo, Brazil', 'site7');

INSERT INTO flyers (first_name, last_name, email, phone, flyer_number, flyer_level, flyer_status) VALUES
  ('Jennifer', 'Finch', 'jennifer@example.com', '1234567890', 'FLY001', 'Gold', 'Active'),
  ('Thadeus', 'Gathercoal', 'thadeus@example.com', '2345678901', 'FLY002', 'Silver', 'Active'),
  ('Sonja', 'Pauley', 'sonja@example.com', '3456789012', 'FLY003', 'Bronze', 'Active'),
  ('Waneta', 'Skeleton', 'waneta@example.com', '4567890123', 'FLY004', 'Gold', 'Active'),
  ('Berkie', 'Wycliff', 'berkie@example.com', '5678901234', 'FLY005', 'Silver', 'Active'),
  ('Alvin', 'Leathes', 'alvin@example.com', '6789012345', 'FLY006', 'Gold', 'Active'),
  ('Cory', 'Squibbes', 'cory@example.com', '7890123456', 'FLY007', 'Bronze', 'Active');

INSERT INTO planes (name, airline_id, seats, year_made, model) VALUES
  ('Plane 1', 1, 150, 2005, 'Boeing 737'),
  ('Plane 2', 2, 180, 2010, 'Airbus A320'),
  ('Plane 3', 3, 220, 2015, 'Boeing 777'),
  ('Plane 4', 4, 120, 2010, 'Airbus A220'),
  ('Plane 5', 5, 200, 2008, 'Boeing 747'),
  ('Plane 6', 6, 250, 2012, 'Airbus A380'),
  ('Plane 7', 7, 100, 2000, 'Boeing 737');
  
INSERT INTO flights (plane_id, airline_id, departure, arrival, from_airport_id, to_airport_id) VALUES
  (1, 1, '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 2),
  (1, 2, '2018-12-19 12:45:00', '2018-12-19 16:15:00', 9, 10),
  (1, 3, '2018-01-02 07:00:00', '2018-01-02 08:03:00', 3, 4),
  (1, 3, '2018-04-15 16:50:00', '2018-04-15 21:00:00', 2, 11),
  (1, 4, '2018-08-01 18:30:00', '2018-08-01 21:50:00', 12, 13),
  (1, 5, '2018-10-31 01:15:00', '2018-10-31 12:55:00', 14, 15),
  (1, 1, '2019-02-06 06:00:00', '2019-02-06 07:47:00', 5, 6),
  (1, 6, '2018-12-22 14:42:00', '2018-12-22 15:56:00', 7, 8),
  (1, 6, '2019-02-06 16:28:00', '2019-02-06 19:18:00', 6, 16),
  (1, 7, '2019-01-20 19:30:00', '2019-01-20 22:45:00', 17, 5);

INSERT INTO tickets (flyer_id, flight_id, seat) VALUES
  (1, 1, '33B'),
  (2, 2, '8A'),
  (3, 3, '12F'),
  (1, 4, '20A'),
  (4, 5, '23D'),
  (2, 6, '18C'),
  (5, 7, '9E'),
  (6, 8, '1A'),
  (5, 9, '32B'),
  (7, 10, '10D');



