
DELIMITER $$
DROP FUNCTION IF EXISTS myfun$$
CREATE FUNCTION myfun(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

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
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueIp$$
CREATE FUNCTION NoOfUniqueIp(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(iplong)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS IpClickRatio$$
CREATE FUNCTION IpClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(iplong))/COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

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
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY iplong) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanAgent$$
CREATE FUNCTION CalMeanAgent(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY agent) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanCid$$
CREATE FUNCTION CalMeanCid(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cid) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanCntr$$
CREATE FUNCTION CalMeanCntr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cntr) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeat1Min$$
CREATE FUNCTION CalMeanTimeat1Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 60) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;	




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeat5Min$$
CREATE FUNCTION CalMeanTimeat5Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 300) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;	




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeat3Hr$$
CREATE FUNCTION CalMeanTimeat3Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;	




DELIMITER $$
DROP FUNCTION IF EXISTS CalMeanTimeat6Hr$$
CREATE FUNCTION CalMeanTimeat6Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM
	(SELECT COUNT(*) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600) AS NewTable;

	RETURN @cnt;
END$$

DELIMITER ;	



DELIMITER $$
DROP FUNCTION IF EXISTS IpVariance$$
CREATE FUNCTION IpVariance(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanIplong(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameAgentCount$$
CREATE FUNCTION MaxSameAgentCount(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(agent_cnt) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS agent_cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueAgent$$
CREATE FUNCTION NoOfUniqueAgent(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(agent)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS AgentClickRatio$$
CREATE FUNCTION AgentClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(agent))/COUNT(agent) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS AgentVariance$$
CREATE FUNCTION AgentVariance(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanAgent(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCidCount$$
CREATE FUNCTION MaxSameCidCount(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cid_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cid_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCid$$
CREATE FUNCTION NoOfUniqueCid(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cid)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CidClickRatio$$
CREATE FUNCTION CidClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cid))/COUNT(cid) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CidVariance$$
CREATE FUNCTION CidVariance(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanCid(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCntrCount$$
CREATE FUNCTION MaxSameCntrCount(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cntr_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cntr_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCntr$$
CREATE FUNCTION NoOfUniqueCntr(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cntr)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CntrClickRatio$$
CREATE FUNCTION CntrClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cntr))/COUNT(cntr) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS CntrVariance$$
CREATE FUNCTION CntrVariance(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanCntr(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TotalClicks$$
CREATE FUNCTION TotalClicks(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueReferer$$
CREATE FUNCTION NoOfUniqueReferer(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(referer)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS RefererClickRatio$$
CREATE FUNCTION RefererClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(referer))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS NonRefererClickRatio$$
CREATE FUNCTION NonRefererClickRatio(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT (COUNT(*)-COUNT(DISTINCT(referer)))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid;

	RETURN @cnt;
END$$

DELIMITER ;






DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickPer1Min$$
CREATE FUNCTION AvgClickPer1Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 60) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;





DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickPer5Min$$
CREATE FUNCTION AvgClickPer5Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 300) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickPer3Hr$$
CREATE FUNCTION AvgClickPer3Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AvgClickPer6Hr$$
CREATE FUNCTION AvgClickPer6Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT avg(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickPer1Min$$
CREATE FUNCTION MaxClickPer1Min(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 60) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;





DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickPer5Min$$
CREATE FUNCTION MaxClickPer5Min(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 300) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickPer3Hr$$
CREATE FUNCTION MaxClickPer3Hr(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxClickPer6Hr$$
CREATE FUNCTION MaxClickPer6Hr(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(click_min) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS click_min
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVariance1Min$$
CREATE FUNCTION TimeatVariance1Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanTimeat1Min(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 60) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVariance5Min$$
CREATE FUNCTION TimeatVariance5Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanTimeat5Min(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 300) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVariance3Hr$$
CREATE FUNCTION TimeatVariance3Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanTimeat3Hr(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TimeatVariance6Hr$$
CREATE FUNCTION TimeatVariance6Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT AVG(items) INTO @cnt
	FROM 
	(SELECT POW(COUNT(*)-CalMeanTimeat6Hr(pid),2) AS items
	FROM clicks_09feb12
	WHERE partnerid=pid
	GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS Skew1Min$$
CREATE FUNCTION Skew1Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 60 ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 60) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS Skew5Min$$
CREATE FUNCTION Skew5Min(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 300 ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 300) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS Skew3Hr$$
CREATE FUNCTION Skew3Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800 ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 10800) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS Skew6Hr$$
CREATE FUNCTION Skew6Hr(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT SUM((qty-mean)*pow(qty-mean,2) / (N*sigma*pow(sigma,2))) INTO @cnt
	FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600 ) s , 
        (SELECT AVG(qty) AS mean, STDDEV(qty) AS sigma, COUNT(qty) AS N
	 FROM
	(SELECT COUNT(*) AS qty FROM clicks_09feb12 WHERE partnerid=pid
	 GROUP BY UNIX_TIMESTAMP(timeat) DIV 21600) AS newTable)
	AS newTable2;


	RETURN @cnt;
END$$

DELIMITER ;

SELECT 'partnerid','NoOfUniqueIp','status' UNION
SELECT partnerid,NoOfUniqueIp(partnerid),status
FROM publishers_09feb12
INTO OUTFILE '/tmp/train2_09mar12.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

