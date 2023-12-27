**Please if you find a mistake or a suggestion please contact me at : juanfieecs@gmail.com**

## Table of Contents

  - [Project Overview](#project-overview)
  - [Data Sources](#data-sources)
  - [Recommendations](#recommendations)

### Project Overview
---

This project provide key information and evidence from data about the existence of sticky floor and glass ceiling in the laboral market in Peru. Likewise, the gender wage gap is calculated vía statistic modelling. 

### Data Sources

Laboral Market Data: The principal dataset is extracted from the Peruvian National Household Survey (ENAHO) published by the National Statistic Institute (INEI) every year. This project will use the Module 5 of ENAHO datasets.

Anyone can review the files via this link: https://proyectos.inei.gob.pe/microdatos/

Also the data is available in the folder 'data' in this project.

### Tools

 - Stata: Data Cleaning/Preparation
 - Python: EDA and Modelling

### Data Cleaning/Preparation

In the initial data preparation phase, we performed the following tasks:
1. Data loading and inspection.
2. Calculating and labeling new variables.
3. Data cleaning and formatting.

### Exploratory Data Analysis

EDA involved exploring the data to answer some questions, such as:

- Does men/women work more hours per week than women/men?
- There are big differences among education level between genders?

Also, EDA provides evidence of null and outliers presence. Specifically, null data in salaries data is around 60%. 
The treatment was just dropping. Other treatment can be estimation in two steps. 

### Statistic Modelling

The salary model is:

![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/faea4847-5f06-4bbf-b209-f3f95a763a43)

Being:

- **año**
- **horas**: Worked hours per week
- **edad**: Years old
- **salario**: Monthly nominal wage in soles (net salary after taxes and other concepts)
- **fac500a**: Expansion factor
- **urbano**: Urban or rural area indicator
- **hombre**: Gender indicator
- **escolaridad**: education level
- **formal**: Formal or informal job indicator
- **logsal**: Logarithm of salary
- **edadsq**: Age squared

### Results/Findings

1. It's easy to prove that **there is correlation between salary with the worked hours per week and the age** (numeric variables). 

![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/745560f9-d126-4463-83f4-e5d636b33ee9)
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/1227db7d-fa7a-40e7-942e-8f4075f39683)

2. On the other hand, non numeric variables shows differences in their distribution among their values. In other words, **the gender, formal labor and the zone is important to classify salary data**.

![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/bef450c8-bfef-4b21-8b04-735024c58f57)
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/50f65a3f-26c5-4b3a-be43-be4931dc3495)
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/85b688fe-559d-4912-ae66-edf20c17883c)

3. Across gender and the other categorical variables. The unique which shows a possible significant difference in their values is the education level. **There are more man in mid and high level of education**. Just in the category who people don't have the minimun education (In Perú: Educación Básica Regular) there are more women.

![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/ad96393c-ce8d-4670-823e-ee89ca8b4a4d)

4. WLS Regression show that at 49 years your aditional age (as a proxy of labour experience) have no impact in salaries:
 
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/2a626e05-da18-4693-be9c-8a74f61e8fe4)
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/d0c2ef89-6309-4f53-9610-4df312269078)

As you can see in the previous image. In average, **the wage gender gap was around 27% in 2022**. 

6. Now, quantile regression can give more information about this. The next plot shows values of wage gender gap across the salary distribution. The gender wage gap is not a flat variable. The graph shows that the larger the salary of the analysis group, the larger the gender wage gap is.
   
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/7dc3706d-4c50-4428-a285-a159888c7e68)

In conclusion. The study proves the existence of Glass Ceiling. There is no evidence of Sticky Floor.

### Recommendations

- In next studies you can include a variable of ocupation (p505 or p505r4). In this studie this is not considered because there are too categories and there are few data for each category. Maybe it's possible to classify by sector but there is not supported by ILO or MTPE.
- ENAHO is a survey that doesn't have as a sampling frame the economically active population (that is the reason for the script in STATA in resources). So, if it's possible try to use other data to replicate this study

**THANKS FOR READING!**


