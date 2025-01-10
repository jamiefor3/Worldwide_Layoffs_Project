# Overview

Welcome to my analysis of the global job market, with a particular focus on worldwide layoffs. This project was inspired by the goal of understanding trends in layoffs across industries, regions, and company stages. It aims to provide insights into workforce dynamics and identify patterns that may help professionals and organizations navigate economic challenges. The majority of layoff data used in this project is dated between April 2020 - April 2022, times where workforces were largely affected by the COVID-19 pandemic, and therefore can provide insights of how companies, industries and countries were affected by this.

The dataset, sourced from [Alex The Analyst's Worldwide Layoffs Data](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv), which I have explored and cleaned using SQL to produce [my own dataset](https://huggingface.co/datasets/Jamiefor3/Worldwide_Layoffs_Data) used in the python analysis. It includes detailed information on industries, company stages, percentages laid off, funding, and locations. Using a series of SQL queries and Python scripts, this project explores critical questions such as the industries most affected, layoff trends over time, and how different countries are affected by layoffs.

# The Questions
Below are the questions I wanted to answer in this project:

1. How were different industries layoffs affected by COVID?
2. How are different company stages layoffs affected by COVID?
3. What is the relationship between funds raised and total layoffs?
4. How did the total worldwide layoffs change over time?
5. How do different countries compare with each other?

# Tools I Used
For my analysis of worldwide layoffs, I made use of several key tools:

- **SQL:** Used for exploratory data analysis as well as cleaning the data for use in python.
- **Python:** The backbone of the analysis allowing me to find key insights through the use of scripts. Within python I frequently used the following libraries: Pandas, Matplotlib and Seaborn.
- **Jupyter Notebooks:** The tool used to run my python scripts, allowing easy inclusion of notes and analysis.
- **Visual Studio Code:** Also used for executing python scrips
- **Git and Github:** Used for version control and sharing my project.

# Data Preparation and Cleanup
### To prepare my data for analysis I used SQL. There were 6 main stages of the cleanup.

My queries and notes can be read here:
[Layoff_Project_Cleaning.sql](Layoff_Project_Cleaning.sql)

1. **Standardising** the date format** ensures consistency and enables accurate sorting, filtering, and analysis of time-based data.

2. **Removing duplicate entries** eliminates redundancy and prevents skewed results in analysis.

3. **Handling NULL or missing values** avoids errors and ensures the dataset is complete and reliable.

4. **Standardising text data** facilitates accurate grouping, comparisons, and analysis of categorical fields.

5. **Verifying data integrity** ensures the dataset is accurate, trustworthy, and aligns with expected standards.


### In Python I prepared for analysis by:

#### Importing Libraries
```
import numpy as np
import pandas as pd
from datasets import load_dataset
import matplotlib.pyplot as plt
from matplotlib.ticker import PercentFormatter
import ast
import seaborn as sns
from adjustText import adjust_text
```
#### Loading Data and Modifying Date Column
```
dataset = load_dataset('Jamiefor3/Worldwide_Layoffs_Data')
df = dataset['train'].to_pandas()

df['date'] = pd.to_datetime(df['date'])
df_dates = df[df['date'] < '2022-05-01']
```
This code will load the data and then convert the 'date' column into a date time format allowing for easier date-related operations like sorting, filtering by date range, or performing calculations. As well as create a new dataframe with only data from the main COVID timeline (March 2020 - April 2022).

# The Analysis

Code and notes for all the questions, analysis and visualisations can be found here:
[Layoff_Analysis.ipynb](Layoff_Analysis/Layoff_Analysis.ipynb)

## 1. How were different industries layoffs affected by COVID?
To understand how different industries were affected by COVID, I conducted two analyses. First, I calculated the total layoffs per industry to identify sectors with the highest job losses overall. Second, I filtered industries with significant representation and calculated the average percentage of layoffs, focusing on the top 10 industries. These visualizations provide a comprehensive view of the layoff landscape, highlighting both the absolute and relative impact across industries.

### Visualisation code
---
```
sns.set_theme(style='ticks')
sns.barplot(data=industry_layoffs, y='industry', x='total_laid_off', hue='total_laid_off', palette='dark:b_r', legend=False)
sns.despine()
plt.title('Total Layoffs by Industry During COVID')
plt.xlabel('Industry')
plt.ylabel('Total Layoffs')
plt.tight_layout()
plt.grid(True, axis='x')
plt.tight_layout()
plt.show()
```
```
sns.barplot(data=industry_perc_plot, x='percentage_laid_off', y='industry', hue='percentage_laid_off', palette='dark:blue_r', legend=False)
sns.despine()
plt.title('Average Percent Laid Off by Industry During COVID')
plt.ylabel('Industry')
plt.xlabel('Average % laid off')
plt.grid(True, axis='x')
ax = plt.gca()
ax.xaxis.set_major_formatter(PercentFormatter(decimals=0))
plt.tight_layout()
plt.show()
```

### Results
---
![Bar plot for industry total laid off](Layoff_Analysis/Images/total_layoffs_industry_bar.png)

![Bar plot for industry average percentage laid off](Layoff_Analysis/Images/percentage_layoffs_industry_bar.png)

### Insights
---
bbbbb

## 2. How are different company stages layoffs affected by COVID?

