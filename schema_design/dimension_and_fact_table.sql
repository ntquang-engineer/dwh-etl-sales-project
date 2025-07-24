create database sale_dw_dim;
use sale_dw_dim;
create table dim_date(
	date_id int primary key,
    date date not null,
    day int,
    month int,
    quarter int,
    year int,
    weekday varchar(10)
);

create table dim_product(
	product_id varchar(50) primary key,
    product_category varchar(100)
);

create table dim_region(
	region_id int primary key auto_increment,
	region_name  VARCHAR(100)
);

create table dim_sales_rep(
	sales_rep_id int primary key auto_increment,
    sales_rep_name varchar(100)
);

create table dim_customer_type (
	customer_type_id int primary key auto_increment,
    customer_type varchar (50)
);

create table dim_channel (
	channel_id int primary key auto_increment,
    sales_channel varchar (50)
);

create table dim_payment_method (
	payment_method_id INT PRIMARY KEY AUTO_INCREMENT,
	payment_method    VARCHAR(50)
);

create table fact_sales(
	sales_id BIGINT PRIMARY KEY AUTO_INCREMENT,
	date_id INT,
	product_id VARCHAR(50),
	region_id INT,
	sales_rep_id INT,
	customer_type_id INT,
	channel_id INT,
	payment_method_id INT,
	sales_amount DECIMAL(18,2),
	quantity_sold INT,
	unit_cost DECIMAL(18,2),
	unit_price DECIMAL(18,2),
	discount DECIMAL(5,2),
	profit DECIMAL(18,2),
	FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
	FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
	FOREIGN KEY (region_id) REFERENCES dim_region(region_id),
	FOREIGN KEY (sales_rep_id) REFERENCES dim_sales_rep(sales_rep_id),
	FOREIGN KEY (customer_type_id) REFERENCES dim_customer_type(customer_type_id),
	FOREIGN KEY (channel_id) REFERENCES dim_channel(channel_id),
	FOREIGN KEY (payment_method_id) REFERENCES dim_payment_method(payment_method_id)
);