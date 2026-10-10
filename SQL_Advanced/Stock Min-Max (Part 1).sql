# Display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

WITH mnth AS (
SELECT *, RANK() OVER(PARTITION BY ticker ORDER BY open DESC)As 
  month_open FROM stock_prices 
  ),
randon AS(
  SELECT ticker,  TO_CHAR(date, 'Mon-YYYY')As  highest_mth, open As 
    highest_open FROM mnth WHERE month_open=1
), 
low AS(
  SELECT *, RANK() OVER(PARTITION BY ticker ORDER BY open ASC)As 
    mmonth_oopen FROM stock_prices
),
rranndon AS (
 SELECT ticker,  TO_CHAR(date, 'Mon-YYYY')As  lowest_mth, open 
  As lowest_open FROM low WHERE mmonth_oopen=1
)

SELECT randon.ticker,randon.highest_mth,randon.highest_open,rranndon.lowest_mth, rranndon.lowest_open FROM randon JOIN 
 rranndon on randon.ticker=rranndon.ticker


