DROP TABLE IF EXISTS tickets;
CREATE TABLE tickets AS 
SELECT
	CAST("Ticket ID" AS INTERGER)		AS ticket_id,
	"Status"							AS status,
	"Priority"							AS priority,
	"Source" 							AS channel,
	CASE WHEN lower("Topic") = 'pricing and licensing'
		THEN 'Pricing and licensing' ELSE "Topic" END AS topic,
	"Agent Group" 						AS agent_group,
	"Agent Name" 						AS agent_name,
	"Support Level"						AS support_level,
	"Product group" 					AS product_group,
	"Country"							AS country,
	"Created time"						AS created_at,
	"Expected SLA to first response" 	AS first_response_due,
	NULLIF("First response time", '')	AS first_response_at,
	"SLA For first response"			AS first_response_sla_flag,
	"Expected SLA to resolve"			AS resoultion_due,
	NULLIF("Resolution time", '')		AS resolved_at,
	"SLA For resolution"				AS resolution_sla_flag,
	NULLIF("Close time", '')			AS closed_at,
	CAST(NULLIF("Agent interactions", '') AS INTERGER) 		AS agent_interactions,
	CAST(NULLIF("Survey results", '') AS INTERGER) 			AS survey_score
	FROM tickets_raw;
	
SELECT COUNT(*), COUNT(resolved_at), COUNT(survey_score) 
FROM tickets
	