-- EXploratory Data Analysis

select *
from layoffs_staging2;

Select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 2 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select substring(`date`,1,7) as `month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc;

with Rolling_Total as 
(
select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `month`
order by 1 asc
)
select `month`, total_off,
sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;

select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
order by 1 asc;

with Company_Year (Company, Years, Total_Laid_Off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company, year(`date`)
), company_year_rank as 
(
select *, dense_rank () over (partition by years order by total_laid_off desc) as ranking
from Company_Year
where Years is not null
)
select * 
from company_year_rank
where ranking <= 5;

Select industry, left(avg(percentage_laid_off),4)
from layoffs_staging2
group by industry;

With per_laid_off (Industry, Years, Percentage_Laid_Off) as
(
select industry, year(`date`), avg(percentage_laid_off)
from layoffs_staging2
group by industry, year(`date`)
), Industry_Year_Rank as
(
select *, dense_rank () over (partition by years order by percentage_laid_off desc) as ranking
from per_laid_off
where Years is not null and percentage_laid_off is not null
)
select *
from Industry_Year_Rank
where ranking <= 5;




select *
from layoffs_staging2
where industry = 'manufacturing';

with per_laid_off_asc (industry, years, percentage_laid_off) as
(
select industry, year(`date`), avg(percentage_laid_off)
from layoffs_staging2
group by industry, year(`date`)
), industry_rank2 as
(
select *, dense_rank () over (Partition by years order by percentage_laid_off asc) as ranking2
from per_laid_off_asc
where years is not null and percentage_laid_off is not null
)
select *
from industry_rank2
where ranking2 <= 5;


with least_laid_off (industry, percentage_laid_off) as
(
select industry, left(avg(percentage_laid_off), 5)
from layoffs_staging2
group by industry
), bot_rank as
(
select *, dense_rank () over(order by percentage_laid_off asc) ranking3
from least_laid_off
where percentage_laid_off is not null and industry is not null
)
select *
from bot_rank
where ranking3 <= 10
