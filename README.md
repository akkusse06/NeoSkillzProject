
# Credit Risk Analysis & Prediction Dashboard

An end-to-end data analytics and machine learning project designed to identify, assess, and predict loan defaults. This repository demonstrates a complete data workflow: using **SQL** for robust data preprocessing and cleaning, training multiple **Machine Learning** models to predict credit risk, and building a high-fidelity **Power BI** dashboard to surface key business portfolio insights.

---

## 📌 Project Overview

Credit risk is one of the most critical challenges faced by financial institutions. This project analyzes a dataset containing over **32,500 client records** across 29 features—encompassing demographics, credit history, loan characteristics, and calculated financial ratios—to determine the probability of a client defaulting on a loan.

### Key Insights & Findings

* **Target Variable:** `loan_status` (0 = Non-Default, 1 = Default) with a baseline default rate of **21.82%**.
* **High-Risk Triggers:** Higher default rates strongly correlate with a **Debt-to-Income (DTI) ratio exceeding 60%**, weaker credit grades (**D through G**), and shorter overall credit tenures.
* **Top Predictive Model:** The **Random Forest Classifier** outperformed all other models, achieving a peak validation accuracy of **92.46%**.

---

## 🛠️ Repository Architecture & Tech Stack

* **Database & Preprocessing:** Oracle SQL / PL-SQL
* **Machine Learning & Modeling:** Python (Pandas, NumPy, Scikit-Learn, Matplotlib)
* **Business Intelligence & Visualization:** Power BI Desktop

---

## 📂 File Directory & Contents

* 📁 `Credit_Risk_Data.csv` — Raw dataset containing client financials and loan information.
* 📁 `Data Dictionary.csv` — Reference mapping for all 29 feature columns.
* 📁 `Data Pre-Processing.sql` — SQL scripts utilized for data cleaning, handling missing variables, and removing outliers.
* 📁 `Machine Learning.ipynb` — Jupyter Notebook outlining feature engineering, pipeline building, hyperparameter tuning, and model evaluations.
* 📁 `Visualization.pdf` / `.pbix` — Multi-page interactive Power BI dashboard highlighting risk matrix metrics.
* 📁 `Project Report.pdf` — Formal technical report documenting findings, methodology, and comparative model analysis.

---

## 🚀 Step-by-Step Project Workflow

### 1. Data Cleaning & Pre-Processing (SQL)

To ensure high data quality before modeling, the raw dataset was rigorously cleaned using SQL scripts covering:

* **Missing Value Imputation:** Null values within `loan_int_rate` were logically filled by calculating the `AVG(loan_int_rate)` grouped specifically by the client's assigned `loan_grade`.
* **Outlier Removal:** Erroneous customer profiles (e.g., `person_age > 100`) were filtered out.
* **Feature Capping & Standardization:** Financial limits like `debt_to_income_ratio` were capped at `1.0` (100%) to maintain structural consistency.
* **Categorical Mapping:** Generated readable indicator extensions like `loan_status_desc` for reporting transparency.

### 2. Machine Learning Pipeline (Python)

We implemented and cross-verified four distinct predictive modeling techniques:

* **Logistic Regression & Linear Probability Models:** Served as foundational baselines, achieving ~86.91% and ~86.44% accuracy respectively.
* **Decision Tree Classifier:** Advanced the baseline accuracy to 90.36%.
* **Random Forest Classifier:** Successfully hyperparameter-tuned (`max_depth: None`, `min_samples_split: 5`, `n_estimators: 100`) to secure the highest performance:
* **Test Accuracy:** `92.46%`
* **5-Fold Cross-Validation Score:** `92.44%`


* **Feature Importance Insights:** Model breakdowns revealed that `LOAN_TO_INCOME_RATIO`, `LOAN_INT_RATE`, and `LOAN_PERCENT_INCOME` stand out as the strongest features when evaluating default probabilities.

### 3. Interactive Business Intelligence (Power BI)

A fully operational, two-page dashboard was built to visualize portfolio metrics:

* **Page 1: Loan Portfolio Overview**
* Tracks high-level KPIs: Total Loans issued ($312M across ~33K loans), total repaid capital vs. non-performing capital, and overall default percentages.
* Breaks down loan counts and distributions relative to Applicant Age, Gender, State/Province, and explicit Loan Intents (e.g., Education, Medical, Personal).


* **Page 2: Credit Risk Insights**
* Highlights high-DTI customer concentrations.
* Drill-down charts tracking Default Rate by Credit Tenure (showing peaks at 26–30 years tenure) and Default Rate by DTI Buckets (displaying a steep climb to a 74.32% default rate for the 81–100% DTI bucket).



---

## 📊 Performance Matrix Summary

| Machine Learning Model | Evaluation Accuracy |
| --- | --- |
| **Random Forest Classifier** | **92.46%** |
| Decision Tree Classifier | 90.36% |
| Logistic Regression | 86.91% |
| Linear Regression Baseline | 86.44% |

---
```


4. **Explore the Insights:** Open the Power BI workspace asset to interact with the visual analytical data graphs.
