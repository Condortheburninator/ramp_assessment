WITH

TRANS_AGG AS (

    SELECT
             CAST(transaction_time AS DATE)     AS transaction_time
            ,SUM(transaction_amount)            AS transaction_amount

    FROM
            transactions

    WHERE
            1 = 1

    GROUP BY
            CAST(transaction_time AS DATE)

)

SELECT
         *
        ,AVG(transaction_amount)
         OVER(
            ORDER BY        transaction_time
            ROWS BETWEEN    2 PRECEDING AND CURRENT ROW
        )                   AS THREE_DAY_AVERAGE

FROM
        TRANS_AGG

WHERE
        1 = 1

        -- conner //  not needed given the data, but including just in case
        AND transaction_time BETWEEN '2021-01-01' AND '2021-01-31'

ORDER BY
        transaction_time ASC;