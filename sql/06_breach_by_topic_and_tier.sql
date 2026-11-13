-- Where do resolution SLA breaches concentrate, by topic and support tier?
-- One row per: topic x support_level.
-- Scope: resolved tickets only (unresolved excluded; see 05_resolution_breach_rate.sql).
-- Groups under 30 tickets are dropped via HAVING (removes Training request / Tier 2).

SELECT topic, support_level, COUNT(*) AS total,
	SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) AS breaches,
	ROUND(100.0 * SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) / COUNT(*), 1) AS breach_pct
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY topic, support_level
HAVING COUNT(*) >=30
ORDER BY topic;

-- Tier rollup: resolution SLA breach rate by support tier (resolved tickets only).
-- One row per: support_level.

SELECT support_level, COUNT(*) AS total,
	SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) AS breaches,
	ROUND(100.0 * SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) / COUNT(*), 1) AS breach_pct
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY support_level;