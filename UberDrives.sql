--NOTES:
--CHECKED AND SAW THE NULL/BLANK CELLS UNDER 'PROCEDURE', UPDATED TO SAY 'NONE'
--KARACHI WAS ORIGINALLY 'KAR?CHI', DEDUCED THAT IT WAS KARACHI, PAKISTAN AFTER GOOGLING RUN_STOP DESTINATION OF SEVERAL OTHER CELLS. UPDATED TO FIX
--Rawalpindi WAS ORIGINALLY 'R?walpindi', UPDATED TO FIX. 
--HAD TO SEPARATE DATE AND TIME ON EXCEL, UPON SEPARATION DECIDED TO ONLY HAVE ONE COLUMN FOR DATE AND TWO FOR TIME.


--MILES SUM, TOTAL MILES VS PURPOSE, DISTINCT PURPOSE, MILES VS CATEGORY

--TOTAL MILES GRAPHS - TO ADD TO TABLEAU

Select *
FROM UberDrives

--TOTAL MILES ALLTOGETHER
SELECT SUM(Miles) as TotalMiles
FROM UberDrives

--TOTAL MILES PER PURPOSE IN NEW YORK
SELECT Purpose, SUM(Miles) as TotalMilesPerProcedureNY
FROM UberDrives
WHERE 
Start_Location <> 'Islamabad' AND 
Start_Location <> 'Rawalpindi' AND
Start_Location <> 'Noorpur Shahan' AND
Start_Location <> 'Lahore' AND
Start_Location <> 'Karachi' AND
Start_Location <> 'Katunayake' AND
Start_Location <> 'Gampaha' AND
Start_Location <> 'Ilukwatta'
--Start_Location <> 'Unknown Location' AND
--End_Location <> 'Unknown Location'
--Where Start_Location/End_Location DOES NOT equal to Pakistan and Sri Lanka. Without End_Location not included since Pakistan/Sri Lankan Start_Location will always be Pakistan/Sri Lankan End_Location
GROUP BY Purpose
ORDER BY TotalMilesPerProcedureNY DESC
--Total: 10967.7 miles


--TOTAL MILES PER PURPOSE IN PAKISTAN AND SRI LANKA
SELECT Purpose, SUM(Miles) as TotalMilesPerProcedurePakistan
FROM UberDrives
WHERE 
Start_Location = 'Islamabad' OR
Start_Location = 'Rawalpindi' OR
Start_Location = 'Noorpur Shahan' OR
Start_Location = 'Lahore' OR
Start_Location = 'Karachi' OR
Start_Location = 'Katunayake' OR
Start_Location = 'Gampaha' OR
Start_Location = 'Ilukwatta'
--Where Start_Location/End_Location equals to Pakistan and Sri Lanka .
GROUP BY Purpose
ORDER BY TotalMilesPerProcedurePakistan DESC
--Total: 1237 miles


--UKNOWN LOCATION TOTAL MILES PER PURPOSE

SELECT Purpose, SUM(Miles) as OnlyEndMilesUnknown
FROM UberDrives
WHERE 
End_Location = 'Unknown Location' OR
Start_Location = 'Unknown Location'
GROUP BY Purpose
ORDER BY OnlyEndMilesUnknown DESC
--ONLY GOING TO SELECT THE START/END_LOCATIONS THAT HAVE UNKNOWN LOCATION

--LOCATIONS IN NY AND PAKISTAN AND SRI LANKA WHERE END/START ARE COMBINED

--NEW YORK LOCATIONS ONLY COMBINED
SELECT Start_Location as NewYorkLocationsCombined
FROM UberDrives
WHERE
Start_Location <> 'Islamabad' AND
Start_Location <> 'Rawalpindi' AND 
Start_Location <> 'Noorpur Shahan' AND
Start_Location <> 'Lahore' AND
Start_Location <> 'Karachi' AND
Start_Location <> 'Katunayake' AND
Start_Location <> 'Gampaha' AND
Start_Location <> 'Ilukwatta'AND
Start_Location <> 'Unknown Location'
UNION
SELECT End_Location
FROM UberDrives
WHERE
End_Location <> 'Islamabad' AND
End_Location <> 'Rawalpindi' AND
End_Location <> 'Noorpur Shahan' AND
End_Location <> 'Lahore' AND
End_Location <> 'Karachi' AND
End_Location <> 'Katunayake' AND
End_Location <> 'Gampaha' AND
End_Location <> 'Ilukwatta'AND
End_Location <> 'Unknown Location'



--PAKISTAN AND SRI LANKAN LOCATIONS ONLY
SELECT Start_Location as PakistanLocationsCombined
FROM UberDrives
WHERE
Start_Location = 'Islamabad' OR 
Start_Location = 'Rawalpindi' OR 
Start_Location = 'Noorpur Shahan' OR 
Start_Location = 'Lahore' OR 
Start_Location = 'Karachi'OR
Start_Location = 'Katunayake' OR
Start_Location = 'Gampaha' OR
Start_Location = 'Ilukwatta'
UNION
SELECT End_Location
FROM UberDrives
WHERE
End_Location = 'Islamabad' OR 
End_Location = 'Rawalpindi' OR 
End_Location = 'Noorpur Shahan' OR 
End_Location = 'Lahore' OR 
End_Location = 'Karachi'OR
End_Location = 'Katunayake' OR
End_Location = 'Gampaha' OR
End_Location = 'Ilukwatta'

