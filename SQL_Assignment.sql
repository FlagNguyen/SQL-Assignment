/*================================================*/

/* III. QUERY */


 /********* A. BASIC QUERY *********/

-- 1. Li?t k� danh s�ch sinh vi�n s?p x?p theo th? t?:
--      a. id t?ng d?n

SELECT *
FROM student s
ORDER BY s.id; 

--      b. gi?i t�nh
SELECT *
FROM student s
ORDER BY s.gender; 

--      c. ng�y sinh T?NG D?N v� h?c b?ng GI?M D?N
SELECT * 
FROM student s
ORDER BY s.birthday , s.scholarship DESC;

-- 2. M�n h?c c� t�n b?t ??u b?ng ch? 'T'
SELECT * 
FROM subject sj
WHERE sj.name LIKE 'T%';

-- 3. Sinh vi�n c� ch? c�i cu?i c�ng trong t�n l� 'i'
SELECT * 
FROM subject sj
WHERE sj.name LIKE '%i';

-- 4. Nh?ng khoa c� k� t? th? hai c?a t�n khoa c� ch?a ch? 'n'
SELECT *
FROM faculty f
WHERE f.name LIKE '_n%';

-- 5. Sinh vi�n trong t�n c� t? 'Th?'
SELECT * 
FROM student s
WHERE s.name LIKE '%Th?%';

-- 6. Sinh vi�n c� k� t? ??u ti�n c?a t�n n?m trong kho?ng t? 'a' ??n 'm', s?p x?p theo h? t�n sinh vi�n
SELECT *
FROM student s
Where s.name BETWEEN 'A%' and 'M%'
ORDER BY s.name;

-- 7. Sinh vi�n c� h?c b?ng l?n h?n 100000, s?p x?p theo m� khoa gi?m d?n
SELECT * 
FROM student s
WHERE s.scholarship > 100000
ORDER BY s.faculty_id DESC;

-- 8. Sinh vi�n c� h?c b?ng t? 150000 tr? l�n v� sinh ? H� N?i
SELECT *
FROM student s
WHERE s.scholarship > 150000 
AND s.hometown = 'H� N?i';

-- 9. Nh?ng sinh vi�n c� ng�y sinh t? ng�y 01/01/1991 ??n ng�y 05/06/1992
SELECT *
FROM student s
WHERE s.birthday BETWEEN TO_DATE('01/01/1991','MM/DD/YYYY') AND TO_DATE('06/05/1992','MM/DD/YYYY');

-- 10. Nh?ng sinh vi�n c� h?c b?ng t? 80000 ??n 150000
SELECT * 
FROM student s
WHERE s.scholarship BETWEEN 80000 AND 150000;

-- 11. Nh?ng m�n h?c c� s? ti?t l?n h?n 30 v� nh? h?n 45
SELECT *
FROM subject sj
WHERE sj.lesson_quantity BETWEEN 30 and 45;

-------------------------------------------------------------------

/********* B. CALCULATION QUERY *********/

-- 1. Cho bi?t th�ng tin v? m?c h?c b?ng c?a c�c sinh vi�n, g?m: M� sinh vi�n, Gi?i t�nh, M� 
-- khoa, M?c h?c b?ng. Trong ?�, m?c h?c b?ng s? hi?n th? l� �H?c b?ng cao� n?u gi� tr? 
-- c?a h?c b?ng l?n h?n 500,000 v� ng??c l?i hi?n th? l� �M?c trung b�nh�.

SELECT s.id, s.gender, s.faculty_id, s.scholarship,
CASE 
When s.scholarship > 50000 then 'H?c b?ng cao'
ELSE 'M?c trung b�nh'
END as "M?c H?c B?ng"

FROM student s;


-- 2. T�nh t?ng s? sinh vi�n c?a to�n tr??ng
SELECT COUNT(*) as "T?ng s? SV"
FROM student;

-- 3. T�nh t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n?.
SELECT s.gender, COUNT(s.id) as "Number"
FROM student s 
GROUP BY s.gender;

-- 4. T�nh t?ng s? sinh vi�n t?ng khoa
SELECT f.name, COUNT(s.id) as "T?ng SV Theo Khoa"
FROM student s,faculty f
WHERE s.faculty_id = f.id
GROUP BY f.name;

