Create Table Zepto (
Sku_id SERIAL PRIMARY KEY,
Cateogory VARCHAR (120),
Name VARCHAR (150) NOT NULL,
MRP NUMERIC (8,2),
DiscountPercent Numeric (5,2),
AvailableQuantity INTEGER,
DiscountedSellingPrice Numeric (8,2),
WeightInGms INTEGER,
OutOfStock BOOLEAN,
Quantity INTEGER 
);
Select Count(*) From Zepto;

--Exploring our data

--COUNTING ROWS 
Select count(*) FROM Zepto;
--Viewing our data 
SELECT * FROM Zepto
LIMIT 10;
--Since I the category spelling is wrong I will change it 
ALTER TABLE Zepto
RENAME COLUMN Cateogory TO Category;
-- CHECKING FOR NULL VALUES
Select * From Zepto 
WHERE Name is NULL 
OR
Category is NULL 
OR
mrp is NULL 
OR
discountpercent is NULL 
OR
availablequantity is NULL 
OR
discountedsellingprice is NULL 
OR
weightingms is NULL 
OR
outofstock is NULL 
OR
Quantity is NULL 
-- CHECKING DIFFERENT PRODUCT CATEGORIES
SELECT DISTINCT CATEGORY
FROM Zepto
ORDER BY CATEGORY;
--SO we have total 14 categories

--TO CHECK PRODUCTS IN STOCK OR OUT OF STOCK
SELECT outofstock, COUNT (sku_id)
From Zepto
GROUP BY outofstock;
-- SO we have 453 Products OUTOFSTOCK & 3279 Instock

-- PRODUCTS Present Multiple times
SELECT name, COUNT(*) as duplicate_count
FROM Zepto 
GROUP BY name 
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

--DATA CLEANING 

--Checking if Price of a product is 0
SELECT * FROM Zepto
Where mrp = 0 Or DiscountedSellingPrice = 0 ;

-- There is 1 row so we are gonna drop it
Delete From Zepto 
Where mrp = 0;
-- The mrp and discountedSP is in paise so we convert it 
Update Zepto 
SET mrp = mrp/100.00,
DiscountedSellingPrice = DiscountedSellingPrice/100.00;

--Check
Select mrp,discountedsellingprice From Zepto;

--Time to solve questions using SQL for Buisness Insights
-- Q1. Find the top 10 best-value products based on the discount percentage?
SELECT Distinct name,mrp,discountpercent
FROM Zepto
Order By Discountpercent Desc
LIMIT 10;

-- Q2. What are the products with High MRP but Out of stock ?
SELECT Distinct name, mrp,Outofstock
From Zepto
where Outofstock = True
Order BY mrp Desc
Limit 10;

-- Calculate Estimated Revenue For each category 
SELECT Category,
SUM (DiscountedSellingPrice*AvailableQuantity) as Total_Revenue
From Zepto 
Group By Category 
Order By Total_Revenue

--Find all products where MRP is greater than 500 and discount is less than 10%.
SELECT DISTINCT name,mrp,discountPercent
FROM Zepto 
WHERE mrp > 500 AND Discountpercent < 10 
ORDER BY MRP DESC, Discountpercent DESC;

--Identify the top 5 categories offering the highest average discount percentage.
SELECT category , 
ROUND(AVG(Discountpercent),2) AS Avg_Discount
FROM Zepto 
GROUP BY category 
ORDER BY avg_discount DESC
LIMIT 5;

--Find the price per gram for products above 100g and sort by best value
SELECT Distinct Name, WeightInGms, DiscountedSellingPrice,
Round(DiscountedSellingPrice/Weightingms,2) As Price_per_gm
From Zepto
Where Weightingms>=100 
ORDER BY price_per_gm

--GROUP THE PRODUCTS INTO CATEGORIES LIE LOW,MEDIUM,BULK
SELECT DISTINCT name,WeightinGms,
CASE WHEN weightingms<1000 THEN 'LOW'
	When weightingms<5000 THEN 'MEDIUM'
	ELSE 'BULK' 
	END As Weight_Category
FROM Zepto;

--What is the Total Inventory Weight Per Category 
SELECT Category,
SUM (WeightinGms*availablequantity) As Total_Weight
From Zepto 
GROUP BY Category
ORDER BY total_weight;


