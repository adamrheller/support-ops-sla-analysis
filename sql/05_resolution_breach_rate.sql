-- Resolution SLA breach rate: resolved tickets only vs. all tickets.
-- One row per: basis (resolved only / all tickets).
-- Result: 19.1% resolved-only vs 33.6% all. The 417-ticket gap is tickets never
-- resolved ("In progress" or "Open"), all flagged SLA Violated in the source data.
-- Neither rate alone is the truth.

WITH resolved AS(
	SELECT ticket_id, resolution_sla_flag
	FROM tickets
	WHERE resolved_at IS NOT NULL
)
SELECT 'Resolved only' AS basis,
	COUNT(*)		   AS totals,
	SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) AS breaches,
	ROUND(100.0 * SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) / COUNT(*), 1) AS breach_pct
FROM resolved

UNION ALL

SELECT 'All tickets' 	AS basis,
	COUNT(*)			AS totals,
	SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) AS breaches,
	ROUND(100.0 * SUM(CASE WHEN resolution_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) / COUNT(*), 1) AS breach_pct
FROM tickets;