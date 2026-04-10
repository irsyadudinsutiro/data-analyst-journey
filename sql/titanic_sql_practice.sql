# Day 1
CREATE TABLE passengers (
passengerid INT PRIMARY KEY,
survived INT,
pclass INT,
name VARCHAR(255),
sex VARCHAR(15),
age FLOAT,
sibsp INT,
parch INT,
ticket VARCHAR(50),
fare float,
cabin VARCHAR(50),
embarked CHAR(1)
)

## Check if table is working
select * FROM passengers;

## Check the total row count of table
SELECT COUNT(*) FROM PASSENGERS;

# Day 2
## rows where first class passengers survived
SELECT * FROM passengers
WHERE pclass = 1 AND survived = 1;

## name age columns of top 5 oldest passengers
SELECT name,age FROM passengers
ORDER BY age ASC LIMIT 5;

## female first class survivers
SELECT * FROM passengers
WHERE sex = 'female' AND pclass = 1 AND survived = 1;

## Average age of passengers where they have miss in their names
SELECT AVG(age) FROM passengers
WHERE name ILIKE ('%miss%');

# Day 3
## Write the survival summary table
SELECT pclass, sex, AVG(age),SUM(survived),COUNT(*),AVG(survived::Float) * 100 AS survival_rate
FROM passengers
GROUP BY pclass, sex
ORDER BY pclass;

## Practice having
SELECT embarked, COUNT(*) FROM passengers
GROUP BY embarked
HAVING COUNT(*) > 100;

# DAY 4
## Create cabins table
CREATE TABLE cabins(
passengerid INT REFERENCES passengers(passengerid)
cabin VARCHAR(50)
);

## Populate cabins table
INSERT INTO cabins (passengerid, cabin)
SELECT passengerid, cabin 
FROM passengers
WHERE cabin IS NOT NULL;

## Inner Join 204 Rows
SELECT p.passengerid, p.name, c.cabin FROM passengers p
INNER JOIN cabins c
ON p.passengerid = c.passengerid;

## Left Join 891 Rows
SELECT p.passengerid, p.name, c.cabin FROM passengers p
LEFT JOIN cabins c
ON p.passengerid = c.passengerid

## Right Join - 204 Rows
SELECT p.passengerid, p.name, c.cabin FROM passengers p
RIGHT JOIN cabins c
ON p.passengerid = c.passengerid

## Full Outer Join - 891 Rows
SELECT p.passengerid, p.name, c.cabin FROM passengers p
FULL OUTER JOIN cabins c
ON p.passengerid = c.passengerid

# Day 5
## Write a query that fills null ages with median age by class, categorises fare into bins, and returns a cleaned view
CREATE VIEW passengers_cleaned AS
SELECT passengerid,name,sex,pclass,COALESCE(age,30) AS age_filled,
CASE WHEN fare < 10 THEN 'low' WHEN fare < 50 THEN 'medium' WHEN fare < 100 then 'high' ELSE 'very high'
END AS fare_category, survived FROM passengers;

