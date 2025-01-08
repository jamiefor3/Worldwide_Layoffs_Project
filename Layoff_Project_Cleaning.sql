-- 0. Create Backup
CREATE TABLE layoffs_backup
LIKE layoffs;

INSERT layoffs_backup
SELECT * 
FROM layoffs;

-- 1. Standardize Date Formats
-- Assuming the `date` column has inconsistent formats, convert all entries to 'YYYY-MM-DD'.
-- This step also handles any cases where dates are stored as strings.

UPDATE layoffs
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
WHERE date LIKE '%/%';

ALTER TABLE layoffs
MODIFY COLUMN `date` DATE;

-- 2. Remove Duplicates
-- Since there is no ID column, duplicates can be identified based on all columns having identical values.
-- Create a temporary table, copy distinct rows, and replace the original table.

CREATE TEMPORARY TABLE temp_layoffs AS
SELECT DISTINCT *
FROM layoffs;

TRUNCATE TABLE layoffs;

INSERT INTO layoffs
SELECT * FROM temp_layoffs;

DROP TABLE temp_layoffs;

-- 3. Handle Null or Missing Values
-- Fill in missing industry values.
-- Review columns with NULL or missing values and remove them as they will not be used in the analysis.

UPDATE layoffs t1
JOIN layoffs t2
	ON t1.company = t2.company
SET t1.industry = t2.industry 
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

DELETE
FROM layoffs
WHERE company IS NULL
   OR industry IS NULL
   OR total_laid_off IS NULL
   OR percentage_laid_off IS NULL
   OR company IS NULL
   OR `date` IS NULL
   OR funds_raised_millions IS NULL;

-- 4. Standardize Text Data
-- Convert text in critical columns to a consistent case (First letter upper, the rest lower) for uniformity
-- Remove any other inconsistencies noticed in text data.

UPDATE layoffs
SET company = CONCAT(UPPER(SUBSTRING(company, 1, 1)), LOWER(SUBSTRING(company, 2)));

UPDATE layoffs
SET industry = CONCAT(UPPER(SUBSTRING(industry, 1, 1)), LOWER(SUBSTRING(industry, 2)));

UPDATE layoffs
SET company = trim(company);

UPDATE layoffs
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

UPDATE layoffs
SET country = trim(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- 5. Verify Data Integrity
-- Run checks to ensure there are no anomalies.

SELECT * FROM layoffs
WHERE date > CURDATE(); -- Check for future dates.

SELECT industry, COUNT(*)
FROM layoffs
GROUP BY industry
HAVING COUNT(*) < 10; -- Flag rare industries for review.

DELETE
FROM layoffs
WHERE industry LIKE ''; -- Remove any anomalies.

-- 6. Save Cleaned Data
-- Export the cleaned data to a backup table for future reference.

CREATE TABLE layoffs_cleaned AS
SELECT * FROM layoffs;
