use Meta
--Create Table
CREATE TABLE ingredients (
  ingredient_id INT NOT NULL, 
  ingredient_name VARCHAR(30) NOT NULL,
  ingredient_price INT NOT NULL,)

--Insert Values
insert into ingredients
values(1, 'Beef', 5),
    (2, 'Lettuce', 1),
    (3, 'Tomatoes', 2),
    (4, 'Taco Shell', 2),
    (5, 'Cheese', 3),
    (6, 'Milk', 1),
    (7, 'Bread', 2);

--SHowing Data
select * from ingredients

backup database employee to disk = 'E:\Backup\full_classmate_30Marach.bak'