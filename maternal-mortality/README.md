# Black Maternal Mortality & Health Inequities in the United States  
### A Data Science & Public Health Analysis by Monchelle Davis

---

## 📌 Project Overview

Black History Month is not only a time to honor the past — it is a moment to confront the inequities that persist today. This project examines **Black maternal mortality**, **life expectancy**, and **health outcomes** in the United States using authoritative public health data. 

Despite advances in civil rights and medical technology, Black women continue to face disproportionately high risks during pregnancy and childbirth. This dashboard visualizes these disparities and connects them to broader patterns in life expectancy and health outcomes.

The goal is to create a **public, accessible, data‑driven narrative** that highlights the ongoing cost of racial inequity in healthcare.

---

## 🎯 Key Questions

- How do maternal mortality rates differ by race in the United States?
- How has Black maternal mortality changed over time?
- Which states show the highest disparities?
- Is there any link between poverty rates and maternal mortality rates?
- What does the future of maternal mortality look like?

---

## 🩺 Data Sources

This project uses publicly available, authoritative datasets:

### **CDC WONDER – Multiple Cause of Death (Final)**
- Mortality data by race, year, state  
- ICD‑10 codes **O00–O99** (pregnancy, childbirth, and the puerperium)  
- Population counts and crude/age‑adjusted mortality rates  

### **CDC National Vital Statistics System (NVSS)**
- Annual maternal mortality reports  
- Race‑stratified mortality trends  

### **NCHS Life Expectancy Tables**
- Life expectancy by race and gender  
- Historical trends  

### **US Census Bureau**
- Poverty rates by year and race

All  data files are stored in the `/data/` directory.

---

## 🧼 Data Cleaning & Processing (Python)

All preprocessing was performed in Python using pandas.  
The cleaning workflow includes:

- Removing WONDER footnotes and non‑data rows  
- Standardizing column names  
- Converting numeric fields  
- Handling suppressed or unreliable values  
- Filtering ICD‑10 codes **O00–O99** for maternal mortality  
- Exporting clean CSVs for Tableau

The full cleaning notebook is available in:

/notebooks/inspect-and-clean.ipynb

The exploration workflow includes:

- Various preliminary visualizations of maternal mortality
- Various preliminary visualizations of povery rates
- Manipulation of both datasets to join them
- Examination of the correlations between race, poverty rates, and maternal mortality

The full exploration notebook is available in:

/notebooks/explore.ipynb

Images of the visualizations are found in:

/data/images


---

## 📊 Tableau Dashboard

The interactive dashboard visualizes:

### **The Cost of Being Black While Giving Birth**
- Maternal mortality rates by race  
- Trend lines from 1999–2022  
- State‑level disparities  
- Crude vs. age‑adjusted rates  


**View the live dashboard:**  
👉 [Here](https://public.tableau.com/app/profile/monchelle.davis/viz/USMMRStudy/Dashboard1)

---

## 📁 Repository Structure
project-root/ <br>
│<br>
├── data/ <br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── Underlying Cause of Death, 1999-2020.csv <br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── poverty-rates.csv <br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── cleaned_maternal_mortality.csv<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── mmr_linear_forecast.csv<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── mmr_polynomial_forecast.csv<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── images/<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── mmr-by-state.png<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── poverty-rate-by-race.png<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── scatterplot-mmr-poverty-race.png<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── scatterplot-mmr-poverty.png<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── trendline-by-race.png<br>
│<br>
├── notebooks/<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── inspect-and-clean.ipynb<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── explore.ipynb<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── forecast.ipynb<br>
│<br>
├── tableau/<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── dashboard_images/<br>
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── dashboard.twb<br>
│<br>
└── README.md<br>


---

## 🧠 Skills Demonstrated

- Public health data analysis  
- Python data cleaning (pandas, NumPy)  
- Exploratory data analysis  
- Tableau dashboard design  
- Data storytelling  
- Reproducible project structure  
- Working with federal mortality datasets  
- Communicating complex inequities through data  

---

## 📣 Why This Matters

Black maternal mortality is not a medical inevitability — it is a reflection of structural inequity.  
This project uses data to illuminate a crisis that is both preventable and urgent. By connecting historical context to present‑day outcomes, the dashboard aims to support advocacy, awareness, and informed public health action.

---

## ✨ About the Author

**Monchelle Davis**  
Data Scientist (in training) • Public Health Advocate • STEM Equity Champion  
Master’s in Data Science (WGU) • 2LEDA Leadership Fellow  

This project is part of a broader portfolio focused on using data science to address inequities in Black communities.
