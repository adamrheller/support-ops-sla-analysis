-- Q1: How many tickets were created each month, split by current status?
-- Grain: one row per month (2023-01 to 2023-12). Status is as of export date, not creation date.
-- Note: "In progress" tickets from early months are stale backlog, not new work.

SELECT strftime('%Y-%m', created_at) AS month, 
	SUM(CASE WHEN status = 'Closed' THEN 1 ELSE 0 END) AS closed,
	SUM(CASE WHEN status = 'Open' THEN 1 ELSE 0 END) AS open,
	SUM(CASE WHEN status = 'In progress' THEN 1 ELSE 0 END) AS in_progress,
	SUM(CASE WHEN status = 'Resolved' THEN 1 ELSE 0 END) AS resolved,
	COUNT(*) AS total
FROM tickets
GROUP BY month