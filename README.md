# 🧠 Mental Health Care During the COVID-19 Pandemic: A Data-Driven Analysis

## 📘 Overview
This repository contains the code, data references, and documentation for a research study titled **“Mental Health Care in the Last 4 Weeks”**, authored by **Vemunuri Gnaneshwar Reddy** at **George Mason University**.

The study examines the impact of the COVID-19 pandemic on mental health care access and outcomes across the United States using data from the **Household Pulse Survey** (August 2020 – May 2022). It explores how education, geography, age, and socioeconomic factors influenced mental health trends during this critical period.

---

## 🎯 Objectives

The analysis is driven by three primary research questions:

1. **📚 Education Influence**  
   How does educational attainment affect access to and outcomes of mental health care during the pandemic?

2. **📍 Geographical Variation**  
   How do U.S. states differ in access to mental health medications and therapy?

3. **👥 Age & Socioeconomic Impact**  
   What role do age and socioeconomic status play in mental health during the pandemic, especially for individuals aged 18–80?

---

## 📊 Dataset

- **Source**: [Household Pulse Survey – data.gov](https://www.data.gov/)
- **Period Covered**: August 19, 2020 – May 9, 2022
- **Collected By**: U.S. Census Bureau & National Center for Health Statistics
- **Key Variables**:  
  Employment, education, food security, housing, health disruptions, mental wellness indicators

---

## 🔧 Methodology

1. **Data Collection**  
   - Weekly survey data downloaded from [data.gov](https://www.data.gov/)
  
2. **Data Preprocessing**  
   - Missing values handled  
   - Irrelevant columns removed  
   - Data cleaned using **MySQL**

3. **Tools & Techniques**  
   - **AWS Glue DataBrew**: Summary statistics & cleaning  
   - **Linear Regression**: Modeling relationships  
   - **Feature Selection**: Correlation analysis, variance thresholding  

4. **Visualization Tools**  
   - Bar charts, line graphs, U.S. state maps, multi-panel plots  
   - Libraries used: `matplotlib`, `seaborn`, `plotly`

---

## 📈 Key Findings

- **Education**  
  Individuals with *some college* or *associate degrees* reported the **highest prevalence** of mental health concerns. Those with only a high school diploma or GED reported **lower incidence**.

- **Geography**  
  States in the **South and Southeast** had higher participation but lower access to mental health services—likely due to policy variation.

- **Age & Socioeconomic Status**  
  Young adults (18–30) reported significantly higher anxiety and depression levels. Older adults exhibited **better coping mechanisms**.

- **Model Performance**  
  Linear regression model showed excellent performance:  
  - **MSE**: 0.00546  
  - **RMSE**: 0.0739  
  - **MAE**: 0.0535  
  - **R²**: 0.9999

---

## 📁 Repository Structure

```
/mental-health-covid19-analysis
├── /data               # Raw and processed datasets (source linked)
├── /scripts            # SQL queries & Python analysis scripts
├── /visualizations     # Figures and graphs (FIG.1 – FIG.9)
├── /docs               # Research paper and supporting documents
│   └── Mental_Health_Care_in_the_Last_4_Weeks.pdf
├── README.md           # Project overview (this file)
└── requirements.txt    # Python and system dependencies
```

---



## 🚀 Usage

- Run SQL scripts in `/scripts` to preprocess and structure the dataset.
- Use Python scripts to run analysis and generate visualizations.
- Refer to `/docs` for the full research methodology and conclusions.

---

## ⚠️ Limitations

- The Household Pulse Survey is **experimental** and may lack depth compared to benchmark surveys like NHIS.
- The survey has a limited scope and may not capture **nuanced or long-term** mental health trends.

---

## 🔮 Future Work

- Incorporate additional mental health indicators and external datasets for deeper insights.
- Explore **machine learning models** (e.g., random forest, XGBoost) for predictive mental health analysis.
- Integrate **demographic and policy-level data** for contextual modeling.

---

## 📚 References

1. Son, C., et al. (2020). *Effects of COVID-19 on College Students' Mental Health*. *Journal of Medical Internet Research*.
2. McBain, R. K., et al. (2021). *Transforming Mental Health Care in the United States*. *RAND Corporation*.
3. Panchal, N., & Saunders, H. (2023). *The Implications of COVID-19 for Mental Health and Substance Use*. *KFF*.
4. U.S. Census Bureau. *[Household Pulse Survey](https://www.census.gov/programs-surveys/household-pulse-survey.html)*.

---

## 👨‍💻 Author

**Vemunuri Gnaneshwar Reddy**  
George Mason University  
*Data Analytics & Engineering*

