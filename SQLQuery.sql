
USE Hospital;
GO

-- Q1
SELECT p.Name AS PatientName, w.Name AS WardName
FROM Patients p
INNER JOIN Wards w ON w.Id = p.WardId;

-- Q2
SELECT p.Name AS PatientName, d.DrugCode
FROM DrugAdministrations d
INNER JOIN Patients p ON p.Id = d.PatientId;

-- Q3
SELECT p.Name AS PatientName, c.Name AS ConsultantName
FROM Patients p
INNER JOIN PatientExaminations pe ON pe.PatientId = p.Id
INNER JOIN Consultants c ON c.Id = pe.ConsultantId;

-- Q4
SELECT p.Name AS PatientName, w.Name AS WardName
FROM Patients p
LEFT JOIN Wards w ON w.Id = p.WardId;

-- Q5
SELECT w.Name AS WardName, p.Name AS PatientName
FROM Wards w
LEFT JOIN Patients p ON p.WardId = w.Id;

-- Q6
SELECT c.Name AS ConsultantName, p.Name AS PatientName
FROM Consultants c
LEFT JOIN PatientExaminations pe ON pe.ConsultantId = c.Id
LEFT JOIN Patients p ON p.Id = pe.PatientId;

-- Q7
SELECT w.Name AS WardName, p.Name AS PatientName
FROM Wards w
LEFT JOIN Patients p ON p.WardId = w.Id;

-- Q8
SELECT c.Name AS ConsultantName, pc.PatientId
FROM Consultants c
LEFT JOIN PatientConsultantAssignments pc
    ON pc.ConsultantId = c.Id;

-- Q9
SELECT p.Name AS PatientName, w.Name AS WardName
FROM Patients p
FULL OUTER JOIN Wards w ON w.Id = p.WardId;

-- Q10
SELECT c.Name AS ConsultantName, pc.PatientId
FROM Consultants c
FULL OUTER JOIN PatientConsultantAssignments pc
    ON pc.ConsultantId = c.Id;

-- Q11
SELECT n.Name AS NurseName, m.Name AS ManagerName
FROM Nurses n
LEFT JOIN Nurses m ON m.Number = n.ManagerId;

-- Q12
SELECT n.Name AS NurseName, m.Name AS ManagerName
FROM Nurses n
INNER JOIN Nurses m ON m.Number = n.ManagerId;

-- Q13
SELECT m.Name AS ManagerName, n.Name AS NurseName
FROM Nurses m
LEFT JOIN Nurses n ON n.ManagerId = m.Number
WHERE EXISTS (
    SELECT 1
    FROM Nurses x
    WHERE x.ManagerId = m.Number
);

-- Q14
SELECT p.Name AS PatientName, c.Name AS ConsultantName
FROM Patients p
CROSS JOIN Consultants c;

-- Q15
SELECT w.Name AS WardName, c.Name AS ConsultantName
FROM Wards w
CROSS JOIN Consultants c;

-- Q16
SELECT p.Name AS PatientName,
       w.Name AS WardName,
       c.Name AS ConsultantName
FROM Patients p
INNER JOIN Wards w ON w.Id = p.WardId
INNER JOIN PatientExaminations pe ON pe.PatientId = p.Id
INNER JOIN Consultants c ON c.Id = pe.ConsultantId;

-- Q17
SELECT p.Name AS PatientName,
       n.Name AS NurseName,
       dr.Code AS DrugCode
FROM Patients p
INNER JOIN DrugAdministrations d ON d.PatientId = p.Id
INNER JOIN Drugs dr ON dr.Code = d.DrugCode
INNER JOIN Nurses n ON n.Number = d.NurseId;

-- Q18
SELECT p.Name AS PatientName,
       w.Name AS WardName,
       n.Name AS NurseName,
       dr.Dosage AS DrugDosage
FROM Patients p
LEFT JOIN Wards w ON w.Id = p.WardId
LEFT JOIN DrugAdministrations d ON d.PatientId = p.Id
LEFT JOIN Drugs dr ON dr.Code = d.DrugCode
LEFT JOIN Nurses n ON n.Number = d.NurseId;

-- Q19
SELECT p.Name AS PatientName,
       c.Name AS ConsultantName,
       w.Name AS WardName
FROM Patients p
INNER JOIN PatientExaminations pe ON pe.PatientId = p.Id
INNER JOIN Consultants c ON c.Id = pe.ConsultantId
LEFT JOIN Wards w ON w.Id = p.WardId;

-- Q20
SELECT p.Name AS PatientName,
       n.Name AS NurseName,
       dr.Code AS DrugCode,
       dr.Dosage AS DrugDosage,
       d.[Date] AS AdminDate,
       d.[Time] AS AdminTime
FROM Patients p
INNER JOIN DrugAdministrations d ON d.PatientId = p.Id
INNER JOIN Drugs dr ON dr.Code = d.DrugCode
INNER JOIN Nurses n ON n.Number = d.NurseId;

