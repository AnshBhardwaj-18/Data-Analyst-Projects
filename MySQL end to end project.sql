SELECT * FROM anshdb.books;
SELECT * FROM anshdb.customers;
SELECT * FROM anshdb.orders;

-- Basic Questions :

-- 1) retrive all books in the "fiction" genre:
use anshdb;
select * from books
where genre="Fiction";
-- 2) find books published after the year 1950:
select * from books
where published_year>1950;
-- 3) list all customers from the canada:
select * from customers
where country="canada";
-- 4) show orders placed in november 2023:
select * from orders
where order_date between "2023-11-01" and "2023-11-30";
-- 5) retrive the total stock of books available:
select sum(stock) as Total_Stock
from books;
-- 6) find the details of the most expensive book:
select * from books order by price desc limit 1;
-- 7) show all customers who ordered more than 1 quantity of book:
select * from orders
where quantity>1
-- 8) retrive all orders where the total amount exceeds $20:
select * from orders
where total_amount>20;
-- 9) list all genre available in the books table:
select distinct genre from books;
-- 10) find the book with the lowest stock:
select * from books order by stock limit 1;
-- 11) calculate the total revenue genreated from all orders:
select sum(total_amount) as Revenue
from orders;

-- Advance Questions :

-- 1)  retreive the total number of books sold for each genre:
select * from orders;
select b.genre, sum(o.quantity) as Total_Books_Sold
from orders o
join books b on o.book_id = b.book_id
group by b.genre;
-- 2) find the average price of books in the "fantasy" genre:
select avg(price) as Average_Price
from books
where genre = "fantasy";
-- 3) list cutomers who have placed at least 2 orders:
select customer_id, count(order_id) as Order_Count
from orders
group by customer_id
having count(order_id) >= 2;
------------------------------------------------------------------
select o.customer_id, c.name, count(o.order_id) as Order_Count
from orders o
join customers c on o.customer_id=c.customer_id
group by o.customer_id, c.name
having count(order_id) >= 2; 
-- 4) find the most frequently ordered book:
select o.book_id, b.title, count(o.order_id) as Order_Count
from orders o
join books b on o.book_id=b.book_id
group by o.book_id, b.title
order by Order_Count desc limit 1;
-- 5) show the top 3 most expensive books of "fantasy" genge:
select * from books
where genre = "fantasy"
order by price desc limit 3;
-- 6) retrive the total quantity of books sold by each author:
select b.author, sum(o.quantity) as Total_Books_Sold
from orders o
join books b on o.book_id=b.book_id
group by b.author;
-- 7) list the cities where customers who spent over $30 are located:
select distinct c.city, total_amount
from orders o 
join customers c on o.customer_id=c.customer_id
where o.total_amount > 30;
-- 8) find the customer who spent the most on orders:
select c.customer_id, c.name, sum(o.total_amount) as Total_Spent
from orders o
join customers c on o.customer_id = c.customer_id
group by c.customer_id, c.name
order by Total_Spent desc limit 1;
-- 9) calculate the stock remaining after fulfilling all orders:
select b.book_id, b.title, b.stock, coalesce(sum(quantity),0) as Order_Quantity,
b.stock - coalesce(sum(o.quantity),0) as Remaining_Quantity
from books b
left join orders o on b.book_id = o.book_id
group by b.book_id, b.title, b.stock order by b.book_id;




















