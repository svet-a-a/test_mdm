SELECT date_
    , SUM(produt_qty*product_price) AS sales
FROM TRANSACTIONS
WHERE date_ BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY date_
ORDER BY date_ ASC
;

SELECT COALESCE (deco.cilent_id, meub.cilent_id) AS cilent_id
        , deco.ventes_deco
        , meub.ventes_meuble 
FROM
(SELECT cilent_id, SUM(SUM_) AS ventes_deco
FROM (SELECT tr.date_
            , tr.cilent_id
            , tr.produt_qty*tr.product_price AS SUM_
            , pr.product_type
    FROM TRANSACTIONS tr
    LEFT JOIN PRODUCT_NOMENCLATURE pr
    ON tr.PR = pr.PR
    WHERE date_ BETWEEN '2019-01-01' AND '2019-12-31'
    )
WHERE product_type LIKE 'DECO'
GROUP BY cilent_id
) deco
FULL JOIN
(SELECT cilent_id, SUM(SUM_) AS ventes_meuble
FROM (SELECT tr.date_
            , tr.cilent_id
            , tr.produt_qty*tr.product_price AS SUM_
            , pr.product_type
    FROM TRANSACTIONS tr
    LEFT JOIN PRODUCT_NOMENCLATURE pr
    ON tr.PR = pr.PR
    WHERE date_ BETWEEN '2019-01-01' AND '2019-12-31'
    )
WHERE product_type LIKE 'MEUBLE'
GROUP BY cilent_id
) meub
ON  de.cilent_id = me.cilent_id
;