--DISTINCT PURPOSE
--'Not Specified' originally null/blank in Excel

SELECT DISTINCT(Purpose)
FROM UberDrives

--MILES IN RELATION TO PURPOSE IN NY, PAKISTAN, SRI-LANKA, UNKNOWN.
--
SELECT Purpose, SUM(Miles) as TotalPurposeMiles, count(Miles) as TotalPurposeRuns
FROM UberDrives
GROUP BY Purpose
ORDER BY TotalPurposeMiles DESC

--LOCATION VS MILES
SELECT DISTINCT(Start_Location)
FROM UberDrives

SELECT DISTINCT(End_Location)
FROM UberDrives

SELECT DISTINCT(Start_Location), SUM(Miles) as TotalMilesPerStartLocation
FROM UberDrives
GROUP BY Start_Location
ORDER BY TotalMilesPerStartLocation DESC

--CORRECT TOTAL START LOCATION COUNT CHECK 175:175

SELECT DISTINCT(End_Location), SUM(Miles) as TotalMilesPerEndLocation
FROM UberDrives
GROUP BY End_Location
ORDER BY TotalMilesPerEndLocation DESC
--CORRECT TOTAL END LOCATION COUNT CHECK 186:186

--TOTAL LOCATION VISITS

SELECT Start_Location, count(start_location) as TotalNYStartVisits 
FROM UberDrives
WHERE 
Start_Location <> 'Islamabad' AND 
Start_Location <> 'Rawalpindi' AND
Start_Location <> 'Noorpur Shahan' AND
Start_Location <> 'Lahore' AND
Start_Location <> 'Karachi' AND
Start_Location <> 'Katunayake' AND
Start_Location <> 'Gampaha' AND
Start_Location <> 'Unknown Location' AND
Start_Location <> 'Ilukwatta'
GROUP BY Start_Location 
ORDER BY TotalNYStartVisits DESC
--WHERE START_LOCATION IS NOT EQUAL TO LOCATIONS IN PAKISTAN, SRI LANKA and Unknown

SELECT End_Location, count(End_Location) as TotalNYEndVisits 
FROM UberDrives
WHERE 
End_Location <> 'Islamabad' AND 
End_Location <> 'Rawalpindi' AND
End_Location <> 'Noorpur Shahan' AND
End_Location <> 'Lahore' AND
End_Location <> 'Karachi' AND
End_Location <> 'Katunayake' AND
End_Location <> 'Gampaha' AND
End_Location <> 'Unknown Location' AND
End_Location <> 'Ilukwatta'
GROUP BY End_Location 
ORDER BY TotalNYEndVisits DESC
--WHERE END_LOCATION IS NOT EQUAL TO LOCATIONS IN PAKISTAN, SRI LANKA and Unknown

SELECT Start_Location, count(start_location) as TotalPakistanStartVisits 
FROM UberDrives
WHERE 
Start_Location = 'Islamabad' OR 
Start_Location = 'Rawalpindi' OR
Start_Location = 'Noorpur Shahan' OR
Start_Location = 'Lahore' OR
Start_Location = 'Karachi'
GROUP BY Start_Location 
ORDER BY TotalPakistanStartVisits DESC
--WHERE START_LOCATION IS EQUAL TO LOCATIONS IN PAKISTAN

SELECT End_Location, count(End_Location) as TotalPakistanEndVisits 
FROM UberDrives
WHERE 
End_Location = 'Islamabad' OR
End_Location = 'Rawalpindi' OR
End_Location = 'Noorpur Shahan' OR
End_Location = 'Lahore' OR
End_Location = 'Karachi'
GROUP BY End_Location 
ORDER BY TotalPakistanEndVisits DESC
--WHERE END_LOCATION IS EQUAL TO LOCATIONS IN PAKISTAN

SELECT Start_Location, count(start_location) as TotalSriStartVisits 
FROM UberDrives
WHERE 
Start_Location = 'Katunayake' OR
Start_Location = 'Gampaha' OR
Start_Location = 'Ilukwatta'
GROUP BY Start_Location 
ORDER BY TotalSriStartVisits DESC
--WHERE START_LOCATION IS EQUAL TO LOCATIONS IN SRI LANKA

SELECT End_Location, count(End_Location) as TotalSriEndVisits 
FROM UberDrives
WHERE 
End_Location = 'Katunayake' OR
End_Location = 'Gampaha' OR
End_Location = 'Ilukwatta'
GROUP BY End_Location 
ORDER BY TotalSriEndVisits DESC
--WHERE END_LOCATION IS EQUAL TO LOCATIONS SRI LANKA

SELECT Start_Location, count(Start_location) as UnknownStartVisits 
FROM UberDrives
WHERE 
Start_Location = 'Unknown Location' 
GROUP BY Start_Location 
ORDER BY UnknownStartVisits DESC
--WHERE START LOCATION IS UNKNOWN

SELECT End_Location, count(End_location) as UnknownEndVisits 
FROM UberDrives
WHERE 
End_Location = 'Unknown Location' 
GROUP BY End_Location
ORDER BY UnknownEndVisits DESC
--WHERE END LOCATION IS UNKNOWN

--TOTAL RUNS PER CATEGORY

SELECT DISTINCT(Category), COUNT(Category) as CategoryRuns
FROM UberDrives
GROUP BY Category
ORDER BY CategoryRuns