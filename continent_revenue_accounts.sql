-- Calculate revenue metrics per continent
WITH revenue_by_continent AS (
  SELECT  
    sp.continent,
    SUM(p.price) AS revenue,
    SUM(CASE WHEN device = 'mobile' THEN p.price END) AS revenue_from_mobile,
    SUM(CASE WHEN device = 'desktop' THEN p.price END) AS revenue_from_desktop,
    SUM(p.price) / SUM(SUM(p.price)) OVER () * 100 AS percent_revenue_from_total
  FROM `data-analytics-mate.DA.session_params` sp
  JOIN `data-analytics-mate.DA.order` o
  USING(ga_session_id)
  JOIN `data-analytics-mate.DA.product` p
  USING(item_id)
  GROUP BY 1
),

-- Calculate account and session metrics per continent
accounts_by_continent AS (
  SELECT
    sp.continent,
    COUNT(DISTINCT a.id) AS account_cnt,
    COUNT(DISTINCT CASE WHEN a.is_verified = 1 THEN a.id END) AS verified_account,
    COUNT(DISTINCT sp.ga_session_id) AS session_cnt
  FROM `data-analytics-mate.DA.account` a
  LEFT JOIN `data-analytics-mate.DA.account_session` acs
  ON a.id = acs.account_id
  RIGHT JOIN `data-analytics-mate.DA.session_params` sp
  USING(ga_session_id)
  GROUP BY 1
)

-- Join revenue and account metrics by continent
SELECT
  r.continent,
  r.revenue,
  r.revenue_from_mobile,
  r.revenue_from_desktop,
  r.percent_revenue_from_total,
  a.account_cnt,
  a.verified_account,
  a.session_cnt,
FROM revenue_by_continent r
JOIN accounts_by_continent a
USING(continent)
