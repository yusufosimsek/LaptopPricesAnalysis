SELECT * FROM [priceoye_laptops_version_2]

ALTER TABLE priceoye_laptops_version_2
ADD [Processor] NVARCHAR(50), 
    [RAM] NVARCHAR(20), 
    [Storage] NVARCHAR(50);

UPDATE [priceoye_laptops_version_2]
SET 
    [Processor] = CASE 
        WHEN Name LIKE '%M1%' THEN 'Apple M1'
        WHEN Name LIKE '%M2%' THEN 'Apple M2'
        WHEN Name LIKE '%M3%' THEN 'Apple M3'
        WHEN Name LIKE '%Ryzen 3%' THEN 'AMD Ryzen 3'
        WHEN Name LIKE '%Ryzen 5%' THEN 'AMD Ryzen 5'
        WHEN Name LIKE '%Ryzen 7%' THEN 'AMD Ryzen 7'
        WHEN Name LIKE '%Ryzen 9%' THEN 'AMD Ryzen 9'
        WHEN Name LIKE '%Core i3%' OR Name LIKE '%Ci3%' THEN 'Intel Core i3'
        WHEN Name LIKE '%Core i5%' OR Name LIKE '%Ci5%' THEN 'Intel Core i5'
        WHEN Name LIKE '%Core i7%' OR Name LIKE '%Ci7%' THEN 'Intel Core i7'
        WHEN Name LIKE '%Core i9%' OR Name LIKE '%Ci9%' THEN 'Intel Core i9'
        WHEN Name LIKE '%Ultra 5%' THEN 'Intel Core Ultra 5'
        WHEN Name LIKE '%Ultra 7%' THEN 'Intel Core Ultra 7'
        ELSE NULL
    END,
    [RAM] = CASE
        WHEN Name LIKE '%(4GB%' OR Name LIKE '% 4GB%' THEN '4GB'
        WHEN Name LIKE '%(8GB%' OR Name LIKE '% 8GB%' THEN '8GB'
        WHEN Name LIKE '%(16GB%' OR Name LIKE '% 16GB%' THEN '16GB'
        WHEN Name LIKE '%(32GB%' OR Name LIKE '% 32GB%' THEN '32GB'
        WHEN Name LIKE '%(64GB%' OR Name LIKE '% 64GB%' THEN '64GB'
        ELSE NULL
    END,
    [Storage] = CASE
        WHEN Name LIKE '%256GB%' THEN '256GB SSD'
        WHEN Name LIKE '%512GB%' THEN '512GB SSD'
        WHEN Name LIKE '%1TB%' THEN '1TB SSD'
        WHEN Name LIKE '%2TB%' THEN '2TB SSD'
        ELSE NULL
    END;

SELECT [column1] AS [Laptop_ID],
[Discounted_Price], [Actual_Price], [Rating], [Reviews], [Brand],
[Core],[SSD], [Series], [Processor], [RAM], [Storage] INTO [Laptops_Final_Analysis]
FROM [priceoye_laptops_version_2]

SELECT TOP 10 * FROM [Laptops_Final_Analysis];