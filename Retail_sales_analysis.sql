create database retail_project;
use retail_project;
show tables;
create table products (
product_id int primary key,
product_name varchar(100),
category varchar(50),
price decimal(10,2)
);
show tables;
insert into products
values (1, 'Wireless Mouse', 'Electronics', 29.99);

select * from products;

insert into products
values (2, 'Mechanical Keyboard', 'Electronics', 79.99);

insert into products
values
(3, 'Running Shoes', 'Footwear', 89.99),
(4, 'Hoodie', 'Clothing', 44.99);

insert into products
values (5, 'Water Bottle', 'Accessories', 14.99);

select * from products;

use retail_project;
select * from products;

create table customers (
customer_id int primary key,
first_name varchar(50),
last_name varchar(50),
city varchar(50),
state varchar(2)
);

insert into customers
values
(1, 'Aisha', 'Khan', 'Dallas', 'TX'),
(2, 'Amaan', 'Sid', 'Plano', 'TX'),
(3, 'Aerion', 'Targaryen', 'Dragonstone', 'WT'),
(4, 'Baelor', 'Targaryen', 'Dragonstone', 'WT'),
(5, 'Sarah', 'Williams', 'Frisco', 'TX');

select * from customers;

create table orders (
order_id int primary key,
customer_id int,
product_id int, 
quantity int,
order_date date,
foreign key (customer_id) references customers(customer_id),
foreign key (product_id) references products(product_id)
);

show tables;

insert into orders
values
(1,2,2,1, '2026-09-01'),
(2, 1, 1, 2, '2026-09-02'),
(3, 3, 3, 1, '2026-09-03'),
(4, 4, 4, 2, '2026-09-04'),
(5, 5, 5, 3, '2026-09-05');

select * from orders;
SELECT
    customers.first_name,
    customers.last_name,
    products.product_name,
    orders.quantity,
    orders.order_date
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN products
    ON orders.product_id = products.product_id;
    
select
	products.product_name,
    products.price,
    orders.quantity,
    products.price * orders.quantity AS revenue
from orders
join products
	on orders.product_id = products.product_id;
    
select 
	sum(products.price * orders.quantity) as total_revenue
from orders
join products
	on orders.product_id = products.product_id;
    
select
	products.category,
    sum(products.price * orders.quantity) AS category_revenue
from orders
join products
	on orders.product_id = products.product_id
group by products.category;

select
	products.product_name,
    sum(orders.quantity) as total_units_sold
from orders
join products
	on orders.product_id = products.product_id
group by products.product_name
order by total_units_sold desc;

select
	avg(products.price * orders.quantity) as average_order_value
from orders
join products
	on orders.product_id = products.product_id;
    
select
	products.product_name,
    sum(products.price * orders.quantity) as product_revenue
from orders
join products
	on orders.product_id = products.product_id
group by products.product_name
order by product_revenue desc;

describe customers;

SELECT
    CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name,
    SUM(products.price * orders.quantity) AS total_spent
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id
JOIN products
    ON orders.product_id = products.product_id
GROUP BY customers.customer_id, customers.first_name, customers.last_name
ORDER BY total_spent DESC;

select
	customers.state,
    sum(products.price * orders.quantity) as state_revenue
from orders
join customers
	on orders.customer_id = customers.customer_id
join products
	on orders.product_id = products.product_id
group by customers.state
order by state_revenue desc;