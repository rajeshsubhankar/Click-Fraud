USE click_fraud;
DELIMITER $$
DROP FUNCTION IF EXISTS fn$$
CREATE FUNCTION fn(id VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM test_table
	WHERE partnerid=id;

	RETURN @cnt;

END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameIpCount$$
CREATE FUNCTION MaxSameIpCount(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(ipcount) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS ipcount
	FROM test_table
	WHERE partnerid=pid
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanIplong$$
CREATE FUNCTION CalMeanIplong(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM test_table
	WHERE partnerid=pid
	GROUP BY iplong) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS IpVariance$$
CREATE FUNCTION IpVariance(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SET @data=CalMeanIplong(pid);

	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-@data,2) AS items
	FROM test_table
	WHERE partnerid=pid
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickAtMorning$$
CREATE FUNCTION AvgClickAtMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickAtAfternoon$$
CREATE FUNCTION AvgClickAtAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickAtEvening$$
CREATE FUNCTION AvgClickAtEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickAtNight$$
CREATE FUNCTION AvgClickAtNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickAtMorning$$
CREATE FUNCTION MaxClickAtMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickAtAfternoon$$
CREATE FUNCTION MaxClickAtAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickAtEvening$$
CREATE FUNCTION MaxClickAtEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickAtNight$$
CREATE FUNCTION MaxClickAtNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS SkewAtMorning$$
CREATE FUNCTION SkewAtMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	 GROUP BY DATE(timeat) ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	 GROUP BY DATE(timeat) ) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$



DELIMITER $$
DROP FUNCTION IF EXISTS SkewAtAfternoon$$
CREATE FUNCTION SkewAtAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	 GROUP BY DATE(timeat) ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	 GROUP BY DATE(timeat) ) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$



DELIMITER $$
DROP FUNCTION IF EXISTS SkewAtEvening$$
CREATE FUNCTION SkewAtEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	 GROUP BY DATE(timeat) ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	 GROUP BY DATE(timeat) ) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS SkewAtNight$$
CREATE FUNCTION SkewAtNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	 GROUP BY DATE(timeat) ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_08mar12 WHERE partnerid=pid
	 AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	 GROUP BY DATE(timeat) ) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeatMorning$$
CREATE FUNCTION CalMeanTimeatMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '05:00:00' AND '11:59:59'
	GROUP BY DATE(timeat) ) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeatAfternoon$$
CREATE FUNCTION CalMeanTimeatAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY DATE(timeat) ) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeatEvening$$
CREATE FUNCTION CalMeanTimeatEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY DATE(timeat) ) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeatNight$$
CREATE FUNCTION CalMeanTimeatNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY DATE(timeat) ) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;


DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVarianceAtMorning$$
CREATE FUNCTION TimeatVarianceAtMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SET @data=CalMeanTimeatMorning(pid);

	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-@data,2) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '05:00:00' AND '11:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$



DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVarianceAtAfternoon$$
CREATE FUNCTION TimeatVarianceAtAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SET @data=CalMeanTimeatAfternoon(pid);

	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-@data,2) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$



DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVarianceAtEvening$$
CREATE FUNCTION TimeatVarianceAtEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SET @data=CalMeanTimeatEvening(pid);

	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-@data,2) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$



DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVarianceAtNight$$
CREATE FUNCTION TimeatVarianceAtNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SET @data=CalMeanTimeatNight(pid);

	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-@data,2) AS items
	FROM clicks_08mar12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY DATE(timeat) ) AS newTable;

	RETURN @cnt;
END$$
DELIMITER ;





SELECT 'partnerid','AvgClickAtMorning','AvgClickAtAfternoon','AvgClickAtEvening','AvgClickAtNight','MaxClickAtMorning','MaxClickAtAfternoon','MaxClickAtEvening','MaxClickAtNight'
,'SkewAtMorning','SkewAtAfternoon','SkewAtEvening','SkewAtNight','TimeatVarianceAtMorning','TimeatVarianceAtAfternoon','TimeatVarianceAtEvening','TimeatVarianceAtNight','status' UNION 
select partnerid,AvgClickAtMorning(partnerid),AvgClickAtAfternoon(partnerid),AvgClickAtEvening(partnerid),AvgClickAtNight(partnerid),MaxClickAtMorning(partnerid) ,MaxClickAtAfternoon(partnerid) 
,MaxClickAtEvening(partnerid) ,MaxClickAtNight(partnerid) ,SkewAtMorning(partnerid),SkewAtAfternoon(partnerid),SkewAtEvening(partnerid),SkewAtNight(partnerid),TimeatVarianceAtMorning(partnerid)
,TimeatVarianceAtAfternoon(partnerid),TimeatVarianceAtEvening(partnerid),TimeatVarianceAtNight(partnerid),status
FROM publishers_08mar12
INTO OUTFILE '/tmp/test(timeat_morning)_08mar12.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'; 