-- 5. T�nh t?ng s? sinh vi�n c?a t?ng m�n h?c
SELECT sj.name, COUNT (e.student_id) as "T?ng SV Theo M�n"
FROM exam_management e, subject sj
WHERE e.subject_id = sj.id
GROUP BY sj.name;

-- 6. T�nh s? l??ng m�n h?c m� sinh vi�n ?� h?c
SELECT s.name, COUNT(e.subject_id) as "S? M�n ?� H?c"
FROM exam_management e, student s
WHERE s.id = e.student_id
GROUP BY s.name;

-- 7. T?ng s? h?c b?ng c?a m?i khoa	
SELECT f.name, COUNT(*) as "S? H?c B?ng"
FROM student s, faculty f
WHERE s.faculty_id = f.id
GROUP BY f.name;

-- 8. Cho bi?t h?c b?ng cao nh?t c?a m?i khoa
SELECT f.name, MAX(s.scholarship) as "H?c B?ng Cao Nh?t"
FROM student s, faculty f
WHERE s.faculty_id = f.id
GROUP BY f.name;

-- 9. Cho bi?t t?ng s? sinh vi�n nam v� t?ng s? sinh vi�n n? c?a m?i khoa
SELECT f.name,
SUM(CASE s.gender when N'Nam' then 1 else 0 end)"T?ng s? Nam",
SUM(CASE s.gender when N'N?' then 1 else 0 end)"T?ng s? N?"
FROM student s, faculty f
WHERE s.faculty_id = f.id
GROUP BY f.name;

-- 10. Cho bi?t s? l??ng sinh vi�n theo t?ng ?? tu?i
SELECT s.birthday, COUNT(*)"S? SV"
FROM student s
GROUP BY s.birthday;

-- 11. Cho bi?t nh?ng n?i n�o c� �t nh?t 2 sinh vi�n ?ang theo h?c t?i tr??ng
SELECT s.hometown, COUNT(s.id)"T?ng SV"
FROM student s
GROUP BY s.hometown
HAVING COUNT(s.id)>=2;

-- 12. Cho bi?t nh?ng sinh vi�n thi l?i �t nh?t 2 l?n
SELECT e.student_id,s.name,e.subject_id
FROM student s, exam_management e
WHERE s.id = e.student_id
GROUP BY e.student_id,s.name,e.subject_id
HAVING COUNT(e.number_of_exam_taking) >= 2;

-- 13. Cho bi?t nh?ng sinh vi�n nam c� ?i?m trung b�nh l?n 1 tr�n 7.0 
SELECT *
FROM student s, exam_management e
WHERE s.id = e.student_id and s.gender = 'Nam' and e.number_of_exam_taking = 1 and e.mark >= 7;

-- 14. Cho bi?t danh s�ch c�c sinh vi�n r?t �t nh?t 2 m�n ? l?n thi 1 (r?t m�n l� ?i?m thi c?a m�n kh�ng qu� 4 ?i?m)
SELECT e.student_id,s.name, COUNT(e.subject_id)"S? M�n Thi L?i"
FROM student s, exam_management e
WHERE s.id = e.student_id and e.number_of_exam_taking =1 and e.mark <=4
GROUP BY e.student_id,s.name
HAVING COUNT (e.subject_id) >=2;

-- 15. Cho bi?t danh s�ch nh?ng khoa c� nhi?u h?n 2 sinh vi�n nam
SELECT s.faculty_id, COUNT(s.id)"S? SV Nam"
FROM student s
WHERE s.gender = 'Nam'
GROUP BY s.faculty_id
HAVING COUNT(s.id) >=2;

-- 16. Cho bi?t nh?ng khoa c� 2 sinh vi�n ??t h?c b?ng t? 200000 ??n 300000
SELECT s.faculty_id, COUNT(s.id)"S? SV"
FROM student s
WHERE s.scholarship BETWEEN 200000 and 300000
GROUP BY s.faculty_id
HAVING COUNT(s.id)>=2;

-- 17. Cho bi?t sinh vi�n n�o c� h?c b?ng cao nh?t
SELECT *
FROM student s
WHERE s.scholarship = (SELECT MAX(s.scholarship)FROM student s);

-------------------------------------------------------------------

/********* C. DATE/TIME QUERY *********/

-- 1. Sinh vi�n c� n?i sinh ? H� N?i v� sinh v�o th�ng 02
SELECT *
FROM student s
WHERE s.hometown = 'H� N?i' and TO_CHAR(s.birthday,'MM') = 02;

