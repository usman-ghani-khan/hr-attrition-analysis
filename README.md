# HR Attrition Analytics Dashboard
## Employee Retention Analysis & Targeted Intervention Strategies

**Author:** Usman Ghani Khan  
**Tools:** SQL, Advanced Excel  
**Domain:** Human Resources Analytics, Workforce Planning  

---

## 📊 Business Problem

Employee attrition is costly. The average cost to replace an employee ranges from **$50,000 to $150,000** when accounting for recruitment, lost productivity, training costs, and institutional knowledge loss.

**Without data-driven insights**, HR teams struggle to:
- Identify which employees are at highest risk of leaving
- Understand root causes of turnover
- Prioritize retention interventions effectively
- Measure ROI of retention programs

---

## 🎯 Project Objectives

1. **Calculate attrition rates** across departments, roles, tenure, and demographics
2. **Identify high-risk employee segments** using SQL-based segmentation
3. **Determine key drivers** of attrition (satisfaction, compensation, work-life balance, career growth)
4. **Recommend targeted retention strategies** with projected cost savings and impact metrics

---

## 📁 Dataset

**Source:** Simulated HR dataset based on the [IBM HR Analytics Employee Attrition & Performance Dataset](https://www.kaggle.com/pavansubhasht/ibm-hr-analytics-attrition-dataset)  
**Description:** Enhanced employee data modeling realistic workforce patterns  
**Volume:** 1,470 employees, 22 attributes  

**Key Features:**
- Demographics: Age, Gender, Marital Status, Education
- Job Characteristics: Department, Role, Job Level, Years at Company
- Compensation: Monthly Income
- Satisfaction Metrics: Job Satisfaction, Work-Life Balance (1-4 scale)
- Work Factors: Overtime, Business Travel
- Target Variable: Attrition (0/1)

**Why enhanced data?**
The original IBM dataset is excellent for HR analytics research. This project uses a simulated enhancement to demonstrate:
- **SQL proficiency** - Complex queries, segmentation, business logic
- **Excel analysis skills** - Pivot tables, formulas, conditional formatting, charts
- **Business understanding** - Knowing what metrics drive retention decisions

All SQL queries and Excel techniques apply directly to real-world HR data.

---

## 🔍 Methodology

### 1. SQL-Based Data Extraction & Analysis (PRIMARY TOOL)

**All core analysis performed using SQL queries:**

**Query 1: Department Attrition Breakdown**
```sql
SELECT Department, COUNT(*) AS Total_Employees,
       SUM(Attrition) AS Attrition_Count,
       ROUND(100.0 * SUM(Attrition) / COUNT(*), 2) AS Attrition_Rate_Percent
FROM employees
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;
```

**Query 2: Tenure-Based Segmentation**
- Used CASE statements to categorize employees into tenure groups (0-2, 2-5, 5-10, 10+ years)
- Identified that employees with <2 years tenure have **14.8% attrition** vs 8.5% for others

**Query 3: High-Risk Segment Identification**
- Multi-variable filtering: Overtime='Yes' AND JobSatisfaction<=2 AND YearsAtCompany<3
- Found segments with 20%+ attrition rates requiring intervention

**Query 4-6: Driver Analysis**
- Job Satisfaction impact (1-2 rating = 16% attrition vs 9.5% for rating 4)
- Overtime impact (17.4% attrition vs 10.2% for non-overtime)
- Income bracket analysis

**Query 7: Business Impact Modeling**
- Current replacement cost: $8.9M annually (178 employees × $50K)
- Projected 30% retention improvement: $2.65M savings

### 2. Excel Analysis (INTERACTIVE EXPLORATION)

**Excel Workbook: 3 Sheets**

**Sheet 1 - Employee Data:**
- Complete dataset (1,470 rows)
- Calculated fields: Tenure_Category, Income_Category
- Ready for pivot table creation

**Sheet 2 - Summary Metrics:**
- Key metrics with Excel formulas:
  - `=COUNTIF('Employee Data'!X:X,1)` → Total Attrition
  - `=COUNTIFS('Employee Data'!O:O,"Yes",'Employee Data'!X:X,1)` → Overtime Attrition
  - Demonstrates COUNTIF, COUNTIFS, AVERAGE functions

**Sheet 3 - Instructions:**
- Step-by-step guide for creating pivot tables
- Conditional formatting instructions
- Formula examples

**Excel Skills Demonstrated:**
- ✅ Pivot tables (Department × Attrition, Tenure × Attrition)
- ✅ COUNTIF/COUNTIFS formulas for segmentation
- ✅ Conditional formatting (highlight >15% attrition in red)
- ✅ Bar charts from pivot data

**Excel for interactive analysis:**
- Pivot tables for ad-hoc exploration
- What-if scenarios (change thresholds, see impact)
- Stakeholder-friendly (non-technical users can interact)
- Typical BI analyst workflow in most organizations

---

## 📈 Key Findings

### Overall Attrition: 12.11% (178 employees out of 1,470)

### Attrition by Department

| Department | Attrition Rate | Employees |
|-----------|----------------|-----------|
| Human Resources | 15.7% | 89 |
| Sales | 12.6% | 706 |
| Research & Development | 11.1% | 675 |

### Attrition by Tenure

| Tenure Group | Attrition Rate |
|-------------|----------------|
| 0-2 years | **14.8%** (high risk) |
| 2-5 years | 8.8% |
| 5-10 years | 8.5% |
| 10+ years | 13.6% |

**Insight:** New hires and very long-tenured employees both show elevated risk.

### Critical Risk Factor: Overtime

| Overtime Status | Attrition Rate | Delta |
|----------------|----------------|-------|
| **Yes** | **17.4%** | +70% |
| No | 10.2% | baseline |

**Employees working overtime are 70% more likely to leave.**

### Satisfaction Impact

| Job Satisfaction (1-4) | Attrition Rate |
|----------------------|----------------|
| 1 (Very Dissatisfied) | 16.0% |
| 2 (Dissatisfied) | 16.2% |
| 3 (Satisfied) | 10.6% |
| 4 (Very Satisfied) | 9.5% |

**Low satisfaction (1-2) increases attrition risk by 68%.**

---

## 💡 Recommended Retention Strategies

### Priority 1: Address Overtime-Related Attrition (HIGH IMPACT)

**Issue:** Overtime workers have 17.4% attrition vs 10.2% for non-overtime  
**Target:** 392 overtime employees  
**Actions:**
- Enforce overtime limits (max 5 hours/week)
- Hire additional capacity in overburdened departments
- Implement workload balancing with quarterly reviews

**Expected Impact:** 20% reduction in overtime-related attrition  
**Savings:** $680,000 annually

---

### Priority 2: New Hire Retention Program (HIGH IMPACT)

**Issue:** Employees with <2 years tenure have 14.8% attrition  
**Target:** 681 early-tenure employees  
**Actions:**
- Enhanced onboarding with 30-60-90 day manager check-ins
- Mentorship pairing for all new hires
- Quarterly "stay interviews" to address concerns proactively

**Expected Impact:** 25% reduction in first-year attrition  
**Savings:** $650,000 annually

---

### Priority 3: Satisfaction Pulse Surveys (ONGOING)

**Issue:** Low satisfaction (rating 1-2) correlates with 16% attrition  
**Target:** 510 low-satisfaction employees  
**Actions:**
- Quarterly pulse surveys to track satisfaction trends
- Manager coaching on engagement and recognition
- Peer-nominated employee recognition programs

**Expected Impact:** 30% improvement in low-satisfaction retention  
**Savings:** $800,000 annually

---

## 💰 Business Impact Summary

**Current State (Data-Driven):**
- Total attrition: 178 employees
- Attrition rate: 12.11%
- **Assumed** replacement cost: $50,000/employee (industry standard)
- Current annual cost: $8.9M

**Projected Scenario (If Interventions Succeed):**

| Metric | Current State | After Interventions | Improvement |
|--------|---------------|---------------------|-------------|
| Attrition Count | 178 employees | ~110 employees | **-68 employees** |
| Attrition Rate | 12.1% | ~7.5% | **-4.6 percentage points** |
| Annual Replacement Cost | $8.9M | ~$5.5M | **~$3.4M savings** |

**ROI Analysis (Scenario-Based):**  
- Estimated program cost: $400K (surveys, training, hiring, bonuses)
- Projected annual savings: ~$3.4M
- **Potential ROI: 850%** (8.5x return on investment)

**Key Assumptions:**
1. Replacement cost = $50,000 per employee (varies by role/seniority)
2. Intervention effectiveness rates: 20-30% improvement in targeted segments
3. Implementation quality and sustained commitment to programs
4. No external factors (economy, industry changes) impacting attrition

*These projections are scenario analyses to illustrate potential business value. Actual results will vary based on execution quality and organizational context.*

---

## 🛠️ Technical Implementation

### SQL Queries (`/sql/attrition_queries.sql`)
**7 comprehensive queries demonstrating:**
- Aggregations with GROUP BY
- CASE statements for segmentation
- CTEs (Common Table Expressions) for business impact modeling
- Statistical calculations (attrition rates, percentages)
- Multi-condition filtering (WHERE clauses)

### Excel Workbook (`/excel/HR_Attrition_Analysis.xlsx`)
**3-sheet workbook demonstrating:**
- Data preparation with calculated fields
- Summary metrics with COUNTIF/COUNTIFS/AVERAGE formulas
- Instructions for pivot table creation
- Conditional formatting for highlighting high-risk segments

### Repository Structure

```
hr-attrition-analysis/
├── README.md                        # This file
├── data/
│   └── hr_attrition_data.csv        # Employee dataset (1,470 records)
├── sql/
│   └── attrition_queries.sql        # 7 SQL queries (PRIMARY ANALYSIS)
├── excel/
│   └── HR_Attrition_Analysis.xlsx   # Excel workbook with pivot tables
└── results/
    ├── dept_attrition.csv           # SQL query output
    ├── tenure_attrition.csv         # SQL query output
    └── recommendations.csv          # Retention strategies
```

---

## 🎓 Skills Demonstrated

✅ **SQL:** Aggregations, GROUP BY, CASE statements, CTEs, WHERE filtering, percentage calculations  
✅ **Advanced Excel:** Pivot tables, COUNTIF/COUNTIFS, conditional formatting, data categorization, charts  
✅ **Data Segmentation:** Multi-variable filtering, cohort analysis, risk scoring  
✅ **Business Analysis:** Translating data insights into retention strategies, ROI modeling  
✅ **Stakeholder Communication:** Executive-level recommendations with cost-benefit analysis  

---

## 🚀 How to Use This Project

### For Interviewers/Reviewers:

1. **Review SQL queries** in `/sql/attrition_queries.sql` - shows analytical thinking
2. **Open Excel workbook** to see interactive pivot tables and formulas
3. **Read Key Findings** section for business insights

### For Replication:

1. SQL queries can be run on any database with employee attrition data
2. Excel workbook demonstrates standard BI analyst workflow
3. All techniques apply to real-world HR analytics

---

## 📞 Contact

**Usman Ghani Khan**
💼 [LinkedIn](https://linkedin.com/in/usman-ghani-k)  
🔗 [GitHub](https://github.com/usman-ghani-khan)

---

## 📄 License

This project uses a simulated dataset based on the publicly available IBM HR Analytics dataset from Kaggle.  
Analysis code and documentation are original work by Usman Ghani Khan.
