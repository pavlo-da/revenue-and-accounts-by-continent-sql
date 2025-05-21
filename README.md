# Revenue and User Metrics by Continent

This SQL query provides a comprehensive breakdown of **revenue and user activity metrics by continent**. It combines revenue data by device type with user account and session statistics to support geographic performance analysis.

## Objective

To calculate and analyze the following metrics per continent:

- Total revenue and revenue by device type
- Percentage of global revenue
- Number of accounts and verified accounts
- Number of sessions

## Query Logic

The query is structured in the following steps:

### 1. Revenue Metrics by Continent

In the `revenue_by_continent` CTE:

- Joins `session_params`, `order`, and `product` tables
- Calculates:
  - `revenue`: Total revenue per continent
  - `revenue_from_mobile`: Revenue from mobile devices
  - `revenue_from_desktop`: Revenue from desktop devices
  - `percent_revenue_from_total`: Share of each continent’s revenue in the global total

### 2. Account & Session Metrics by Continent

In the `accounts_by_continent` CTE:

- Joins `account`, `account_session`, and `session_params` tables
- Calculates:
  - `account_cnt`: Number of unique accounts
  - `verified_account`: Number of verified accounts
  - `session_cnt`: Number of sessions

### 3. Final Join

- Combines both CTEs using the common field `continent`
- Produces a full view of performance per continent
