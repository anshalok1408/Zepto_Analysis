# Zepto Data Analysis Project

A comprehensive data cleaning and SQL-based analytical project on Zepto's product catalog. This project demonstrates end-to-end data processing, quality assurance, and business intelligence through SQL queries.

## 📋 Project Overview

This project analyzes a Zepto (quick commerce platform) product dataset containing **3,732 products** across **14 product categories** including Fruits & Vegetables, Cooking Essentials, Dairy, Beverages, Packaged Food, and more.

### Key Statistics
- **Total Products Analyzed:** 3,732
- **In-Stock Products:** 3,279
- **Out-of-Stock Products:** 453
- **Product Categories:** 14
- **Price Range:** ₹12 - ₹95,000+

## 📁 Files Included

### 1. **zepto_v2.csv**
Raw product data extracted from Zepto's catalog containing:
- **Product Details:** Category, Name, MRP, Weight
- **Pricing Information:** MRP, Discount Percentage, Discounted Selling Price
- **Inventory Data:** Available Quantity, Stock Status (In-Stock/Out-of-Stock)

**Data Fields:**
| Field | Type | Description |
|-------|------|-------------|
| SKU ID | Integer | Unique product identifier (Primary Key) |
| Category | String | Product category classification |
| Name | String | Product name |
| MRP | Numeric | Maximum Retail Price (in paise) |
| DiscountPercent | Numeric | Discount percentage offered |
| AvailableQuantity | Integer | Units available in inventory |
| DiscountedSellingPrice | Numeric | Final selling price (in paise) |
| WeightInGms | Integer | Product weight in grams |
| OutOfStock | Boolean | Stock status flag |
| Quantity | Integer | Additional quantity metric |

### 2. **Zepto-Analysis.sql**
Complete SQL analysis script with:
- Schema creation and data import
- Data quality checks and validation
- Data cleaning and transformation procedures
- Business intelligence queries with insights

## 🔧 Data Cleaning Process

### Issues Identified & Resolved

1. **Column Name Typo**
   - Fixed: `Cateogory` → `Category`
   - Method: `ALTER TABLE ... RENAME COLUMN`

2. **Null Value Check**
   - Verified: No NULL values in critical fields (Name, Category, MRP, Discounts, Pricing)

3. **Price Anomalies**
   - Identified: 1 product with ₹0 MRP
   - Action: Deleted invalid record

4. **Unit Conversion**
   - Original: Prices stored in paise (1/100th of rupee)
   - Conversion: Divided by 100 to display in rupees
   - Example: 25000 paise = ₹250

5. **Duplicate Products**
   - Analysis: Some products appear multiple times (different SKUs, quantities, categories)
   - Status: Retained for inventory accuracy

## 📊 Key Business Insights

### Query Results Summary

1. **Top 10 Best-Value Products (by Discount %)**
   - Identified products with highest discount percentages
   - Aids in promotional strategy and customer acquisition

2. **High MRP Out-of-Stock Products**
   - Products with premium pricing that face stock challenges
   - Opportunity for inventory replenishment analysis

3. **Revenue Analysis by Category**
   - Calculated: `Total Revenue = Discounted Selling Price × Available Quantity`
   - Identified top revenue-generating categories
   - Cooking Essentials and Fruits & Vegetables lead in revenue

4. **Premium Products with Low Discounts**
   - Filter: MRP > ₹500 AND Discount < 10%
   - Indicates high-margin, low-discount items

5. **Category Discount Trends**
   - Top 5 categories by average discount percentage
   - Insights into pricing strategy by segment

6. **Price Per Gram Analysis**
   - Products > 100g analyzed for value proposition
   - Metric: `Price per Gram = Discounted Selling Price / Weight in Grams`
   - Helps identify best value items by weight

7. **Weight-Based Product Classification**
   - **LOW:** < 1000 grams
   - **MEDIUM:** 1000-5000 grams
   - **BULK:** > 5000 grams

8. **Inventory Weight Analysis**
   - Metric: `Total Weight = Weight in Gms × Available Quantity`
   - Identifies categories with highest physical inventory

