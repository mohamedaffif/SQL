select geoID, sum(amount), avg(amount), sum(boxes)
from sales as s 
join geo g on s.geoID = g.geoID
group by GeoID;

select g.geo, sum(amount), avg(amount), sum(boxes)
from sales as s 
join geo g on s.geoID = g.geoID
group by g.geo;

select pr.category, p.team, sum(boxes), sum(amount)
from sales s 
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
group by pr.category, p.team;


select pr.category, p.team, sum(boxes), sum(amount)
from sales s 
join people p on p.spid = s.spid
join products pr on pr.pid = s.pid
where p.team <> ''
group by pr.category, p.team
order by pr.category, p.team;


select pr.Product, sum(s.amount) as 'Total Amount'
from sales as s 
join products as pr on pr.pid = s.pid
group by pr.Product
order by 'Total Amount' desc;



select pr.Product, sum(s.amount) as 'Total Amount'
from sales as s 
join products as pr on pr.pid = s.pid
group by pr.Product
order by 'Total Amount' desc
limit 10;




-- advanced sql 
-- 1. view the table (note the missing dates)
SELECT * FROM sales;
-- 2. preview the finale results
SELECT * FROM final_sales;

-- 3. generate a series of dates [UNION, UNION ALL]
SELECT '2025-01-01' dt
UNION ALL
SELECT '2025-01-02'
UNION ALL
SELECT '2025-01-02';

-- 4. join with our original table [Subquery, left join, inner join]
SELECT sq.dt, sales.num_sales 
FROM 
(SELECT '2025-01-01' dt
UNION ALL
SELECT '2025-01-02'
UNION ALL
SELECT '2025-01-03'
UNION ALL
SELECT '2025-01-04'
UNION ALL
SELECT '2025-01-05'
UNION ALL
SELECT '2025-01-06'
UNION ALL
SELECT '2025-01-07') AS sq
 -- LEFT JOIN sales ON sq.dt = sales.dt
INNER JOIN sales ON sq.dt = sales.dt
;

-- 5. Rewrite subquery as a CTE [CTE]
WITH cte AS (SELECT '2025-01-01' dt
			UNION ALL
			SELECT '2025-01-02'
			UNION ALL
			SELECT '2025-01-03'
			UNION ALL
			SELECT '2025-01-04'
			UNION ALL
			SELECT '2025-01-05'
			UNION ALL
			SELECT '2025-01-06'
			UNION ALL
			SELECT '2025-01-07') 
SELECT 		cte.dt, sales.num_sales
 FROM 		cte LEFT JOIN sales ON cte.dt = sales.dt;
 
 -- 6. rewrite CTE as a recursive CTE (Recursive CTE , Date Expression, Date function)
 
 WITH RECURSIVE cte AS (SELECT CAST('2025-01-01' AS DATE) dt
			UNION ALL
			SELECT dt + INTERVAL 1 DAY  
            FROM cte 
            WHERE dt < CAST('2025-01-07' AS DATE)
            )
		
SELECT 		cte.dt, sales.num_sales
 FROM 		cte LEFT JOIN sales ON cte.dt = sales.dt;
 
 -- 7 . fill in null values [NULL Function, Numeric Function]
 WITH RECURSIVE cte AS (SELECT CAST('2025-01-01' AS DATE) dt
			UNION ALL
			SELECT dt + INTERVAL 1 DAY  
            FROM cte 
            WHERE dt < CAST('2025-01-07' AS DATE)
            )
		
SELECT 		cte.dt, sales.num_sales,
			COALESCE(sales.num_sales,0) AS sales_estimate,
            COALESCE(sales.num_sales, ROUND((SELECT AVG(sales.num_sales) FROM sales),2)) AS sales_estimate_2
 FROM 		cte LEFT JOIN sales ON cte.dt = sales.dt;
 
-- 8. introduce window functions [WINDOW FUNCTIONS]
SELECT dt, num_sales FROM sales;
 
 









