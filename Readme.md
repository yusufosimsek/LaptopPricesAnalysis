# 💻 Laptop Price Analysis
 
An end-to-end data science pipeline applied to a laptop pricing dataset sourced from Kaggle. The project covers descriptive statistics, inferential statistics, and regression modelling to identify the key determinants of laptop prices, with results operationalised through a Power BI dashboard and a comprehensive statistical report.
 
---
 
## 📁 Project Structure
 
```
LaptopPriceAnalysis/
│
├── Analysis/
│   ├── 00_Database_Connection_Configuration.ipynb
│   ├── 01_DescribingStatisticLaptopPrice.ipynb
│   ├── 02_InferentialStatisticLaptopPrice.ipynb
│   ├── 03_RegressionModels.ipynb
│   ├── 04_PowerBIDashboardExport.ipynb
│   └── master_laptop_data.pkl
│
├── Datas/
│   ├── priceoye_laptops_version_2.csv      ← Raw data (Kaggle)
│   ├── LaptopPriceAnalysisFinal.csv
│   ├── laptop_dashboard.csv                ← Power BI data source
│   ├── SQLQuery1.sql
│   ├── SQLQuery2.sql
│   └── model_parity_plot.png
│
├── EDA and Result/
│   └── Laptop-Price-EDA-and-Result-Report.pdf
│
├── Report/
│   ├── LaptopPriceAnalysisDashboard.pbix
│   └── FinalReport.pdf
│
└── README.md
```
 
---
 
## 🔄 Pipeline Architecture
 
```
Kaggle CSV
    ↓
SQL Server (LocalDB)
Feature engineering — parsing hardware specs from raw text fields
    ↓
Python — 00_Database_Connection_Configuration.ipynb
Connection, data retrieval, categorical standardisation, pickle export
    ↓
Python — 01 / 02 / 03 Notebooks
Descriptive statistics → Inferential statistics → Regression modelling
    ↓
Python — 04_PowerBIDashboardExport.ipynb
Variable type validation, CSV export
    ↓
Power BI
Interactive dashboard
    ↓
PDF Report
```
 
---
 
## 📊 Analysis Stages
 
### 00 — Database Connection & Data Preparation
The raw dataset was sourced from Kaggle and loaded into SQL Server (LocalDB). SQL queries were used to parse hardware specifications (brand, series, processor, RAM, SSD, storage) that were originally compressed into a single text field, decomposing them into structured relational columns. Data manipulations that could not be completed at the SQL level were handled in Python using NumPy. The cleaned dataset was saved as `master_laptop_data.pkl`, serving as the shared data source for all subsequent notebooks.
 
### 01 — Descriptive Statistics
Four numeric variables (Actual_Price, Discounted_Price, Rating, Reviews) and seven categorical variables (Brand, Core, SSD, Series, Processor, RAM, Storage) were examined.
 
- **Rating & Reviews:** No meaningful relationship with price was identified through visual or statistical analysis. Both variables were excluded from the modelling stage.
- **Price distributions:** Right-skewness was visually observed in both Actual_Price and Discounted_Price. Given the sample size (n ≈ 306), the Shapiro-Wilk test was selected for normality assessment — normality was rejected for both variables. Levene's test confirmed variance homogeneity between the two price variables.
- **Categorical variables:** SSD, RAM, and Storage were treated as categorical variables rather than continuous quantities, as their values increase exponentially rather than linearly. Chi-square tests were used to examine dependency structures among categorical variables. PERMANOVA — a non-parametric test requiring no distributional assumptions — was applied to assess categorical-numeric relationships, with effect sizes evaluated accordingly.
- **Numeric relationships:** Spearman correlation was used to examine associations among numeric variables.
### 02 — Inferential Statistics
- **Mann-Whitney U and Wilcoxon tests** were applied to assess whether numeric variable pairs share a common distribution and whether their rank orderings are non-random.
- Actual_Price and Discounted_Price were found to share the same rank structure via the Wilcoxon test. Rating and Reviews showed no significant association either with each other or with the price variables — a finding that directly informed subsequent modelling decisions.
- **Bootstrap resampling** (N = 10,000 iterations, 95% confidence level) was used to compute point estimates and confidence intervals for both price variables.
### 03 — Regression Modelling
The modelling stage began with a **literature review**, which identified two candidate approaches:
 
