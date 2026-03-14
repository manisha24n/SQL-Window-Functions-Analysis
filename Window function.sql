CREATE TABLE daily_revenue (
    order_id INT,
    order_date DATE,
    customer_id INT,
    department VARCHAR(50),
    revenue DECIMAL(10,2)
);

	INSERT INTO daily_revenue 
	values
(1, '2024-01-01', 101, 'Electronics', 50000),
(2, '2024-01-02', 102, 'Electronics', 70000),
(3, '2024-01-03', 101, 'Electronics', 40000),
(4, '2024-01-04', 103, 'Clothing', 30000),
(5, '2024-01-05', 104, 'Clothing', 60000),
(6, '2024-01-06', 101, 'Electronics', 80000),
(7, '2024-01-07', 102, 'Electronics', 20000),
(8, '2024-01-08', 103, 'Clothing', 90000),
(9, '2024-01-09', 104, 'Clothing', 10000),
(10, '2024-01-10', 101, 'Electronics', 100000);

select *from  daily_revenue



CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);


INSERT INTO employees VALUES
(1, 'Amit', 'IT', 60000, '2021-01-10'),
(2, 'Neha', 'IT', 75000, '2022-02-15'),
(3, 'Raj', 'HR', 50000, '2021-03-20'),
(4, 'Simran', 'HR', 65000, '2023-01-12'),
(5, 'Karan', 'Finance', 80000, '2020-05-05'),
(6, 'Pooja', 'Finance', 90000, '2022-06-10');

select * from employees



---Calculate cumulative revenue ordered by date.

select 
 order_date,
 revenue,
 sum(revenue) over(order by order_date) as cumulative_revenue
 from daily_revenue
 order by order_date;


---show employees' salary along with department salary average


select 
emp_id,
department,
salary,
   AVG(salary) over(Partition by department) as avg_salary
from employees
order by department;


----Rank Employees by Salary (within department)

select 
emp_id,
emp_name,
department,
salary,
   rank() 
   over(partition by department order by salary desc) as salary_rank
from employees;


---Find Previous Day Revenue  

select
order_date,
revenue,
   lag(revenue)	 over (order by order_date) as previous_day_revenue
from daily_revenue
order by  order_date;

---Find Next Day Revenue


select 
order_date,
revenue,
 lead(revenue) over (order by order_date) next_day_revenue
from daily_revenue
order by order_date;




---- Show revenue difference from the previous day

select 
order_date,
revenue,
  lag(revenue) over (order by order_date) as previous_day_revenue , 
  revenue - lag(revenue) over (order by order_date) as revenue_difference
from daily_revenue
order by order_date;
























---Find Highest paid  Employee in each department
SELECT *
FROM (
    SELECT 
        emp_id,
        emp_name,
        department,
        salary,
        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS rn
    FROM employees
) t
WHERE rn = 1;




