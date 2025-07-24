use sale_dw_dim;
CREATE TABLE stg_sales_cleaned (
  Product_ID           VARCHAR(50),
  Sale_Date            DATE,
  Sales_Rep            VARCHAR(100),
  Region               VARCHAR(100),
  Sales_Amount         DECIMAL(18,2),
  Quantity_Sold        INT,
  Product_Category     VARCHAR(100),
  Unit_Cost            DECIMAL(18,2),
  Unit_Price           DECIMAL(18,2),
  Customer_Type        VARCHAR(50),
  Discount             DECIMAL(5,2),
  Payment_Method       VARCHAR(50),
  Sales_Channel        VARCHAR(50),
  Region_and_Sales_Rep VARCHAR(200),
  profit decimal(18,2)
);

insert into dim_region (region_name)
select distinct region 
from stg_sales_cleaned
where region is not null on duplicate key update region_name = region_name;

insert into dim_product (product_id , product_category)
select distinct product_id , product_category
from stg_sales_cleaned
where product_id is not null
on duplicate key update product_category = values (product_category); 

insert into dim_sales_rep (sales_rep_name)
select distinct sales_rep
from stg_sales_cleaned
where sales_rep is not null
on duplicate key update sales_rep_name = sales_rep_name;

insert into dim_customer_type (customer_type)
select distinct customer_type
from stg_sales_cleaned
where customer_type is not null
on duplicate key update customer_type = values(customer_type );

insert into dim_channel (sales_channel)
select distinct sales_channel
from stg_sales_cleaned
where sales_channel is not null
on duplicate key update sales_channel = values (sales_channel);

insert into dim_payment_method (payment_method)
select distinct payment_method
from stg_sales_cleaned
where payment_method is not null
on duplicate key update payment_method = values(payment_method);


insert into dim_date (date_id, date, day, month, quarter, year, weekday)
select distinct
  cast(date_format(Sale_Date, '%Y%m%d') as unsigned) as date_id,
  Sale_Date                               as date,
  day(Sale_Date)                          as day,
  month(Sale_Date)                        as month,
  quarter(Sale_Date)                      as quarter,
  year(Sale_Date)                         as year,
  dayname(Sale_Date)                      as weekday
from stg_sales_cleaned
where Sale_Date IS NOT NULL
on duplicate key update
  date = values(date),
  day = values(day),
  month = values(month),
  quarter = values(quarter),
  year = values(year),
  weekday = values(weekday);



INSERT INTO fact_sales (
  date_id, product_id, region_id, sales_rep_id,
  customer_type_id, channel_id, payment_method_id,
  sales_amount, quantity_sold, unit_cost, unit_price,
  discount, profit
)
SELECT
  CAST(DATE_FORMAT(s.Sale_Date, '%Y%m%d') AS UNSIGNED) AS date_id,
  s.Product_ID,
  r.region_id,
  sr.sales_rep_id,
  ct.customer_type_id,
  ch.channel_id,
  pm.payment_method_id,
  s.Sales_Amount,
  s.Quantity_Sold,
  s.Unit_Cost,
  s.Unit_Price,
  s.Discount,
  (s.Unit_Price - s.Unit_Cost) * s.Quantity_Sold AS profit
FROM stg_sales_cleaned AS s
  JOIN dim_region AS r
    ON s.Region = r.region_name
  JOIN dim_sales_rep AS sr
    ON s.Sales_Rep = sr.sales_rep_name
  JOIN dim_customer_type AS ct
    ON s.Customer_Type = ct.customer_type
  JOIN dim_channel AS ch
    ON s.Sales_Channel = ch.sales_channel
  JOIN dim_payment_method AS pm
    ON s.Payment_Method = pm.payment_method;
