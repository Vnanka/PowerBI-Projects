-- Clean script
-- DATABASE CREATION AND USE
CREATE DATABASE BBC;
USE BBC;

-- INITIAL TABLE CREATION AND DATA INPUT
CREATE TABLE IF NOT EXISTS audience (
    event_id CHAR(16)  NOT NULL,              -- Fixed-length unique event identifier
    user_id CHAR(6) NOT NULL,              -- Short user ID
    date TIMESTAMP NOT NULL,          -- Timestamp for the event
    episode_id CHAR(10) NOT NULL,           -- Fixed-length episode identifier
    content_type ENUM('vod', 'live') NOT NULL, -- Limited to 'vod' and 'live'
    play_time SMALLINT UNSIGNED NOT NULL,   -- Play time in seconds (up to ~65,535)
    episode_length SMALLINT UNSIGNED NOT NULL, -- Episode length in seconds
    PRIMARY KEY (event_id)              
);

INSERT INTO audience (event_id, user_id, date, episode_id, content_type, play_time, episode_length) VALUES
('iqeq4x84r6x2yxl', 'xw8EF', '2016-08-25 08:15:30', 'woaqa01', 'vod', 180, 200),
('iqeujzl76pff8hu', 'IfTI1', '2016-08-25 08:16:31', 'eodjdm02', 'vod', 260, 300),
('iqfnedekranvo17', 'LiKkg', '2016-08-25 08:15:35', 'ddhdk02', 'vod', 360, 500),
('iqf9z35v5qxhsky', 'LiF7q', '2016-08-25 08:15:39', 'endoep03', 'live', 700, 720),
('iqf6dth7il4ta0m', 'Li9IS', '2016-08-25 08:15:30', 'wneola02', 'live', 80, 1450),
('iqfn8x5urtl1s98', 'LhTcE', '2016-08-25 08:17:30', 'Wjdjdkdk02', 'vod', 190, 300),
('iqerdwmt2u3bb1n', 'KuFh7', '2016-08-25 08:17:43', 'UddhdS01', 'live', 1000, 1100),
('iqg0u88i82wlr1i', 'Kokho', '2016-08-25 08:15:54', 'oensksl02', 'vod', 389, 400);

CREATE TABLE IF NOT EXISTS demographic (
    age TINYINT UNSIGNED NOT NULL,
    user_id CHAR(6) NOT NULL,
    region VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id));

INSERT INTO demographic (age, user_id, region)
VALUES
(25, 'xw8EF', 'North West'),
(30, 'IfTI1', 'London'),
(45, 'LiKkg', 'South West'),
(51, 'LiF7q', 'North Wales'),
(40, 'Li9IS', 'Scotland'),
(60, 'LhTcE', 'London'),
(47, 'GgeoR', 'North East');

-- DERIVATIVE TABLE CREATION 

CREATE TABLE IF NOT EXISTS combined_demographic_audience_view  AS
	SELECT
    audience.event_id,
    audience.user_id,
    audience.date AS date_timestamp,
    audience.episode_id,
    audience.content_type,
    audience.play_time,
    audience.episode_length,
    demographic.age,
    demographic.region    
FROM
    audience
LEFT JOIN
    demographic
ON
    audience.user_id = demographic.user_id;


CREATE TABLE IF NOT EXISTS user_engagement_aggregate AS
SELECT
    user_id,
    DATE(date_timestamp) AS date,
    episode_id,
    content_type,
	episode_length,
    COALESCE(age, 'Unknown') as user_age,
    COALESCE(region, 'Unknown') as user_region,
    COUNT(*) AS watch_instance_count,
    SUM(play_time) AS total_play_time,
    ROUND(SUM(play_time) / episode_length * 100, 2) AS completion_rate_percentage
FROM
    combined_demographic_audience_view
GROUP BY
    user_id, DATE(date_timestamp), episode_id, content_type, age, region, episode_length;


-- TABLE UDATE

DELIMITER // 
CREATE EVENT combined_demographic_audience_view_refresh
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
TRUNCATE TABLE combined_demographic_audience_view;
INSERT INTO combined_demographic_audience_view
	SELECT
    audience.event_id,
    audience.user_id,
    audience.date AS date_timestamp,
    audience.episode_id,
    audience.content_type,
    audience.play_time,
    audience.episode_length,
    demographic.age,
    demographic.region    
FROM
    audience
LEFT JOIN
    demographic
ON
    audience.user_id = demographic.user_id; 
END//
   
DELIMITER ;



DELIMITER // 
CREATE EVENT user_engagement_aggregate_refresh
ON SCHEDULE EVERY 1 day
DO
BEGIN
TRUNCATE TABLE user_engagement_aggregate;
INSERT INTO user_engagement_aggregate
SELECT
    user_id,
    DATE(date_timestamp) AS date,
    episode_id,
    content_type,
	episode_length,
    COALESCE(age, 'Unknown') as age,
    COALESCE(region, 'Unknown') as region,
    COUNT(*) AS watch_instance_count,
    SUM(play_time) AS total_play_time,
    ROUND(SUM(play_time) / episode_length * 100, 2) AS completion_rate_percentage
FROM
    combined_demographic_audience_view
GROUP BY
    user_id, DATE(date_timestamp), episode_id, content_type, age, region, episode_length;
END//
   
DELIMITER ;