use db_course_conversions;
select * from student_engagement;
select * from student_info;
select * from student_purchases;

-----------------------------------------------------

SELECT 
	distinct S.student_id
, 	s.date_registered
, 	MIN(se.date_watched) OVER (PARTITION BY se.student_id) first_date_watched
,	MIN(COALESCE(sp.date_purchased, NULL)) OVER (PARTITION BY se.student_id) first_date_purchased
,	DATEDIFF(MIN(se.date_watched) OVER (PARTITION BY se.student_id), s.date_registered) date_diff_reg_watch 
,	IFNULL(DATEDIFF(MIN(COALESCE(sp.date_purchased, NULL)) OVER (PARTITION BY se.student_id), MIN(se.date_watched) OVER (PARTITION BY se.student_id)), NULL) date_diff_watch_purch  
FROM student_info s
JOIN student_engagement se
		ON s.student_id = se.student_id
JOIN student_purchases sp
		ON s.student_id = sp.student_id
WHERE date_diff_watch_purch >= 0;

SELECT F.* FROM (SELECT 
	s.student_id
, 	s.date_registered
, 	MIN(se.date_watched) OVER (PARTITION BY se.student_id) first_date_watched
,	MIN(COALESCE(sp.date_purchased, NULL)) OVER (PARTITION BY se.student_id) first_date_purchased
,	DATEDIFF(MIN(se.date_watched) OVER (PARTITION BY se.student_id), s.date_registered) date_diff_reg_watch 
,	IFNULL(DATEDIFF(MIN(COALESCE(sp.date_purchased, NULL)) OVER (PARTITION BY se.student_id), MIN(se.date_watched) OVER (PARTITION BY se.student_id)), NULL) date_diff_watch_purch  
FROM student_info s
JOIN student_engagement se
		ON s.student_id = se.student_id
JOIN student_purchases sp
		ON s.student_id = sp.student_id)
        AS F
WHERE date_diff_watch_purch >= 0
GROUP BY student_id, date_registered, first_date_watched, first_date_purchased, date_diff_reg_watch, date_diff_watch_purch







SELECT 
    s.student_id,
    s.date_registered,
    MIN(se.date_watched) AS first_date_watched,
    MIN(sp.date_purchased) AS first_date_purchased,
    DATEDIFF(MIN(se.date_watched), s.date_registered) AS date_diff_reg_watch,
    CASE 
        WHEN MIN(sp.date_purchased) IS NOT NULL 
        THEN DATEDIFF(MIN(sp.date_purchased), MIN(se.date_watched))
        ELSE NULL 
    END AS date_diff_watch_purch
FROM student_info s
JOIN student_engagement se 
    ON s.student_id = se.student_id
LEFT JOIN student_purchases sp 
    ON s.student_id = sp.student_id
GROUP BY s.student_id, s.date_registered;
