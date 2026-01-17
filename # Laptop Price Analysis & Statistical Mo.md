# Laptop Price Analysis & Statistical Modeling

This project involves the end-to-end processing of a semi-structured laptop dataset. The workflow covers data extraction via SQL, descriptive exploratory data analysis (EDA), inferential statistical testing, and price prediction modeling.

## Project Structure

* **`priceoye_laptops_version_2.csv`**: The primary dataset containing laptop names, prices, ratings, and specifications.
* **`DescribingStatisticLaptopPrice.ipynb`**: Focuses on data cleaning, ETL processes, and descriptive statistics.
* **`InferentialStatisticLaptopPrice.ipynb`**: Covers hypothesis testing, correlation analysis, and the development of a predictive regression model.
* **`Laptop-Price-EDA-and-Result-Report.pdf`**: A comprehensive final report detailing the methodology, findings, and strategic recommendations.

## Key Features & Methodology

### 1. Data Engineering (SQL & Python)
Since the raw data was semi-structured (hardware specs embedded within strings), feature engineering was performed using **SQL** to extract:
* `Brand`, `Core` (Processor), `SSD`, `RAM`, and `Model`.
* Numerical cleaning for `Actual_Price` and `Discounted_Price`.

### 2. Descriptive Statistics (EDA)
* **Distribution Analysis:** Leveraged `describe()` functions and visualizations (Box plots, Histograms) to identify outliers and central tendencies.
* **Market Insights:** Observed that HP and Lenovo dominate the market volume, while Intel remains the most prevalent processor brand.
* **Feature Correlation:** Identified that while Reviews and Ratings show limited correlation with price, hardware specs like RAM and SSD are primary drivers.

### 3. Inferential Statistics
* **Normality Testing:** Kolmogorov-Smirnov tests confirmed non-normal distribution, leading to the use of non-parametric tests (Spearman correlation).
* **Hypothesis Testing:** Conducted a **Z-test** comparing `Actual_Price` vs. `Discounted_Price`, revealing statistically significant differences in pricing strategies.
* **Independence Tests:** Chi-square tests were used to evaluate the independence between brands and hardware configurations.

### 4. Predictive Modeling
* **Linear Regression:** Developed a multiple regression model to predict laptop prices based on extracted hardware features.
* **Performance:** The model achieved a high **R-squared ($R^2$) value of 0.956**, indicating that hardware specifications explain approximately 95.6% of the price variance.

## Major Findings

* **Brand Equity vs. Hardware:** For most brands, price is strictly tied to hardware. However, **Apple** and **Lenovo** exhibit pricing behaviors influenced by brand equity and market dominance that go beyond mere hardware specs.
* **Consumer Trends:** There is a clear consumer preference for high RAM (16GB+) and SSD (512GB+) capacities. Processor choices are often driven by "perceived tiers" (e.g., i7 vs i5) rather than just raw performance metrics.
* **Strategic Recommendations:** The report suggests optimizing profit margins on high-recognition products while using deep discounts on entry-level hardware to drive volume.

## Technologies Used

* **Languages:** Python (Pandas, NumPy, SciPy, Statsmodels), SQL
* **Visualization:** Matplotlib, Seaborn
* **Environment:** Jupyter Notebook
* **Documentation:** Adobe PDF (Final Report)