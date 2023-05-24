--Join the two tables so that every column and record appears, regardless of if there is not an owner_id . Your output should look like this:
SELECT * FROM owners LEFT JOIN vehicles ON vehicles.owner_id = owners.id;

-- Count the number of cars for each owner. Display the owners first_name , last_name and count of vehicles.
SELECT first_name, last_name, COUNT(*) FROM owners LEFT JOIN vehicles ON vehicles.owner_id = owners.id GROUP BY first_name, last_name ORDER BY first_name asc;

-- Count the number of cars for each owner and display the average price for each of the cars as integers.
SELECT * FROM (SELECT first_name, last_name, CAST(AVG(price) AS INTEGER) as average_price, COUNT(*) FROM owners LEFT JOIN vehicles ON vehicles.owner_id = owners.id GROUP BY first_name, last_name ORDER BY first_name asc) as t WHERE average_price > 10000;

