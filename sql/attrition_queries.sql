-- ============================================================================
-- HR ATTRITION ANALYSIS - SQL QUERIES
-- Purpose: Extract and segment employee data for attrition analysis
-- Database: PostgreSQL (or SQLite for local analysis)
-- Author: Usman Ghani Khan
-- ============================================================================

-- ============================================================================
-- QUERY 1: Overall Attrition Rate and Department Breakdown
-- ============================================================================

SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(Attrition) AS Attrition_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent,
    ROUND(AVG(MonthlyIncome), 0) AS Avg_Monthly_Income
FROM employees
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;

-- Expected Output: Attrition rates by department
-- Business Value: Identifies which departments have highest turnover


-- ============================================================================
-- QUERY 2: Attrition by Tenure (Years at Company)
-- Segments employees into tenure groups to identify retention patterns
-- ============================================================================

WITH TenureGroups AS (
    SELECT 
        CASE 
            WHEN YearsAtCompany < 2 THEN '0-2 years'
            WHEN YearsAtCompany < 5 THEN '2-5 years'
            WHEN YearsAtCompany < 10 THEN '5-10 years'
            ELSE '10+ years'
        END AS Tenure_Group,
        Attrition
    FROM employees
)
SELECT 
    Tenure_Group,
    COUNT(*) AS Total_Employees,
    SUM(Attrition) AS Attrition_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent
FROM TenureGroups
GROUP BY Tenure_Group
ORDER BY 
    CASE 
        WHEN Tenure_Group = '0-2 years' THEN 1
        WHEN Tenure_Group = '2-5 years' THEN 2
        WHEN Tenure_Group = '5-10 years' THEN 3
        ELSE 4
    END;

-- Expected Output: Attrition rates by tenure category
-- Business Value: Identifies if new hires are at higher risk


-- ============================================================================
-- QUERY 3: High-Risk Segment Identification
-- Employees with multiple risk factors: overtime + low satisfaction + low tenure
-- ============================================================================

SELECT 
    Department,
    JobRole,
    COUNT(*) AS Employee_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent,
    ROUND(AVG(MonthlyIncome), 0) AS Avg_Income
FROM employees
WHERE OverTime = 'Yes'
  AND JobSatisfaction <= 2
  AND YearsAtCompany < 3
GROUP BY Department, JobRole
HAVING COUNT(*) >= 5  -- Only segments with meaningful sample size
ORDER BY Attrition_Rate_Percent DESC;

-- Expected Output: High-risk employee segments
-- Business Value: Targets retention efforts on vulnerable groups


-- ============================================================================
-- QUERY 4: Attrition by Job Satisfaction and Work-Life Balance
-- Cross-tabulation to understand satisfaction impact
-- ============================================================================

SELECT 
    JobSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(Attrition) AS Attrition_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent
FROM employees
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- Expected Output: Attrition rates by satisfaction level (1-4 scale)
-- Business Value: Quantifies impact of satisfaction on retention


-- ============================================================================
-- QUERY 5: Overtime Impact Analysis
-- ============================================================================

SELECT 
    OverTime,
    COUNT(*) AS Total_Employees,
    SUM(Attrition) AS Attrition_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent,
    ROUND(AVG(YearsAtCompany), 1) AS Avg_Tenure_Years
FROM employees
GROUP BY OverTime
ORDER BY Attrition_Rate_Percent DESC;

-- Expected Output: Overtime vs non-overtime attrition comparison
-- Business Value: Measures overtime's impact on turnover


-- ============================================================================
-- QUERY 6: Income Bracket Analysis
-- Segments employees by income to identify if compensation affects attrition
-- ============================================================================

WITH IncomeBrackets AS (
    SELECT 
        CASE 
            WHEN MonthlyIncome < 3000 THEN 'Low (<$3K)'
            WHEN MonthlyIncome < 6000 THEN 'Medium ($3-6K)'
            WHEN MonthlyIncome < 10000 THEN 'High ($6-10K)'
            ELSE 'Very High (>$10K)'
        END AS Income_Bracket,
        Attrition
    FROM employees
)
SELECT 
    Income_Bracket,
    COUNT(*) AS Total_Employees,
    SUM(Attrition) AS Attrition_Count,
    ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent
FROM IncomeBrackets
GROUP BY Income_Bracket
ORDER BY 
    CASE 
        WHEN Income_Bracket = 'Low (<$3K)' THEN 1
        WHEN Income_Bracket = 'Medium ($3-6K)' THEN 2
        WHEN Income_Bracket = 'High ($6-10K)' THEN 3
        ELSE 4
    END;

-- Expected Output: Attrition rates by income level
-- Business Value: Informs compensation strategy


-- ============================================================================
-- QUERY 7: Business Impact Calculation
-- Calculate cost of attrition and potential savings
-- ============================================================================

WITH attrition_summary AS (
    SELECT 
        COUNT(*) AS total_employees,
        SUM(Attrition) AS total_attrition,
        ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS attrition_rate
    FROM employees
)
SELECT 
    total_employees,
    total_attrition,
    attrition_rate AS current_attrition_rate_percent,
    total_attrition * 50000 AS current_replacement_cost_dollars,
    -- Projected 30% improvement scenario
    ROUND(total_attrition * 0.30, 0) AS potential_retention_count,
    ROUND(total_attrition * 0.30 * 50000, 0) AS potential_annual_savings_dollars,
    ROUND(attrition_rate * 0.70, 2) AS projected_new_attrition_rate_percent
FROM attrition_summary;

-- Expected Output: Current cost and projected savings from retention improvements
-- Business Value: Builds ROI case for retention programs


-- ============================================================================
-- EXPORT QUERY: Complete dataset for Excel pivot tables
-- This query prepares clean data for Excel analysis
-- ============================================================================

SELECT 
    EmployeeNumber,
    Department,
    JobRole,
    YearsAtCompany,
    CASE 
        WHEN YearsAtCompany < 2 THEN '0-2 years'
        WHEN YearsAtCompany < 5 THEN '2-5 years'
        WHEN YearsAtCompany < 10 THEN '5-10 years'
        ELSE '10+ years'
    END AS Tenure_Category,
    MonthlyIncome,
    CASE 
        WHEN MonthlyIncome < 3000 THEN 'Low'
        WHEN MonthlyIncome < 6000 THEN 'Medium'
        WHEN MonthlyIncome < 10000 THEN 'High'
        ELSE 'Very High'
    END AS Income_Category,
    OverTime,
    JobSatisfaction,
    WorkLifeBalance,
    Attrition
FROM employees
ORDER BY Department, JobRole;

-- Expected Output: Clean dataset with calculated categories for Excel pivot analysis
-- Usage: Export this to CSV, import to Excel, create pivot tables