-- 2. Sinh vi�n c� tu?i l?n h?n 20
SELECT *
FROM student s
WHERE 2022 - TO_NUMBER(TO_CHAR(s.birthday,'YYYY')) >20;

-- 3. Sinh vi�n sinh v�o m�a xu�n n?m 1990
SELECT *
FROM student s
WHERE TO_NUMBER(TO_CHAR(s.birthday,'YYYY')) = 1990 
AND TO_NUMBER(TO_CHAR(s.birthday,'MM')) >= 1 
AND TO_NUMBER(TO_CHAR(s.birthday,'MM')) <= 4;

-------------------------------------------------------------------


/********* D. JOIN QUERY *********/

-- 1. Danh s�ch c�c sinh vi�n c?a khoa ANH V?N v� khoa V?T L�
SELECT *
FROM faculty f inner join student s on s.faculty_id = f.id
WHERE f.name like 'Anh - V?n' or f.name like 'V?t l�';

-- 2. Nh?ng sinh vi�n nam c?a khoa ANH V?N v� khoa TIN H?C
SELECT *
FROM faculty f inner join student s on s.faculty_id = f.id
WHERE s.gender = 'Nam' and
(f.name like 'Anh - V?n' or f.name like 'V?t l�');

-- 3. Cho bi?t sinh vi�n n�o c� ?i?m thi l?n 1 m�n c? s? d? li?u cao nh?t
SELECT s.name, sj.name,e.mark,e.number_of_exam_taking"S? L?n"
FROM student s, exam_management e, subject sj
WHERE s.id = e.student_id and sj.id = e.subject_id 
and e.number_of_exam_taking = 1
and sj.name = 'C? s? d? li?u'
and e.mark = (SELECT MAX (e.mark)
FROM exam_management e, subject sj
WHERE sj.id = e.subject_id 
and sj.name = 'C? s? d? li?u' and e.number_of_exam_taking = 1
);

-- 4. Cho bi?t sinh vi�n khoa anh v?n c� tu?i l?n nh?t.
--SELECT *
--FROM student s
--WHERE s.faculty_id = '1' and s.birthday = (
--SELECT min s.birthday
--FROM student s
--WHERE s.faculty = '1'
--);

-- 5. Cho bi?t khoa n�o c� ?�ng sinh vi�n nh?t
SELECT f.name
FROM student s, faculty f
WHERE s.faculty_id = f.id
GROUP BY f.name
HAVING COUNT(f.name) >= ALL(SELECT COUNT(s.id)
FROM student s
GROUP BY s.faculty_id
);

-- 6. Cho bi?t khoa n�o c� ?�ng n? nh?t
SELECT f.name
FROM student s, faculty f
WHERE s.faculty_id = f.id and s.gender = 'N?'
GROUP BY f.name
HAVING COUNT(f.name)>= ALL(SELECT COUNT(s.id)
FROM student s
WHERE s.gender = 'N?'
GROUP BY s.faculty_id
);

-- 7. Cho bi?t nh?ng sinh vi�n ??t ?i?m cao nh?t trong t?ng m�n
SELECT e.student_id,e.subject_id,e.mark
FROM exam_management e, 
    (SELECT e.subject_id, max(e.mark)"Highest"
    FROM exam_management e
    GROUP BY e.subject_id) a
WHERE e.subject_id = a.subject_id and e.mark = a."Highest";

-- 8. Cho bi?t nh?ng khoa kh�ng c� sinh vi�n h?c
SELECT *
FROM faculty f
WHERE NOT EXISTS (
SELECT DISTINCT f.id
FROM exam_management e, student s
WHERE e.student_id = s.id
and e.subject_id = f.id)
;

-- 9. Cho bi?t sinh vi�n ch?a thi m�n c? s? d? li?u
SELECT *
FROM student s
WHERE NOT EXISTS
(SELECT DISTINCT *
FROM exam_management e
WHERE e.subject_id = '1' and s.id = e.student_id);

-- 10. Cho bi?t sinh vi�n n�o kh�ng thi l?n 1 m� c� d? thi l?n 2
SELECT e1.student_id
FROM exam_management e1
WHERE e.number_of_exam_taking = 2 and NOT EXISTS (
SELECT e.student_id
FROM exam_management e
WHERE e.number_of_exam_taking = 1 and  e.student_id = e1.student_id
);
