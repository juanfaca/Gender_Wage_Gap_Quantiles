## Table of Contents

  - [Project Overview](#project-overview)
  - [Data Sources](#data-sources)
  - [Recommendations](#recommendations)

### Project Overview
---

This project provide key information and evidence from data about the existence of sticky floor and glass ceiling in the laboral market in Peru. Likewise, the gender wage gap is calculated vía statistic modelling. The analysis period is 2017-2021

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

1. 
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/d90d1d1f-5d8b-45c9-acd2-38d63977e7a6)

2.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/e61e00e6-54f3-4281-911c-ec6415490a9f)

3.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/b304380b-be80-4ebe-9b16-4497365af873)

4.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/af7d3697-1a58-4bb4-bb02-d84852b2e37a)

5.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/4f6eaa3d-7cc9-4be7-9bf9-7ba4f2d1f7e0)

6.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/45649d1a-7670-4b73-951e-1afc0cef1140)

7.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/ea16b7e2-a0d6-44b1-8d5e-381575db98d2)

8.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/30ab4a0b-a6a9-4f0e-9f89-3fc6d8ec2e55)

9.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/1de11a3b-a817-4f69-8c74-069167ca29b1)

10.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/7c40ccef-03b7-4735-bcac-436cadf8bf59)

11.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/7dc3706d-4c50-4428-a285-a159888c7e68)

12.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/7dece09d-54e7-4e96-8e04-9d46112f3a7d)

13.
![image](https://github.com/juanfaca/Gender_Wage_Gap_Quantiles/assets/151573658/d5affcf4-ed12-47b5-8f76-af7f0157ca04)


### Recommendations


### Limitations


### References
