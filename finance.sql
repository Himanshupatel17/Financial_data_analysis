 -- Find a total number of male and female with a age greater than 30.
SELECT gender,age, COUNT(*) AS count
    FROM finance_data
    WHERE age > 30
GROUP BY gender,age;

-- find a data of male who have governmnet bonds more than 5 and invest in stock market.
select *
from finance_data
where gender="male" and Government_Bonds>5 and Stock_Marktet="yes";


-- find a gender  with a unique age group. 
select distinct(age),gender
from finance_data
group by age,gender;


-- What is the average investment in Mutual Funds across different age groups
SELECT 
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    round(avg(Expect), 2) AS avg_investment
FROM finance_data
GROUP BY age
ORDER BY avg_investment DESC;
    
-- What is the count of investors by gender.
select count(*) as total,gender
from finance_data
group by gender;

-- 	What is the age distribution of investors.
select age as age_distribution,count(*) as total
from finance_data
group by age_distribution;

-- What are the preferred investment avenues among different age groups
select age,Avenue
from finance_data
group by Avenue,age
order by age desc;

-- How does gender influence investment preferences
select gender,source
from finance_data
group by gender,Source;

-- What is the most popular investment avenue overall
SELECT Avenue, COUNT(*) AS popularity
FROM finance_data
GROUP BY Avenue
ORDER BY popularity DESC
LIMIT 1;

-- How many investors have invested in both Mutual Funds and Equity Market
SELECT gender, COUNT(*) as total_investors
FROM finance_data
WHERE Avenue IN ('Mutual_Funds', 'Equity')
GROUP BY gender;

-- What is the most common reason investors choose Bonds over Equity
SELECT Reason_Bonds, COUNT(*) AS frequency
FROM finance_data
WHERE Reason_Bonds IS NOT NULL 
GROUP BY Reason_Bonds
ORDER BY frequency DESC
LIMIT 1;

-- What percentage of investors have chosen Gold as an investment
SELECT 
    (COUNT(CASE WHEN Gold > 0 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_gold_investors
FROM finance_data;

-- Which investment avenue has the highest number of long-term investors
select avenue,duration
from finance_data
where duration ="more than 5 years"
group by avenue,duration;

-- What is the most common savings objective among investors
SELECT `What are your savings objectives?` AS Savings_Objective, COUNT(*) AS count
FROM finance_data
GROUP BY `What are your savings objectives?`
ORDER BY count DESC
LIMIT 1;

-- How many investors focus on "Wealth Creation" as their primary financial goal
select purpose, count(*) as primaryfocus
from finance_data
where Purpose ="wealth creation";

-- How many investors prioritize "Safe Investment" over "High Returns
SELECT 
    SUM(CASE WHEN `Avenue` = 'Mutual Fund' THEN 1 ELSE 0 END) AS Safe_Investment_Count,
    SUM(CASE WHEN `Avenue` = 'Equity' THEN 1 ELSE 0 END) AS High_Returns_Count
FROM finance_data;

-- What percentage of investors consider "Tax Benefits" when choosing an investment
SELECT 
    (COUNT(CASE WHEN Reason_Mutual = "tax benefits" THEN 1 END) * 100.0 / COUNT(*)) AS benefits
FROM finance_data;

-- How many investors prefer Fixed Deposits for stability and low risk?
select Reason_FD,count(*)
from finance_data
where Reason_FD="fixed returns";

-- What is the most common frequency of investment monitoring? (Daily, Weekly, Monthly)
select Invest_Monitor, count(*) as total
from finance_data
group by Invest_Monitor
order by total desc;

-- How many investors expect returns between 20%-30%?
select expect,count(*) as expected_return
from finance_data
where expect ='20%-30%';

-- What is the most common expected return range (10%-20%, 20%-30%, 30%+)
select expect,count(*) as returnrange
from finance_data
group by Expect
order by returnrange desc
limit 1;

-- What are the most common sources of financial information among investors
select source,count(*) as finance_count
from finance_data
group by source 
order by finance_count desc
limit 1;

-- Do investors who consult financial advisors prefer safer investments (FD, Bonds) over riskier ones (Equity, Mutual Funds)?
SELECT 'source', 
    SUM(CASE WHEN `Reason_FD` = "fixed returns" OR `Reason_Bonds` = "safe investment" THEN 1  ELSE 0 END) AS Safe_Investments,
    SUM(CASE WHEN `Reason_Equity` = "Dividend" OR `Reason_Mutual` = "better returns" THEN 1  ELSE 0 END) AS Risky_Investments
FROM finance_data
where Source="Financial Consultants"
GROUP BY 'source';

