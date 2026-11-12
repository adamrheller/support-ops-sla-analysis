# Support Operations: SLA & Response Analysis

## Business question
Where does first-response and resolution SLA break down in a technical support operation, and what should a support manager change first?

## Decision this informs
Staffing, queue prioritization, and SLA target-setting.

## Data
Kaggle "Technical Support Dataset" (Suvradeep, MIT License). Likely synthetic or semi-synthetic; treated as a practice dataset, not a real company.

## Approach
SQL (SQLite) for all metrics. Queries in `/sql`, written and numbered in order.

## Findings
**Backlog is stale, not just recent.** Tickets still "In Progress" appear in every month, including January: about 400 in total (19 to 45 per moth). Another 18 tickets are "Open" with no first response, 12 of them from December.

**First-response breaches by channel**

| Channel | Tickets | Breaches | Breach rate | 
| --- | --- | --- |
| Chat | 850 | 136 | 16.0% | 
| Email | 1,234 | 114 | 9.2% |
| Phone | 246 | 61 | 24.8% | 

Phone has the worst rate, but Chat produces the most Breaches (136 of 311). Which channel to fix first depends on whether the goal is the rate or the volume. 

*Note: the 18 tickets with no first response are flagged as violated in the source data, so they count as breaches here.*

## Recommendations
_In Progress._
