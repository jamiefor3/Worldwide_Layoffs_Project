# Overview

Welcome to my analysis of the global job market, with a particular focus on worldwide layoffs. This project was inspired by the goal of understanding trends in layoffs across industries, regions, and company stages. It aims to provide insights into workforce dynamics and identify patterns that may help professionals and organizations navigate economic challenges. The majority of layoff data used in this project is dated between April 2020 - April 2022, times where workforces were largely affected by the COVID-19 pandemic, and therefore can provide insights of how companies, industries and countries were affected by this.

The dataset, sourced from [Alex The Analyst's Worldwide Layoffs Data](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv), which I have explored and cleaned using SQL to produce [my own dataset](https://huggingface.co/datasets/Jamiefor3/Worldwide_Layoffs_Data) used in the python analysis. It includes detailed information on industries, company stages, percentages laid off, funding, and locations. Using a series of SQL queries and Python scripts, this project explores critical questions such as the industries most affected, layoff trends over time, and how different countries are affected by layoffs.

# The Questions
Below are the questions I wanted to answer in this project:

1. How were different industries layoffs affected by COVID?
2. How were different company stages layoffs affected by COVID?
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

1. **Standardising the date format** ensures consistency and enables accurate sorting, filtering, and analysis of time-based data.

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
Examining how layoffs in different industries were affected by COVID-19 is vital for understanding the pandemic's economic impact. COVID-19 triggered widespread disruptions, with some industries experiencing significant workforce reductions due to reduced demand, supply chain challenges, or shifts in consumer behavior.

To analyze this, I created two visualizations. The first calculates the total layoffs by industry during the pandemic, highlighting which sectors experienced the highest overall job losses. The second focuses on the average percentage of layoffs by industry, offering insights into the relative workforce impact within each sector. Together, these visualizations provide a comprehensive view of the pandemic's impact on industry employment, uncovering both absolute and proportional trends in layoffs.

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
#### **Total Layoffs by Industry During COVID**
- **Transportation Industry:** This industry experienced the highest total layoffs, which is consistent with the significant impact of travel restrictions and reduced demand for transportation services during COVID. Airlines, ride-sharing services, and logistics companies were particularly affected.

- **Retail and Real Estate:** These industries rank high in total layoffs. Retail faced challenges with store closures and the shift to e-commerce, while real estate was impacted by reduced mobility and uncertainty in housing and commercial spaces.

- **Finance and Food Industries:** Both saw notable layoffs. Finance may have been affected by market volatility and reduced economic activity, while the food industry faced disruptions in supply chains and reduced demand for dine-in services.
Lower Layoffs: Aerospace, security, and legal industries saw fewer layoffs, likely due to their specialized nature and continued demand in certain sectors during the pandemic.

#### **Average Percent Laid Off by Industry During COVID**
- **Education Sector:** This sector had the highest average percentage of layoffs, reflecting the challenges in adapting to remote education and budget cuts during the pandemic.

- **Healthcare Sector:** Surprisingly high average layoffs were observed, possibly due to layoffs in administrative roles or non-essential healthcare services that were halted during the pandemic.
Retail and Real Estate: Both had significant average layoffs, further emphasizing their struggles with lockdowns and reduced physical operations.

- **Transportation:** While it had the highest total layoffs, the average percentage of layoffs was lower compared to education and healthcare, potentially because the industry employs a larger workforce overall.

#### **Combined Insights**
- **High Total vs. High Percentage Layoffs:** Transportation had the most significant total layoffs, while education faced the highest average layoffs percentage. This indicates that while transportation saw widespread layoffs across a large workforce, education had a more concentrated impact within its workforce.

- **COVID's Broad Impact:** Industries heavily reliant on in-person interaction (e.g., transportation, retail, food) and those disrupted by remote transitions (e.g., education) were among the hardest hit.

- **Key Focus Areas:** Support for industries like transportation, education, and retail could mitigate future economic shocks of similar nature.


## 2. How were different company stages layoffs affected by COVID?
Understanding how layoffs impact companies at different stages is essential for identifying trends in workforce stability across the business lifecycle. Startups, growth-stage companies, and mature enterprises often face unique challenges that influence their layoff patterns, such as funding constraints, market pressures, or restructuring efforts.

To explore this, I conducted an analysis by grouping companies based on their stage and calculating the average percentage of layoffs for each group. I then visualized these averages using a bar plot, highlighting the relative layoff rates across stages. This approach helps reveal which company stages are most affected by layoffs, providing valuable insights into the relationship between business maturity and workforce reductions.

### Visualisation code
---
```
sns.barplot(y='stage', x='percentage_laid_off', data=stage_layoffs, hue ='percentage_laid_off', palette='dark:blue_r', legend=False)
sns.despine()
plt.title('Total Layoffs by Company Stage During COVID')
plt.xlabel('Percentage Laid Off')
plt.ylabel('Company Stage')
plt.grid(True, axis='x')
ax = plt.gca()
ax.xaxis.set_major_formatter(PercentFormatter(decimals=0))
plt.tight_layout()
plt.show()
```

### Results
---
![Bar plot for company stages percentage laid off](Layoff_Analysis/Images/percentage_layoffs_company_stage_bar.png)

### Insights
---
- **Seed and Early-Stage Companies:** Startups in their early stages (e.g., Seed, Series A, B) were especially vulnerable during the pandemic, as many struggled with funding, pivoting to remote operations, and navigating an uncertain market. This contributed to higher layoffs at these stages.

- **Impact of Acquisitions:** Acquired companies may have faced layoffs as the acquiring firms streamlined operations to adapt to the pandemic’s economic effects.

- **Series C to E Companies:** Many companies in these stages were moderately stable but still faced pressure to reduce costs or downsize as a result of pandemic-related market disruptions.

- **Later Stages and Subsidiaries:** More established companies and subsidiaries typically had stronger financial cushions or access to funding, enabling them to avoid the drastic layoffs seen in earlier-stage companies.

- **Unknown:** I decided to keep the companies with an unknown stage in the data set to almost act as a random sampling of stages. This group having a high percentage could show that the majority of companies affected had harsh layoff amounts.

#### **Key Insights**
- **Early-Stage Vulnerability:** Startups in seed and Series A stages were most affected, highlighting the fragile nature of businesses reliant on investor confidence during economic downturns.

- **Resilience of Later Stages:** More established companies had the resources to maintain operations, reflecting their greater ability to adapt and survive through crises.

- **COVID's Broad Impact:** The pandemic exposed structural weaknesses in early-stage startups, reinforcing the importance of financial planning and crisis preparedness for companies at all stages.

## 3. What is the relationship between funds raised and total layoffs?

Understanding the relationship between funds raised and total layoffs is crucial for assessing how financial resources influence workforce stability. Companies that have raised significant funds might be expected to sustain their workforce better, but layoffs could still occur due to mismanagement, market downturns, or overexpansion.

To explore this relationship, I conducted an analysis using a scatter plot with a regression line. First, I filtered out extreme outliers in the dataset (companies raising over $120 billion) to ensure the results were not skewed. Then, I plotted the relationship between funds raised and total layoffs, highlighting trends with a regression line to reveal potential correlations. This visualization provides insights into whether companies with higher funding experience proportionally more or fewer layoffs, shedding light on the broader dynamics of financial resources and workforce decisions.

### Visualisation code
---
```
sns.regplot(x='funds_raised_millions', y='total_laid_off', data=funds_no_outliers, scatter_kws={'color': 'black'}, line_kws={'color': 'red'})
sns.despine()
plt.title('Funding Raised vs Total Layoffs')
plt.xlabel('Funds Raised (Millions)')
plt.ylabel('Total Layoffs')
plt.tight_layout()
plt.show()
```

### Results
---
![Reg plot for funds raised and total laid off relationship](Layoff_Analysis/Images/funds_raised_layoffs_reg.png)

### Insights
---
bbb

## 4. How did the total worldwide layoffs change over time?

Understanding how total worldwide layoffs changed over time provides valuable insights into broader economic trends and external shocks, such as global crises or market shifts. By analyzing the temporal patterns of layoffs, we can identify periods of heightened job losses and explore potential causes behind these spikes.

To examine this, I grouped the data by month to calculate the total layoffs per month and plotted these figures alongside a 3-month rolling average to smooth out short-term fluctuations. Additionally, I identified and highlighted months where layoffs significantly exceeded the rolling average (spikes), providing a clear view of abnormal periods of job losses. This analysis captures both the overall trajectory of layoffs over time and key moments of heightened activity, offering a deeper understanding of global layoff dynamics.

### Visualisation code
---
```
sns.lineplot(x=df_month['date'].astype(str), y=df_month['total_laid_off'], label='Total Layoffs', color='blue')
sns.lineplot(x=df_month['date'].astype(str), y=df_month['rolling_avg'], label='Rolling Average (3 months)', color='red', linestyle='--')
spikes = df_month[df_month['total_laid_off'] > df_month['rolling_avg'] * 1.5]
sns.scatterplot(x=spikes['date'].astype(str), y=spikes['total_laid_off'], color='orange', label='Spikes', s=100)
sns.despine()
plt.title('Layoffs Over Time with Spike Detection')
plt.xlabel('Date')
plt.ylabel('Total Layoffs')
ticks = df_month.index[::3]
tick_labels = df_month['date'].iloc[::3]
plt.xticks(ticks, tick_labels, rotation=45)
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
```

### Results
---
![Line scatter of total laid off over time with spikes](Layoff_Analysis/Images/layoffs_over_time_scatter.png)

### Insights
---
bbbbb

## 5. How do different countries compare with each other?

To understand how layoffs differ across countries, it's important to explore global variations in both the total number of layoffs and the percentage of employees laid off. This comparison can shed light on regional trends, such as which countries were more heavily impacted by layoffs and whether certain regions experienced more severe workforce reductions.

For this analysis, I filtered countries with more than 10 data entries to ensure reliable comparisons. I then grouped the data by country and calculated the mean total layoffs and average percentage of layoffs. To enhance the visualization, I mapped each country to its respective continent and used color coding to distinguish regions. The result is a scatter plot that compares total layoffs against the percentage laid off for each country, with annotations to provide clear identification. This visualization offers a comprehensive look at how different countries are affected by layoffs, both in terms of scale and workforce proportion.

### Visualisation code
---
```
sns.scatterplot(data=country_totals, x='total_laid_off', y='percentage_laid_off', s= 100, hue='Continent', palette=continent_colors, alpha= 0.7 )
for i, txt in enumerate(country_totals.index):
    plt.annotate(txt, 
                 (country_totals['total_laid_off'].iloc[i], 
                  country_totals['percentage_laid_off'].iloc[i]))
sns.despine()
plt.title('Country Job Layoff Comparison')
plt.xlabel('Average Laid off')
plt.ylabel('Average Percentage Laid Off')
ax = plt.gca()
ax.yaxis.set_major_formatter(PercentFormatter(decimals=0))
plt.tight_layout()
plt.show()
```

### Results
---
![Scatter plot of country comparison of percentage and total laid off](Layoff_Analysis/Images/country_layoff_scatter.png)

### Insights
---
bbbb