## 🛠️ Technology Stack

| Tool | Purpose |
|------|---------|
| **SQL** | Data cleaning, transformation, and analysis |
| **PostgreSQL/MySQL** | Database management (compatible with both) |
| **CSV** | Data storage and import |

## 🚀 Getting Started

### Prerequisites
- SQL-compatible database system (PostgreSQL, MySQL, SQLite)
- CSV import functionality

### Steps to Execute

1. **Import Data**
   ```sql
   -- Create table with specified schema
   CREATE TABLE Zepto (...)
   
   -- Import zepto_v2.csv
   LOAD DATA INFILE 'zepto_v2.csv' ...
   ```

2. **Run Data Cleaning**
   ```sql
   -- Fix column names, validate data, convert units
   -- All procedures in Zepto-Analysis.sql
   ```

3. **Execute Business Queries**
   ```sql
   -- Run individual queries for specific insights
   SELECT ... FROM Zepto ... (specific queries from SQL file)
   ```

## 📈 Sample Query Examples

### Query 1: Top 10 Best-Value Products
```sql
SELECT DISTINCT name, mrp, discountpercent 
FROM Zepto 
ORDER BY Discountpercent DESC 
LIMIT 10;
```

### Query 2: Revenue by Category
```sql
SELECT Category, 
       SUM(DiscountedSellingPrice * AvailableQuantity) AS TotalRevenue 
FROM Zepto 
GROUP BY Category 
ORDER BY TotalRevenue DESC;
```

### Query 3: Price Per Gram (Best Value Items)
```sql
SELECT DISTINCT Name, WeightInGms, DiscountedSellingPrice, 
       ROUND(DiscountedSellingPrice / WeightInGms, 2) AS PricePerGm 
FROM Zepto 
WHERE WeightInGms > 100 
ORDER BY PricePerGm;
```

## 📊 Data Quality Metrics

| Metric | Value |
|--------|-------|
| Total Records | 3,732 |
| Null Values | 0 |
| Duplicates (by Name) | ~245 |
| Removed Records | 1 |
| Data Completeness | 99.97% |
| Valid Price Range | ₹12 - ₹95,000 |

## 💡 Key Learnings

- **Data Cleaning is Critical:** Small issues (unit conversion, typos) significantly impact analysis
- **SQL Aggregations:** GROUP BY and JOIN operations for multi-dimensional analysis
- **Business Metrics:** Understanding revenue drivers and inventory health
- **Category Segmentation:** Different categories show distinct pricing and discount patterns
- **Stock vs. Price:** Premium products (high MRP) correlate with higher out-of-stock rates

## 📌 Use Cases

This analysis can support:
- **Inventory Management:** Identify fast-moving vs. slow-moving SKUs
- **Pricing Strategy:** Optimize discount percentages by category
- **Revenue Optimization:** Focus on high-revenue-generating categories
- **Stock Planning:** Allocate inventory based on category health
- **Customer Insights:** Understand discount sensitivity and purchasing patterns

## 🔍 Future Enhancements

- [ ] Time-series analysis (if date data becomes available)
- [ ] Competitor pricing analysis
- [ ] Customer purchase pattern correlation
- [ ] Demand forecasting by category
- [ ] Visualization dashboard (Power BI / Tableau)
- [ ] Advanced segmentation (RFM analysis if transactional data available)

## 📝 Notes

- All prices are displayed in Indian Rupees (INR) after unit conversion
- Out-of-stock status is a boolean indicator (TRUE = Out-of-Stock, FALSE = In-Stock)
- Some products appear multiple times due to different variants, quantities, or packaging options
- Analysis assumes current catalog snapshot as of data extraction date

## 🤝 Contributing

Suggestions for additional analyses:
- Alternative discount strategies
- Category-wise margin analysis
- Seasonal trends (if historical data available)
- Supplier performance metrics

## 📄 License

This project is for educational and analytical purposes.

---

**Project Status:** ✅ Complete  
**Last Updated:** January 2026  
**Data Extraction Date:** January 2026