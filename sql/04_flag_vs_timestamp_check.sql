-- Data quality: do the first-response SLA flags agree with the timestamps?
-- Result: 2,298 of 2,312 agree (99.4%). The 14 disagreements are all tickets created
-- 2023-02-18 to 2023-02-20, flagged "SLA Violated" but answered inside the 1-hour target.
-- Cause unknown. Effect on channel breach rates: under 1 point; ranking unchanged.

WITH checked AS (
	SELECT ticket_id, first_response_sla_flag, 
	CASE WHEN first_response_at > first_response_due THEN 'Late' ELSE 'On time' END AS recomputed
	FROM tickets
		WHERE first_response_at IS NOT NULL
)
SELECT first_response_sla_flag, recomputed, COUNT(*) AS n
FROM checked
GROUP BY first_response_sla_flag, recomputed;

SELECT ticket_id, created_at, first_response_at, first_response_due, channel, agent_name, (julianday(first_response_due) - julianday(first_response_at)) * 24 AS hrs_early
FROM tickets
WHERE first_response_sla_flag = 'SLA Violated'
	AND first_response_at <= first_response_due
ORDER BY first_response_at


