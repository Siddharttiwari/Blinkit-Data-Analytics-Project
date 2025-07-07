use blinkit;
SELECT * FROM blinkit_data;
DESCRIBE blinkit_data;

SHOW COLUMNS FROM blinkit_data;
ALTER TABLE blinkit_data
CHANGE `ï»¿Item Fat Content` Item_Fat_Content VARCHAR(255);
ALTER TABLE blinkit_data
CHANGE `Outlet Establishment Year` Outlet_Establishment_Year bigint;
ALTER TABLE blinkit_data
CHANGE `Item type` Item_Type varchar(255);
ALTER TABLE blinkit_data
CHANGE `Outlet Location Type` Outlet_Location_Type varchar(255);
ALTER TABLE blinkit_data
CHANGE `Outlet Size` Outlet_Size VARCHAR(225),
CHANGE `Item Identifier` Item_Identifier VARCHAR(255),
CHANGE `Outlet Identifier` Outlet_Identifier VARCHAR(255),
CHANGE `Outlet Type`Outlet_Type VARCHAR(255),
CHANGE `Item Visibility` Item_Visibility FLOAT8,
CHANGE `Item Weight` Item_Weight float4;

SELECT COUNT(*) FROM blinkit_data;
SET SQL_SAFE_UPDATES = 0;

UPDATE blinkit_data
set Item_Fat_Content=
CASE
WHEN Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END;

SELECT DISTINCT(Item_Fat_Content) FROM blinkit_data;


SELECT  CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions FROM blinkit_data;


SELECT COUNT(*) FROM blinkit_data;
SELECT CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales FROM blinkit_data;

SELECT CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating from blinkit_data;


SELECT Item_Fat_Content, 
          CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
          CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales,
          COUNT(*) AS No_Of_Items,
          CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year=2020
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC;


SELECT Item_Type, 
          CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
          CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales,
          COUNT(*) AS No_Of_Items,
          CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating
FROM blinkit_data
WHERE Outlet_Establishment_Year=2020
GROUP BY Item_Type
ORDER BY Total_Sales ASC
LIMIT 5 ;

SELECT 
  Outlet_Location_Type,
  SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Sales ELSE 0 END) AS Low_Fat,
  SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Sales ELSE 0 END) AS Regular
FROM 
  blinkit_data
GROUP BY 
  Outlet_Location_Type
ORDER BY 
  Outlet_Location_Type;

SELECT Outlet_Establishment_Year,
	   CAST(SUM(Sales) AS DECIMAL(10,2) ) AS Total_Sales,
        CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales,
          COUNT(*) AS No_Of_Items,
          CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

SELECT Outlet_size,
       CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
       CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

SELECT Outlet_Location_Type,
	   CAST(SUM(Sales) AS DECIMAL(10,2) ) AS Total_Sales,
        CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales,
          COUNT(*) AS No_Of_Items,
          CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating,
          CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales ASC;


SELECT Outlet_Type,
	   CAST(SUM(Sales) AS DECIMAL(10,2) ) AS Total_Sales,
        CAST(AVG(Sales)AS DECIMAL(10,2)) AS Avg_Sales,
          COUNT(*) AS No_Of_Items,
          CAST(AVG(Rating) AS DECIMAL(10,2))AS AVG_Rating,
          CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales ASC;













