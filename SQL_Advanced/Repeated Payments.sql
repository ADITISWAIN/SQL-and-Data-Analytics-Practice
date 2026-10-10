#Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.

WITH lagged_transactions AS (
    SELECT 
        transaction_id,
        merchant_id,
        credit_card_id,
        amount,
        transaction_timestamp,
        LAG(transaction_timestamp) OVER (
            PARTITION BY credit_card_id, merchant_id, amount 
            ORDER BY transaction_timestamp
        ) AS prev_timestamp
    FROM transactions
)
SELECT 
    COUNT(transaction_id) AS payment_count
FROM lagged_transactions
WHERE EXTRACT(EPOCH FROM (transaction_timestamp - prev_timestamp)) <= 600;
