use sale_dw_dim;

-- Doanh số theo từng tháng
SELECT 
    d.Year,
    d.Month,
    SUM(f.Quantity_Sold * f.Unit_Price * (1 - f.Discount)) AS Monthly_Revenue
FROM fact_sales f
JOIN dim_date d ON f.Date_ID = d.Date_ID
GROUP BY d.Year, d.Month
ORDER BY d.Year, d.Month;

-- doanh số theo khu vực
SELECT 
    r.Region_ID,
    r.Region_Name,
    SUM(f.Quantity_Sold * f.Unit_Price * (1 - f.Discount)) AS Total_Revenue
FROM fact_sales f
JOIN dim_region r ON f.Region_ID = r.Region_ID
GROUP BY r.Region_ID, r.Region_Name
ORDER BY Total_Revenue DESC;

-- Báo cáo doanh số theo từng nhân viên
SELECT dsr.sales_rep_name, SUM(fs.sales_amount) AS total_sales
FROM fact_sales fs
JOIN dim_sales_rep dsr ON fs.sales_rep_id = dsr.sales_rep_id
GROUP BY dsr.sales_rep_name;

-- Báo cáo doanh số theo khu vực
SELECT dr.region_name, SUM(fs.sales_amount) AS total_sales
FROM fact_sales fs
JOIN dim_region dr ON fs.region_id = dr.region_id
GROUP BY dr.region_name;

-- Số đơn hàng theo nhân viên
SELECT dsr.sales_rep_name, COUNT(fs.sales_id) AS total_orders
FROM fact_sales fs
JOIN dim_sales_rep dsr ON fs.sales_rep_id = dsr.sales_rep_id
GROUP BY dsr.sales_rep_name;

-- Số lượng bán ra theo nhóm sản phẩm
SELECT dp.product_category, SUM(fs.quantity_sold) AS total_quantity
FROM fact_sales fs
JOIN dim_product dp ON fs.product_id = dp.product_id
GROUP BY dp.product_category;

-- Doanh thu theo kênh bán hàng
SELECT dc.sales_channel, SUM(fs.sales_amount) AS total_revenue
FROM fact_sales fs
JOIN dim_channel dc ON fs.channel_id = dc.channel_id
GROUP BY dc.sales_channel;

-- top 10 sản phẩm bán chạy nhất (theo số lượng)
SELECT 
    p.Product_ID,
    SUM(f.Quantity_Sold) AS Total_Units_Sold
FROM fact_sales f
JOIN dim_product p ON f.Product_ID = p.Product_ID
GROUP BY p.Product_ID
ORDER BY Total_Units_Sold DESC
LIMIT 10;




