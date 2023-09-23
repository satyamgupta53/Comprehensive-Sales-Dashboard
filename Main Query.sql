
-- use master;
-- alter database bike_stores set single_user with rollback immediate;
-- drop database bike_stores;

use bike_stores;
SELECT 
	ord.order_id,
    -- to get customer name under one field instead of two fields
    CONCAT(cus.first_name, '', cus.last_name) AS 'customer name',
    cus.city,
    cus.state, 
    ord.order_date,
    SUM(ite.quantity) AS 'total units',
    SUM(ite.quantity * ite.list_price) AS 'revenue',
    pro.product_name,
    cat.category_name, 
    sto.store_name,
    CONCAT(sta.first_name, '', sta.last_name) AS 'sales_rep'

    -- joining both tables on customer id field 
FROM sales.orders ord
JOIN sales.customers cus
ON ord.customer_id = cus.customer_id
JOIN sales.order_items ite
ON ord.order_id = ite.order_id 
JOIN production.products pro
ON ite.product_id = pro.product_id
JOIN production.categories cat
ON pro.category_id = cat.category_id
JOIN sales.stores sto
ON ord.store_id = sto.store_id
JOIN sales.staffs sta
ON ord.staff_id = sta.staff_id

	-- because we have two functions in query, we group the other fields
GROUP BY 
	ord.order_id,
    CONCAT(cus.first_name, '', cus.last_name),
    cus.city,
    cus.state, 
    ord.order_date,
    pro.product_name,
	cat.category_name,
    sto.store_name,
    CONCAT(sta.first_name, '', sta.last_name)

