

-- check to see if there is data for each day
    -- there is
    -- and appears to be 3-5 records a day

    SELECT
             CAST( transaction_time AS DATE) as transaction_date
            ,COUNT(*)

    FROM
            transactions

    WHERE
            1 = 1

    GROUP BY
            ALL

    ORDER BY
            transaction_date;

-- check the distribution of records

    -- ┌───────────────────┬─────────────────────────┐
    -- │ transaction_count │ count(transaction_date) │
    -- │       int64       │          int64          │
    -- ├───────────────────┼─────────────────────────┤
    -- │                 3 │                      11 │
    -- │                 4 │                      19 │
    -- │                 5 │                       1 │
    -- └───────────────────┴─────────────────────────┘

    WITH

    DIST_AGG AS (

        SELECT
                 CAST( transaction_time AS DATE)    AS transaction_date
                ,COUNT(*)                           AS transaction_count

        FROM
                transactions

        WHERE
                1 = 1

        GROUP BY
                ALL

        ORDER BY
                transaction_date

    )

    SELECT
             transaction_count
            ,COUNT(transaction_date)

    FROM
            DIST_AGG

    GROUP BY
            ALL

    ORDER BY
            transaction_count

    ;

-- check to see if there any duplicate transaction times
    -- there isn't, yay

    SELECT
             transaction_time
            ,COUNT(*)           AS transaction_count

    FROM
            transactions

    GROUP BY
            ALL

    HAVING
            COUNT(*) != 1

    ;
