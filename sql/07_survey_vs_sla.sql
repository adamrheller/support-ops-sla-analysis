-- Do survey scores differ between tickets that met the SLA and tickets that breached it?
-- One row per: SLA flag value (two cuts: first-response flag, then resolution flag).
-- Scope: tickets with a survey score only (1,173 responses, all from Closed tickets).
--   Unresolved tickets have no survey, so they are not represented here.
-- Scale: 1 to 5. csat_share = percent of responses scoring 4 or 5.
-- Result: no meaningful difference. Breached tickets scored slightly higher
--   (about 3.6 vs 3.5 average), within what noise would produce at these group sizes.

SELECT first_response_sla_flag,
	COUNT(survey_score) AS surveys,
	ROUND(AVG(survey_score), 2) AS avg_score,
	ROUND(100.0 * SUM(CASE WHEN survey_score >= 4 THEN 1 ELSE 0 END) / count(*), 1) AS csat_share
FROM tickets
WHERE survey_score IS NOT NULL
GROUP BY first_response_sla_flag;


SELECT resolution_sla_flag, 
	COUNT(survey_score) AS surveys,
	ROUND(AVG(survey_score), 2) AS avg_score,
	ROUND(100.0 * SUM(CASE WHEN survey_score >= 4 THEN 1 ELSE 0 END) / COUNT(*), 1) AS csat_share
FROM tickets
WHERE survey_score IS NOT NULL
GROUP BY resolution_sla_flag;

