{{ config(
    materialized='table'
) }}

WITH date_spine AS (
    SELECT
        DATEADD(
            DAY,
            ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1,
            '2000-01-01'::DATE
        ) AS date_day
    FROM TABLE(GENERATOR(ROWCOUNT => 15000))
),
date_dimension AS (
    SELECT
        /* DATE */
        date_day,
        /* DATE KEY */
        TO_NUMBER(TO_CHAR(date_day, 'YYYYMMDD')) AS date_key,
        /* CALENDAR YEAR */
        YEAR(date_day) AS year,
        QUARTER(date_day) AS quarter,
        MONTH(date_day) AS month,
        MONTHNAME(date_day) AS month_name,
        TO_CHAR(date_day, 'MMMM') AS month_name_full,
        DAY(date_day) AS day,
        DAYOFWEEK(date_day) AS day_of_week,
        DAYNAME(date_day) AS day_name,
        CASE
            WHEN DAYNAME(date_day) = 'Sun' THEN 'Sunday'
            WHEN DAYNAME(date_day) = 'Mon' THEN 'Monday'
            WHEN DAYNAME(date_day) = 'Tue' THEN 'Tuesday'
            WHEN DAYNAME(date_day) = 'Wed' THEN 'Wednesday'
            WHEN DAYNAME(date_day) = 'Thu' THEN 'Thursday'
            WHEN DAYNAME(date_day) = 'Fri' THEN 'Friday'
            WHEN DAYNAME(date_day) = 'Sat' THEN 'Saturday'
        END AS day_name_full,
        WEEKOFYEAR(date_day) AS week_of_year,
        /* WEEKEND / WEEKDAY */
        CASE
            WHEN DAYOFWEEK(date_day) IN (1, 7) THEN TRUE
            ELSE FALSE
        END AS is_weekend,
        CASE
            WHEN DAYOFWEEK(date_day) IN (1, 7) THEN FALSE
            ELSE TRUE
        END AS is_weekday,
        /* CALENDAR YEAR DATES */
        DATE_FROM_PARTS(YEAR(date_day), 1, 1) AS year_start_date,
        DATE_FROM_PARTS(YEAR(date_day), 12, 31) AS year_end_date,
        /* FISCAL YEAR - APRIL TO MARCH */
        CASE
            WHEN MONTH(date_day) >= 4 THEN YEAR(date_day)
            ELSE YEAR(date_day) - 1
        END AS fiscal_year_start,
        CASE
            WHEN MONTH(date_day) >= 4 THEN YEAR(date_day) + 1
            ELSE YEAR(date_day)
        END AS fiscal_year_end,
        /* FISCAL YEAR LABEL - FY2026-27 */
        CONCAT(
            'FY',
            CASE
                WHEN MONTH(date_day) >= 4 THEN YEAR(date_day)
                ELSE YEAR(date_day) - 1
            END,
            '-',
            RIGHT(
                CAST(
                    CASE
                        WHEN MONTH(date_day) >= 4 THEN YEAR(date_day) + 1
                        ELSE YEAR(date_day)
                    END AS VARCHAR
                ),
                2
            )
        ) AS fiscal_year,
        /* FISCAL YEAR START DATE */
        CASE
            WHEN MONTH(date_day) >= 4 THEN DATE_FROM_PARTS(YEAR(date_day), 4, 1)
            ELSE DATE_FROM_PARTS(YEAR(date_day) - 1, 4, 1)
        END AS fiscal_year_start_date,
        /* FISCAL YEAR END DATE */
        CASE
            WHEN MONTH(date_day) >= 4 THEN DATE_FROM_PARTS(YEAR(date_day) + 1, 3, 31)
            ELSE DATE_FROM_PARTS(YEAR(date_day), 3, 31)
        END AS fiscal_year_end_date,
        /* FISCAL QUARTER */
        CASE
            WHEN MONTH(date_day) BETWEEN 4 AND 6 THEN 'FY-Q1'
            WHEN MONTH(date_day) BETWEEN 7 AND 9 THEN 'FY-Q2'
            WHEN MONTH(date_day) BETWEEN 10 AND 12 THEN 'FY-Q3'
            WHEN MONTH(date_day) BETWEEN 1 AND 3 THEN 'FY-Q4'
        END AS fiscal_quarter,
        /* FISCAL QUARTER NUMBER */
        CASE
            WHEN MONTH(date_day) BETWEEN 4 AND 6 THEN 1
            WHEN MONTH(date_day) BETWEEN 7 AND 9 THEN 2
            WHEN MONTH(date_day) BETWEEN 10 AND 12 THEN 3
            WHEN MONTH(date_day) BETWEEN 1 AND 3 THEN 4
        END AS fiscal_quarter_number,
        /* FISCAL QUARTER LABEL - FY2026-Q1 */
        CONCAT(
            'FY',
            CASE
                WHEN MONTH(date_day) >= 4 THEN YEAR(date_day)
                ELSE YEAR(date_day) - 1
            END,
            '-Q',
            CASE
                WHEN MONTH(date_day) BETWEEN 4 AND 6 THEN 1
                WHEN MONTH(date_day) BETWEEN 7 AND 9 THEN 2
                WHEN MONTH(date_day) BETWEEN 10 AND 12 THEN 3
                ELSE 4
            END
        ) AS fiscal_quarter_label,
        /* FISCAL MONTH - APRIL = 1 ... MARCH = 12 */
        CASE
            WHEN MONTH(date_day) >= 4 THEN MONTH(date_day) - 3
            ELSE MONTH(date_day) + 9
        END AS fiscal_month_number,
        /* FISCAL MONTH NAME */
        TO_CHAR(date_day, 'MMMM') AS fiscal_month_name,
        /* MONTH START / END */
        DATE_TRUNC('MONTH', date_day) AS month_start_date,
        LAST_DAY(date_day, 'MONTH') AS month_end_date,
        /* DAYS IN MONTH */
        DAY(LAST_DAY(date_day, 'MONTH')) AS days_in_month
    FROM date_spine
)
SELECT *
FROM date_dimension
WHERE date_day <= CURRENT_DATE()
ORDER BY date_day