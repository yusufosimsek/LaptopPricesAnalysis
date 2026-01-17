SELECT * FROM [priceoye_laptops_version_2]

SELECT DISTINCT [Name] FROM [priceoye_laptops_version_2]

UPDATE [priceoye_laptops_version_2] 
SET [Name] = 'Acer' + SUBSTRING([Name], 5, LEN([Name]))
WHERE [Name] LIKE 'ACER%'

UPDATE [priceoye_laptops_version_2]
SET [Name] = 'Asus' + SUBSTRING([Name], 5, LEN([Name]))
WHERE [Name] LIKE 'ASUS%'

UPDATE [priceoye_laptops_version_2]
SET [Name] = 'Dell' + SUBSTRING([Name], 5, LEN([Name]))

UPDATE [priceoye_laptops_version_2]
SET [Name] = 'Dellictus' + SUBSTRING([Name], 5, LEN([Name]))
WHERE [Name] LIKE 'DellICTUS%'

UPDATE priceoye_laptops_version_2
SET Name = CASE 

    WHEN Name LIKE 'DellMNIBOOK%' THEN STUFF(Name, 1, 11, 'HP OMNIBOOK')
    WHEN Name LIKE 'DellmniBook%' THEN STUFF(Name, 1, 11, 'HP OmniBook')

    ELSE Name
END
WHERE Name LIKE 'DellMNIBOOK%' 
   OR Name LIKE 'DellmniBook%'

UPDATE priceoye_laptops_version_2
SET Name = REPLACE(Name, 'DellMEN', 'HP OMEN')
WHERE Name LIKE 'DellMEN%';

UPDATE priceoye_laptops_version_2
SET Name = STUFF(Name, 1, 7, 'Infinix')
WHERE Name LIKE 'Dellnix%';

UPDATE priceoye_laptops_version_2
SET Name = CASE 
    WHEN Name LIKE 'DellNVY%' THEN STUFF(Name, 1, 7, 'HP ENVY')
    WHEN Name LIKE 'Dellnvy%' THEN STUFF(Name, 1, 7, 'HP Envy')

    WHEN Name LIKE 'Dellrobook%' THEN STUFF(Name, 1, 10, 'HP Probook')
    WHEN Name LIKE 'DellROBOOK%' THEN STUFF(Name, 1, 10, 'HP PROBOOK')
    WHEN Name LIKE 'DellroBook%' THEN STUFF(Name, 1, 10, 'HP ProBook')

    WHEN Name LIKE 'Dellvo%' THEN STUFF(Name, 1, 6, 'Lenovo')
    WHEN Name LIKE 'DellVO%' THEN STUFF(Name, 1, 6, 'LENOVO')

    WHEN Name LIKE 'DellMEN%' THEN STUFF(Name, 1, 7, 'HP OMEN')
    WHEN Name LIKE 'DellMNIBOOK%' THEN STUFF(Name, 1, 11, 'HP OMNIBOOK')
    WHEN Name LIKE 'DellmniBook%' THEN STUFF(Name, 1, 11, 'HP OmniBook')
    WHEN Name LIKE 'DellICTUS%' THEN STUFF(Name, 1, 9, 'HP Victus')

    WHEN Name LIKE 'Dellnix%' THEN STUFF(Name, 1, 7, 'Infinix')

    WHEN Name LIKE 'ACER %' AND Name NOT LIKE 'Acer %' 
        THEN 'Acer' + SUBSTRING(Name, 5, LEN(Name))

    ELSE Name
END
WHERE Name LIKE 'DellNVY%' OR Name LIKE 'Dellnvy%'
   OR Name LIKE 'Dellro%' OR Name LIKE 'DellRO%'
   OR Name LIKE 'Dellvo%' OR Name LIKE 'DellVO%'
   OR Name LIKE 'DellMEN%' OR Name LIKE 'DellICTUS%'
   OR Name LIKE 'DellMNI%' OR Name LIKE 'Dellnix%'
   OR (Name LIKE 'ACER %' AND Name NOT LIKE 'Acer %');



