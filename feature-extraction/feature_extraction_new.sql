USE click_fraud;

DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameIpCountMorning$$
CREATE FUNCTION MaxSameIpCountMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(ipcount) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS ipcount
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '05:00:00' AND '11:59:59'
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameIpCountAfternoon$$
CREATE FUNCTION MaxSameIpCountAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(ipcount) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS ipcount
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameIpCountEvening$$
CREATE FUNCTION MaxSameIpCountEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(ipcount) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS ipcount
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameIpCountNight$$
CREATE FUNCTION MaxSameIpCountNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(ipcount) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS ipcount
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY iplong) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueIpMorning$$
CREATE FUNCTION NoOfUniqueIpMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(iplong)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueIpAfternoon$$
CREATE FUNCTION NoOfUniqueIpAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(iplong)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueIpEvening$$
CREATE FUNCTION NoOfUniqueIpEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(iplong)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueIpNight$$
CREATE FUNCTION NoOfUniqueIpNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(iplong)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS IpClickRatioMorning$$
CREATE FUNCTION IpClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(iplong))/COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS IpClickRatioAfternoon$$
CREATE FUNCTION IpClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(iplong))/COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS IpClickRatioEvening$$
CREATE FUNCTION IpClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(iplong))/COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS IpClickRatioNight$$
CREATE FUNCTION IpClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(iplong))/COUNT(iplong) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameAgentCountMorning$$
CREATE FUNCTION MaxSameAgentCountMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(agent_cnt) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS agent_cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameAgentCountAfternoon$$
CREATE FUNCTION MaxSameAgentCountAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(agent_cnt) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS agent_cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameAgentCountEvening$$
CREATE FUNCTION MaxSameAgentCountEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(agent_cnt) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS agent_cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameAgentCountNight$$
CREATE FUNCTION MaxSameAgentCountNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(agent_cnt) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS agent_cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY agent) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueAgentMorning$$
CREATE FUNCTION NoOfUniqueAgentMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(agent)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueAgentAfternoon$$
CREATE FUNCTION NoOfUniqueAgentAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(agent)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueAgentEvening$$
CREATE FUNCTION NoOfUniqueAgentEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(agent)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueAgentNight$$
CREATE FUNCTION NoOfUniqueAgentNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(agent)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AgentClickRatioMorning$$
CREATE FUNCTION AgentClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(agent))/COUNT(agent) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AgentClickRatioAfternoon$$
CREATE FUNCTION AgentClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(agent))/COUNT(agent) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AgentClickRatioEvening$$
CREATE FUNCTION AgentClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(agent))/COUNT(agent) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS AgentClickRatioNight$$
CREATE FUNCTION AgentClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(agent))/COUNT(agent) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCidCountMorning$$
CREATE FUNCTION MaxSameCidCountMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cid_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cid_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCidCountAfternoon$$
CREATE FUNCTION MaxSameCidCountAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cid_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cid_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCidCountEvening$$
CREATE FUNCTION MaxSameCidCountEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cid_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cid_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCidCountNight$$
CREATE FUNCTION MaxSameCidCountNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cid_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cid_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY cid) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCidMorning$$
CREATE FUNCTION NoOfUniqueCidMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cid)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCidAfternoon$$
CREATE FUNCTION NoOfUniqueCidAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cid)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCidEvening$$
CREATE FUNCTION NoOfUniqueCidEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cid)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCidNight$$
CREATE FUNCTION NoOfUniqueCidNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cid)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CidClickRatioMorning$$
CREATE FUNCTION CidClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cid))/COUNT(cid) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CidClickRatioAfternoon$$
CREATE FUNCTION CidClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cid))/COUNT(cid) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CidClickRatioEvening$$
CREATE FUNCTION CidClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cid))/COUNT(cid) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CidClickRatioNight$$
CREATE FUNCTION CidClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cid))/COUNT(cid) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCntrCountMorning$$
CREATE FUNCTION MaxSameCntrCountMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cntr_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cntr_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59'
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCntrCountAfternoon$$
CREATE FUNCTION MaxSameCntrCountAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cntr_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cntr_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59'
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCntrCountEvening$$
CREATE FUNCTION MaxSameCntrCountEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cntr_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cntr_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59'
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS MaxSameCntrCountNight$$
CREATE FUNCTION MaxSameCntrCountNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT max(cntr_count) INTO @cnt
	FROM 
	(SELECT COUNT(*) AS cntr_count
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59'
	GROUP BY cntr) AS newTable;

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCntrMorning$$
CREATE FUNCTION NoOfUniqueCntrMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cntr)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCntrAfternoon$$
CREATE FUNCTION NoOfUniqueCntrAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cntr)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCntrEvening$$
CREATE FUNCTION NoOfUniqueCntrEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cntr)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueCntrNight$$
CREATE FUNCTION NoOfUniqueCntrNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(cntr)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CntrClickRatioMorning$$
CREATE FUNCTION CntrClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cntr))/COUNT(cntr) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CntrClickRatioAfternoon$$
CREATE FUNCTION CntrClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cntr))/COUNT(cntr) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CntrClickRatioEvening$$
CREATE FUNCTION CntrClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cntr))/COUNT(cntr) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS CntrClickRatioNight$$
CREATE FUNCTION CntrClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(cntr))/COUNT(cntr) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TotalClicksMorning$$
CREATE FUNCTION TotalClicksMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TotalClicksAfternoon$$
CREATE FUNCTION TotalClicksAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TotalClicksEvening$$
CREATE FUNCTION TotalClicksEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS TotalClicksNight$$
CREATE FUNCTION TotalClicksNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueRefererMorning$$
CREATE FUNCTION NoOfUniqueRefererMorning(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(referer)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueRefererAfternoon$$
CREATE FUNCTION NoOfUniqueRefererAfternoon(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(referer)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueRefererEvening$$
CREATE FUNCTION NoOfUniqueRefererEvening(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(referer)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NoOfUniqueRefererNight$$
CREATE FUNCTION NoOfUniqueRefererNight(pid VARCHAR(20)) RETURNS INT
BEGIN
	SELECT COUNT(DISTINCT(referer)) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;



DELIMITER $$
DROP FUNCTION IF EXISTS RefererClickRatioMorning$$
CREATE FUNCTION RefererClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(referer))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS RefererClickRatioAfternoon$$
CREATE FUNCTION RefererClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(referer))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS RefererClickRatioEvening$$
CREATE FUNCTION RefererClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(referer))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS RefererClickRatioNight$$
CREATE FUNCTION RefererClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT COUNT(DISTINCT(referer))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NonRefererClickRatioMorning$$
CREATE FUNCTION NonRefererClickRatioMorning(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT (COUNT(*)-COUNT(DISTINCT(referer)))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '06:00:00' AND '11:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NonRefererClickRatioAfternoon$$
CREATE FUNCTION NonRefererClickRatioAfternoon(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT (COUNT(*)-COUNT(DISTINCT(referer)))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '12:00:00' AND '17:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NonRefererClickRatioEvening$$
CREATE FUNCTION NonRefererClickRatioEvening(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT (COUNT(*)-COUNT(DISTINCT(referer)))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '18:00:00' AND '23:59:59';

	RETURN @cnt;
END$$

DELIMITER ;




DELIMITER $$
DROP FUNCTION IF EXISTS NonRefererClickRatioNight$$
CREATE FUNCTION NonRefererClickRatioNight(pid VARCHAR(20)) RETURNS DECIMAL(8,2)
BEGIN
	SELECT (COUNT(*)-COUNT(DISTINCT(referer)))/COUNT(*) INTO @cnt
	FROM clicks_09feb12
	WHERE partnerid=pid
	AND TIME(timeat) BETWEEN '00:00:00' AND '05:59:59';

	RETURN @cnt;
END$$

DELIMITER ;



SELECT 'partnerid','MaxSameIpCountMorning','MaxSameIpCountAfternoon','MaxSameIpCountEvening','MaxSameIpCountNight',
'NoOfUniqueIpMorning','NoOfUniqueIpAfternoon','NoOfUniqueIpEvening','NoOfUniqueIpNight',
'IpClickRatioMorning','IpClickRatioAfternoon','IpClickRatioEvening','IpClickRatioNight',
'MaxSameAgentCountMorning','MaxSameAgentCountAfternoon','MaxSameAgentCountEvening','MaxSameAgentCountNight',
'NoOfUniqueAgentMorning','NoOfUniqueAgentAfternoon','NoOfUniqueAgentEvening','NoOfUniqueAgentNight',
'AgentClickRatioMorning','AgentClickRatioAfternoon','AgentClickRatioEvening','AgentClickRatioNight',
'MaxSameCidCountMorning','MaxSameCidCountAfternoon','MaxSameCidCountEvening','MaxSameCidCountNight',
'NoOfUniqueCidMorning','NoOfUniqueCidAfternoon','NoOfUniqueCidEvening','NoOfUniqueCidNight',
'CidClickRatioMorning','CidClickRatioAfternoon','CidClickRatioEvening','CidClickRatioNight',
'MaxSameCntrCountMorning','MaxSameCntrCountAfternoon','MaxSameCntrCountEvening','MaxSameCntrCountNight',
'NoOfUniqueCntrMorning','NoOfUniqueCntrAfternoon','NoOfUniqueCntrEvening','NoOfUniqueCntrNight',
'CntrClickRatioMorning','CntrClickRatioAfternoon','CntrClickRatioEvening','CntrClickRatioNight',
'TotalClicksMorning','TotalClicksAfternoon','TotalClicksEvening','TotalClicksNight',
'NoOfUniqueRefererMorning','NoOfUniqueRefererAfternoon','NoOfUniqueRefererEvening','NoOfUniqueRefererNight',
'RefererClickRatioMorning','RefererClickRatioAfternoon','RefererClickRatioEvening','RefererClickRatioNight',
'NonRefererClickRatioMorning','NonRefererClickRatioAfternoon','NonRefererClickRatioEvening','NonRefererClickRatioNight','status' UNION 
SELECT partnerid,
MaxSameIpCountMorning(partnerid),MaxSameIpCountAfternoon(partnerid),MaxSameIpCountEvening(partnerid),MaxSameIpCountNight(partnerid),
NoOfUniqueIpMorning(partnerid),NoOfUniqueIpAfternoon(partnerid),NoOfUniqueIpEvening(partnerid),NoOfUniqueIpNight(partnerid),
IpClickRatioMorning(partnerid),IpClickRatioAfternoon(partnerid),IpClickRatioEvening(partnerid),IpClickRatioNight(partnerid),
MaxSameAgentCountMorning(partnerid),MaxSameAgentCountAfternoon(partnerid),MaxSameAgentCountEvening(partnerid),MaxSameAgentCountNight(partnerid),
NoOfUniqueAgentMorning(partnerid),NoOfUniqueAgentAfternoon(partnerid),NoOfUniqueAgentEvening(partnerid),NoOfUniqueAgentNight(partnerid),
AgentClickRatioMorning(partnerid),AgentClickRatioAfternoon(partnerid),AgentClickRatioEvening(partnerid),AgentClickRatioNight(partnerid),
MaxSameCidCountMorning(partnerid),MaxSameCidCountAfternoon(partnerid),MaxSameCidCountEvening(partnerid),MaxSameCidCountNight(partnerid),
NoOfUniqueCidMorning(partnerid),NoOfUniqueCidAfternoon(partnerid),NoOfUniqueCidEvening(partnerid),NoOfUniqueCidNight(partnerid),
CidClickRatioMorning(partnerid),CidClickRatioAfternoon(partnerid),CidClickRatioEvening(partnerid),CidClickRatioNight(partnerid),
MaxSameCntrCountMorning(partnerid),MaxSameCntrCountAfternoon(partnerid),MaxSameCntrCountEvening(partnerid),MaxSameCntrCountNight(partnerid),
NoOfUniqueCntrMorning(partnerid),NoOfUniqueCntrAfternoon(partnerid),NoOfUniqueCntrEvening(partnerid),NoOfUniqueCntrNight(partnerid),
CntrClickRatioMorning(partnerid),CntrClickRatioAfternoon(partnerid),CntrClickRatioEvening(partnerid),CntrClickRatioNight(partnerid),
TotalClicksMorning(partnerid),TotalClicksAfternoon(partnerid),TotalClicksEvening(partnerid),TotalClicksNight(partnerid),
NoOfUniqueRefererMorning(partnerid),NoOfUniqueRefererAfternoon(partnerid),NoOfUniqueRefererEvening(partnerid),NoOfUniqueRefererNight(partnerid),
RefererClickRatioMorning(partnerid),RefererClickRatioAfternoon(partnerid),RefererClickRatioEvening(partnerid),RefererClickRatioNight(partnerid),
NonRefererClickRatioMorning(partnerid),NonRefererClickRatioAfternoon(partnerid),NonRefererClickRatioEvening(partnerid),NonRefererClickRatioNight(partnerid),
status
FROM publishers_09feb12
INTO OUTFILE '/tmp/train(morning_all)_09feb12.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'; 

