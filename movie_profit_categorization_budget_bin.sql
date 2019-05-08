create or replace view movies_database.profitability_view as
/* Categorize movie profitibility based on budget < 100000 */
SELECT 
    movie_id,
    budget,
    Revenue,
    ProfitabilityPct,
    CASE
        WHEN ProfitabilityPct > 0 THEN '1'
        ELSE '0'
    END AS budgetCategory
FROM
    (SELECT 
        movie_id,
            budget,
            Revenue,
            (Revenue - Budget) / Budget * 100 AS ProfitabilityPct
    FROM
        movies_database.movies_finance
    WHERE
        budget < 100000) A

union
/* Categorize movie profitibility based on budget between  100001 and 10000000 */
SELECT 
    movie_id,
    budget,
    Revenue,
    ProfitabilityPct,
    CASE
        WHEN ProfitabilityPct > 0 THEN '1'
        ELSE '0'
    END AS budgetCategory
FROM
    (SELECT 
        movie_id,
            budget,
            Revenue,
            (Revenue - Budget) / Budget * 100 AS ProfitabilityPct
    FROM
        movies_database.movies_finance
    WHERE
        budget between 100001 and 10000000) A
union
/* Categorize movie profitibility based on budget > 10000000 */
SELECT 
    movie_id,
    budget,
    Revenue,
    ProfitabilityPct,
   
    CASE
        WHEN ProfitabilityPct > 0 THEN '1'
        ELSE '0'
    END AS budgetCategory
FROM
    (SELECT 
        movie_id,
            budget,
            Revenue,
            (Revenue - Budget) / Budget * 100 AS ProfitabilityPct
    FROM
        movies_database.movies_finance
    WHERE
        budget > 10000000) A;
        
select movie_id,budget,Revenue,ProfitabilityPct,budgetCategory from movies_database.profitability_view;

select movie_id,
ProfitabilityPct,
budget,
CASE 
	WHEN budget < 100000 THEN '0'
    WHEN budget between 100001 and 10000000 THEN '1'
    Else  '2'
    END AS 'budgetbin'
,budgetCategory as 'Profitable'
    from movies_database.profitability_view;