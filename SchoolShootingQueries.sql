--This query counts the total amount of school shootings in America 
SELECT COUNT(incident_id) 
FROM Incident

--This query counts the amount of school shootings by state
SELECT COUNT(incident_id) , State
FROM incident 
GROUP BY state 
ORDER BY 1 DESC 

--This query counts the amount of school shootings by city
SELECT COUNT(incident_id), city, state
FROM incident 
GROUP BY city 
ORDER BY 1 DESC 

--This query looks at school shooters by gender 
SELECT COUNT(gender), gender 
FROM shooter
GROUP BY gender 
ORDER BY 1 DESC 

--This query counts the amount of victims by state 
SELECT COUNT(v.incidentid), i.state
FROM incident i
JOIN victim v 
ON i.incident_id = v.incidentid 
GROUP BY i.state
ORDER BY 1 DESC 


SELECT *
FROM incident i 
JOIN shooter s 
ON i.incident_id = s.incidentid 
JOIN victim v
ON s.IncidentID = v.IncidentID
JOIN weapon w
ON v.incidentid = w.incidentid