- **GAM (Generalised Additive Model):** Considered for its capacity to explain a non-parametric dependent variable using multiple independent categorical variables through flexible smooth terms, without requiring linearity assumptions. GAM was applied independently to the raw, untransformed Actual_Price to evaluate whether it could produce meaningful results.
- **Hedonic Regression:** Adopted as the primary modelling framework, as it is the most appropriate method for estimating the marginal contribution of product attributes to price in a pricing strategy context.
To satisfy OLS distributional assumptions, three transformations were evaluated sequentially: **Log → Box-Cox → Yeo-Johnson**. The objective was approximate normality rather than strict normality. Although neither Box-Cox nor Yeo-Johnson passed the Shapiro-Wilk test, both produced visually adequate Q-Q plots. Yeo-Johnson demonstrated marginally better distributional balance and was selected, with the acknowledged trade-off that its back-transformation would introduce additional complexity.
 
Post-transformation, ANOVA and Pearson correlation were used to verify consistency with the inferential statistics findings. **Partial eta-squared (adjusted)** was used as the effect size measure, as it yields more reliable estimates than Cohen's d for transformed variables.
 
Given the confirmed rank equivalence of Actual_Price and Discounted_Price (Wilcoxon test), only one price variable was entered into the model. **Actual_Price** was selected as the dependent variable due to its continuity and representational primacy.
 
Seven hedonic OLS specifications were tested. While several achieved high R² values, most suffered from severe multicollinearity (high VIF) or coefficient instability. The final model — **RAM + Core + Brand → YJ_Actual** (Adj. R² ≈ 0.506) — was selected as the specification offering the best balance between explanatory power and multicollinearity control.
 
**Back-transformation** (inverse Yeo-Johnson) was then applied to convert predictions back to the original price scale, and model performance was verified through a parity plot.
 
### 04 — Power BI Dashboard Export
Variable types were validated and the cleaned dataset was exported as `laptop_dashboard.csv`. This file was used as the data source for the Power BI dashboard.
 
---
 
## 📌 Key Findings
 
- RAM tier and CPU tier are the strongest hardware determinants of price. The step from 4GB to 32GB RAM produces the largest single coefficient increase in the final model.
- Brand exerts a statistically significant and independent effect on price — particularly Lenovo and HP — beyond what hardware specifications alone can explain.
- SSD capacity shows a large univariate effect size but could not be retained in the final model due to structural multicollinearity with Core and RAM.
- Rating and Reviews carry no pricing signal and were excluded from the modelling pipeline entirely.
- The GAM model achieved a pseudo R² of approximately 0.63 on the raw price data, confirming its capacity to produce meaningful results under a non-parametric specification.
- The final hedonic model explains approximately 50% of price variance (Adj. R² ≈ 0.506). The unexplained portion is primarily attributable to variables absent from the dataset — screen resolution, GPU tier, battery capacity, and weight.
- **SSD, RAM, and CPU do not behave as independent components — they form a bundled structure that moves together.** High SSD capacity systematically co-occurs with more RAM and a more powerful CPU, which is the primary source of multicollinearity in the joint model. That said, CPU retains partial independence from SSD and RAM because it spans multiple manufacturers (Intel, AMD/Ryzen) and cannot be reduced to a single vendor's product line. This bundling structure points to a clear **customer typology pattern**: purchasing decisions appear to be driven by heuristic, package-oriented logic — "high SSD = good laptop" — rather than informed component-level selection. This is a behavioural inference drawn from a model with ~0.50 explanatory power and should be interpreted accordingly.
---
 
## ⚙️ Tech Stack
 
| Layer | Tool / Library |
|---|---|
| Database | SQL Server (LocalDB), pyodbc |
| Data processing | Python, pandas, NumPy |
| Statistics | scipy, statsmodels, scikit-learn |
| Non-parametric regression | pygam |
| Visualisation | matplotlib, seaborn |
| Dashboard | Power BI |
| Reporting | PDF |
 
---
 
## 🚀 How to Run
 
1. Execute `Datas/SQLQuery1.sql` and `SQLQuery2.sql` on SQL Server (LocalDB) to create the `LaptopPriceAnalysis` database.
2. Run the notebooks in order:
   ```
   00 → 01 → 02 → 03 → 04
   ```
3. Running notebook `00` generates `master_laptop_data.pkl`. All subsequent notebooks use this file as their data source.
4. After running notebook `04`, connect the generated `laptop_dashboard.csv` to Power BI as the data source.
**Required Python libraries:**
```
pandas, numpy, scipy, statsmodels, scikit-learn, pygam, matplotlib, seaborn, pyodbc
```
 
---
 
## ⚠️ Limitations
 
- The sample is small (n ≈ 306); estimates for smaller subgroups (Apple, Infinix, Ultra 9 tier) may be unstable.
- The dataset represents a single cross-section in time; pricing patterns shift with product refresh cycles.
- Key variables such as screen size/resolution, GPU, battery capacity, and weight are absent from the dataset and represent the primary source of unexplained variance.
---
 
## 📄 License
 
This project was developed as a sample analytical study. Data source: [Kaggle — Laptop Price Dataset](https://www.kaggle.com).