-- Q21
SELECT c.Name, c.Salary,
       ROW_NUMBER() OVER (
           ORDER BY c.Salary DESC, c.Name
       ) AS RowNum
FROM Consultants c;

-- Q22
SELECT c.Name, c.Salary,
       ROW_NUMBER() OVER (
           ORDER BY c.Salary ASC, c.Name
       ) AS RowNum
FROM Consultants c;

-- Q23
SELECT c.Name, c.Salary,
       ROW_NUMBER() OVER (
           ORDER BY c.Salary ASC, c.Name ASC
       ) AS RowNum
FROM Consultants c;

-- Q24
SELECT c.Name, c.Salary,
       RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryRank
FROM Consultants c;

-- Q25
SELECT c.Name, c.Salary,
       RANK() OVER (
           ORDER BY c.Salary ASC
       ) AS SalaryRank
FROM Consultants c;

-- Q26
SELECT c.Name, c.Salary,
       RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryRank
FROM Consultants c
ORDER BY c.Salary DESC;

-- Q27
SELECT c.Name, c.Salary,
       DENSE_RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryRank
FROM Consultants c;

-- Q28
SELECT c.Name, c.Salary,
       DENSE_RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryRank
FROM Consultants c
ORDER BY c.Salary DESC;

-- Q29
SELECT c.Name, c.Salary,
       RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryRank,
       DENSE_RANK() OVER (
           ORDER BY c.Salary DESC
       ) AS DenseRank
FROM Consultants c;

-- Q30
SELECT c.Name, c.Salary,
       NTILE(2) OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryGroup
FROM Consultants c;

-- Q31
SELECT c.Name, c.Salary,
       NTILE(3) OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryGroup
FROM Consultants c;

-- Q32
SELECT c.Name, c.Salary,
       NTILE(4) OVER (
           ORDER BY c.Salary DESC
       ) AS SalaryGroup
FROM Consultants c
ORDER BY SalaryGroup, c.Salary DESC;

-- Q33
SELECT n.Name, n.ServesInWardId, n.Salary,
       RANK() OVER (
           PARTITION BY n.ServesInWardId
           ORDER BY n.Salary DESC
       ) AS SalaryRank
FROM Nurses n
ORDER BY n.ServesInWardId, n.Salary DESC;

-- Q34
SELECT n.Name, n.ServesInWardId, n.Salary,
       ROW_NUMBER() OVER (
           PARTITION BY n.ServesInWardId
           ORDER BY n.Salary DESC, n.Name
       ) AS RowNum
FROM Nurses n
ORDER BY n.ServesInWardId, n.Salary DESC, n.Name;

-- Q35
SELECT n.Name, n.ServesInWardId, n.Salary,
       DENSE_RANK() OVER (
           PARTITION BY n.ServesInWardId
           ORDER BY n.Salary DESC
       ) AS SalaryRank
FROM Nurses n
ORDER BY n.ServesInWardId, n.Salary DESC;

-- Q36
SELECT n.Name, n.ServesInWardId, n.Salary,
       NTILE(2) OVER (
           PARTITION BY n.ServesInWardId
           ORDER BY n.Salary DESC
       ) AS SalaryGroup
FROM Nurses n
ORDER BY n.ServesInWardId, SalaryGroup;

-- Q37
SELECT n.Name AS NurseName,
       w.Name AS WardName,
       n.Salary,
       RANK() OVER (
           PARTITION BY n.ServesInWardId
           ORDER BY n.Salary DESC
       ) AS SalaryRank
FROM Nurses n
LEFT JOIN Wards w ON w.Id = n.ServesInWardId;

-- Q38
;WITH ConsultantRanks AS (
    SELECT c.Id,
           c.Salary,
           RANK() OVER (
               ORDER BY c.Salary DESC
           ) AS ConsultantRank
    FROM Consultants c
)
SELECT p.Name AS PatientName,
       w.Name AS WardName,
       cr.Salary,
       cr.ConsultantRank
FROM Patients p
LEFT JOIN Wards w ON w.Id = p.WardId
LEFT JOIN PatientExaminations pe ON pe.PatientId = p.Id
LEFT JOIN ConsultantRanks cr ON cr.Id = pe.ConsultantId;

-- Q39
;WITH NurseRanks AS (
    SELECT n.Number,
           n.Name,
           n.ServesInWardId,
           n.Salary,
           RANK() OVER (
               PARTITION BY n.ServesInWardId
               ORDER BY n.Salary DESC
           ) AS NurseRank
    FROM Nurses n
)
SELECT p.Name AS PatientName,
       nr.Name AS NurseName,
       da.Dosage,
       nr.NurseRank
FROM Patients p
LEFT JOIN DrugAdministrations da ON da.PatientId = p.Id
LEFT JOIN NurseRanks nr ON nr.Number = da.NurseId;