WITH [LaptopSeries] AS (
    SELECT [Name],
        CASE
            WHEN [Name] LIKE '%Acer%' THEN 'Acer'
            WHEN [Name] LIKE '%Apple Macbook%' THEN 'Macbook'
            WHEN [Name] LIKE '%Asus%' THEN 'Asus'
            WHEN [Name] LIKE '%Dell%' THEN 'Dell'
            WHEN [Name] LIKE '%Dellavilion%' THEN 'HP Pavilion'
            WHEN [Name] LIKE '%Delle%' THEN 'HP EliteBook'
            WHEN [Name] LIKE '%Dellictus%' THEN 'HP Victus'
            WHEN [Name] LIKE '%DellliteBook%' THEN 'HP EliteBook'
            WHEN [Name] LIKE '%Dellpectre%' THEN 'HP Spectre'
            WHEN [Name] LIKE '%HP%' THEN 'HP'
            WHEN [Name] LIKE '%Infinix%' THEN 'Infinix'
            WHEN [Name] LIKE '%Lenovo%' THEN 'Lenovo' 
            ELSE 'Other'
        END AS Series
    FROM [priceoye_laptops_version_2]
)
SELECT * FROM [LaptopSeries];

ALTER TABLE priceoye_laptops_version_2
ADD Series NVARCHAR(50);

UPDATE [priceoye_laptops_version_2]
SET [Series] = CASE 
    -- APPLE
    WHEN Name LIKE '%MacBook%' THEN 'MacBook'
    
    -- LENOVO
    WHEN Name LIKE '%ThinkPad%' THEN 'ThinkPad'
    WHEN Name LIKE '%IdeaPad%' THEN 'IdeaPad'
    WHEN Name LIKE '%Legion%' THEN 'Legion'
    WHEN Name LIKE '%LOQ%' THEN 'LOQ'
    WHEN Name LIKE '%ThinkBook%' THEN 'ThinkBook'
    WHEN Name LIKE '%Yoga%' THEN 'Yoga'
    WHEN Name LIKE '%V15%' OR Name LIKE '%V14%' THEN 'V Series'
    
    -- ASUS
    WHEN Name LIKE '%Zenbook%' THEN 'Zenbook'
    WHEN Name LIKE '%Vivobook%' THEN 'Vivobook'
    WHEN Name LIKE '%TUF%' THEN 'TUF Gaming'
    WHEN Name LIKE '%ROG%' THEN 'ROG'
    WHEN Name LIKE '%ExpertBook%' THEN 'ExpertBook'
    
    -- HP
    WHEN Name LIKE '%Pavilion%' THEN 'Pavilion'
    WHEN Name LIKE '%Envy%' THEN 'Envy'
    WHEN Name LIKE '%Spectre%' THEN 'Spectre'
    WHEN Name LIKE '%Omen%' THEN 'Omen'
    WHEN Name LIKE '%Victus%' THEN 'Victus'
    WHEN Name LIKE '%ProBook%' THEN 'ProBook'
    WHEN Name LIKE '%EliteBook%' THEN 'EliteBook'
    WHEN Name LIKE '%OmniBook%' THEN 'OmniBook'
    WHEN Name LIKE '%Chromebook%' THEN 'Chromebook'
    
    -- DELL
    WHEN Name LIKE '%Inspiron%' THEN 'Inspiron'
    WHEN Name LIKE '%Vostro%' THEN 'Vostro'
    WHEN Name LIKE '%Latitude%' THEN 'Latitude'
    WHEN Name LIKE '%Alienware%' THEN 'Alienware'
    WHEN Name LIKE '%XPS%' THEN 'XPS'
    WHEN Name LIKE '%G15%' THEN 'G Series'
    
    -- ACER
    WHEN Name LIKE '%Nitro%' THEN 'Nitro'
    WHEN Name LIKE '%Predator%' THEN 'Predator'
    WHEN Name LIKE '%Aspire%' THEN 'Aspire'
    WHEN Name LIKE '%Swift%' THEN 'Swift'
    
    -- INFINIX
    WHEN Name LIKE '%Inbook%' THEN 'Inbook'
    WHEN Name LIKE '%GT Book%' THEN 'GT Book'
    
    ELSE 'Other'
END;


