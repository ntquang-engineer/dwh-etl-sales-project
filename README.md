# Sales Data Warehouse Project

- Dự án này mô phỏng quy trình xây dựng một hệ thống **Data Warehouse** cơ bản từ dữ liệu bán hàng (`sales_data.csv`) thu thập từ Kaggle.
- Mục tiêu là hiểu và thực hành các bước: làm sạch dữ liệu, thiết kế star schema, ETL, và phân tích dữ liệu.

---

## Mục tiêu

- Hiểu rõ các bước chính trong một dự án Kho Dữ liệu (Data Warehouse).
- Làm sạch và phân tích dữ liệu thô từ tệp CSV.
- Thiết kế mô hình dữ liệu dạng chiều (Star Schema).
- Sử dụng MYSQL để nạp dữ liệu vào các bảng fact và dimension.
- Thực hành ETL cơ bản sử dụng Pandas.

---

## Cấu trúc thư mục
```
sales_dw_project/
├── README.md 
├── data/ 
│ └── sales_data.csv
├── staging/ 
│ └── stg_sales_cleaned.csv
├── notebooks/ 
│ ├── data_cleaning.ipynb
│ └── data_profiling.ipynb
├── schema_design/ 
│ ├── dw_schema.png
│ ├── dimension_and_fact_table.sql
│ └── insert_dimension_and_fact_table.sql
├── etl/ 
│ └── connect_and_load_to_mysql.ipynb
├── sql_queries/ 
│ └── report_queries.sql
```

---
## Các bước thực hiện

1. **Data Cleaning**  (notebooks/data_cleaning.ipynb)
   - Làm sạch dữ liệu thiếu (null)
   - Chuẩn hóa tên cột
   - Chuyển đổi định dạng ngày tháng
   - Xuất dữ liệu sạch vào `staging/stg_sales_cleaned.csv`

2. **Data Profiling**  (notebooks/02_data_profiling.ipynb)
   - Thống kê số lượng null, unique
   - Vẽ biểu đồ boxplot, scatter plot
   - Tính toán

3. **Schema Design**  
   - Thiết kế lược đồ sao gồm các bảng dimension và fact  
   - Vẽ sơ đồ schema (`dw_schema.png`) và viết script tạo bảng SQL

4. **ETL Process**  (etl/connect_and_load_to_mysql.ipynb)
   - Dùng SQLAlchemy + pandas để nạp dữ liệu từ CSV vào MySQL
   - Viết notebook/script ETL để insert dữ liệu vào các bảng

---
## Kết quả và Ý nghĩa
   - Chuẩn hóa và làm sạch dữ liệu đầu vào, đảm bảo tính nhất quán và chính xác.
   - Thiết kế mô hình Star Schema với các bảng dimension và fact giúp tối ưu hóa truy vấn phân tích.
   - Giúp xây dựng nền tảng để phân tích dữ liệu tập trung.
---

## Công Cụ Sử Dụng

- Python (Pandas,Matplotlib,SQLAlchemy, Jupyter Notebook)
- SQL (MYSQL,thiết kế star schema)
- Markdown 

---

## Nguồn dữ liệu

Dataset: [sales_data.csv trên Kaggle](https://www.kaggle.com/)  

---

## License

Dự án này được cấp phép theo [Giấy phép MIT](LICENSE).

---

## Tác giả

Dự án được thực hiện bởi [Nguyễn Thiện Quang] trong quá trình học Data Engineering.  
Mục tiêu: Thực hành xây dựng Data Warehouse & ETL pipelines.


