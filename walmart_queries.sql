USE Walmart;

-- Joining the three tables and visualizing the highest weekly sales for a specific store department

SELECT 
f.Store, 
f.Date, 
f.Temperature, 
f.Fuel_Price,CPI, 
f.Unemployment, 
f.IsHoliday, 
s.Type, 
s.Size,
tr.Dept,
tr.Weekly_sales
FROM features f
JOIN stores s
ON f.Store = s.Store
JOIN train tr
ON s.Store = tr.Store AND f.Date = tr.Date AND f.IsHoliday = tr.IsHoliday
ORDER BY tr.Weekly_sales DESC;

-- Joining the three tables and visualizing the lowest weekly sales for a specific store department

SELECT 
f.Store, 
f.Date, 
f.Temperature, 
f.Fuel_Price,CPI, 
f.Unemployment, 
f.IsHoliday, 
s.Type, 
s.Size,
tr.Dept,
tr.Weekly_sales
FROM features f
JOIN stores s
ON f.Store = s.Store
JOIN train tr
ON s.Store = tr.Store AND f.Date = tr.Date AND f.IsHoliday = tr.IsHoliday
ORDER BY tr.Weekly_sales ASC;

-- Querying the highest annual sales

SELECT 
    tr.Store, 
    YEAR(tr.Date) AS Year, 
    tr.Dept, 
    SUM(tr.Weekly_sales) as Annual_Sales
FROM 
    train tr
GROUP BY 
    tr.Store, 
    YEAR(tr.Date),
    tr.Dept
ORDER BY
    Annual_Sales DESC;
    
-- Querying the lowest annual sales    
    
SELECT 
    tr.Store, 
    YEAR(tr.Date) AS Year, 
    SUM(tr.Weekly_sales) as Annual_Sales
FROM 
    train tr
GROUP BY 
    tr.Store, 
    YEAR(tr.Date)
ORDER BY
    Annual_Sales ASC;
    
-- Querying the highest weekly sales for a store     

SELECT 
    tr.Store, 
    tr.Date,
    SUM(tr.Weekly_sales) as Weekly_Sales,
    RANK() OVER (ORDER BY SUM(tr.Weekly_sales) DESC) as Sales_Ranking
FROM 
    train tr
GROUP BY 
    tr.Store, 
    tr.Date
ORDER BY
    Sales_Ranking;
    
-- Querying the lowest weekly sales for a store    
    
SELECT 
    tr.Store, 
    tr.Date,
    SUM(tr.Weekly_sales) as Weekly_Sales,
    RANK() OVER (ORDER BY SUM(tr.Weekly_sales) DESC) as Sales_Ranking
FROM 
    train tr
GROUP BY 
    tr.Store, 
    tr.Date
ORDER BY
    Sales_Ranking DESC;
    
-- Querying the monthtly sales per store department

SELECT 
    tr.Store, 
    tr.Dept,
    YEAR(tr.Date) AS Year, 
    MONTH(tr.Date) AS Month, 
    SUM(tr.Weekly_sales) as Monthly_Sales
FROM 
    train tr
GROUP BY 
    tr.Store, 
    tr.Dept,
    YEAR(tr.Date), 
    MONTH(tr.Date)
ORDER BY
    tr.Store,
    tr.Dept,
    Year,
    Month;
    
-- Comparing and contrasting the average sales between holiday and non-holidays 

SELECT 
    IsHoliday,
    AVG(Weekly_Sales) as AverageSales
FROM 
    train 
GROUP BY 
    IsHoliday;
    
-- Comparing the average sales between store types A, B, and C

SELECT 
    s.Type,
    AVG(tr.Weekly_Sales) as AverageSales
FROM 
    stores s 
JOIN 
    train tr
ON 
    s.Store = tr.Store
GROUP BY 
    s.Type;
