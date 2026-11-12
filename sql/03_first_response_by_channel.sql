-- Q2: What share of tickets breached the first-response SLA, by channel?
-- Grain: one row per channel. Denominator is all tickets (COUNT(*)).
-- Note: the 18 tickets with no first response are flagged as violated in the source data, so they are counted as breaches here.

SELECT channel, COUNT(*) AS total,
	SUM(CASE WHEN first_response_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) AS breaches,
	ROUND(100.0 * SUM(CASE WHEN first_response_sla_flag = 'SLA Violated' THEN 1 ELSE 0 END) / COUNT(*), 1) AS sla_violated
FROM tickets
GROUP BY channel
ORDER BY breaches DESC