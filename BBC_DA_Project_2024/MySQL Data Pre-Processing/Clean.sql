Create database bbc_da_task;

USE BBC_DA_TASK;


-- Creation of tables

CREATE TABLE IF NOT EXISTS iP_task_publisher_events (
    date_index VARCHAR(10) NOT NULL,
    visit_id VARCHAR(20) NOT NULL,
    event_position INT NOT NULL,
    container VARCHAR(50) NOT NULL,
    attribute VARCHAR(50) NOT NULL,
    metadata TEXT NOT NULL,
    placement TEXT NOT NULL,
    result VARCHAR(50) NOT NULL,
    clicks INT,
    impressions INT,
    event_start_datetime DATETIME,
    PRIMARY KEY (visit_id, event_position, date_index, event_start_datetime),
    INDEX idx_event_position (event_position),
    INDEX idx_visit_id (visit_id),
    INDEX idx_date_index (date_index),
	INDEX idx_event_start_datetime (event_start_datetime)
);

ALTER TABLE ip_task_publisher_events
ADD COLUMN event_start_hour VARCHAR(20);

UPDATE ip_task_publisher_events
SET event_start_hour = HOUR(event_start_datetime);

ALTER TABLE ip_task_publisher_events
ADD COLUMN extracted_code VARCHAR(20);

UPDATE ip_task_publisher_events
SET extracted_code = coalesce(SUBSTRING_INDEX(SUBSTRING(metadata, LOCATE('CXT=', metadata) + 4), '~', 1), 'error');
------------------------------------------------------

CREATE TABLE IF NOT EXISTS ip_task_episode_ids (
    episode_id VARCHAR(255) NOT NULL PRIMARY KEY UNIQUE,
    content_title VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS ip_task_trailer_ids (
    clip_id VARCHAR(255) NOT NULL PRIMARY KEY UNIQUE,
    clip_title VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS iP_task_user_info (
    date VARCHAR(20) NOT NULL,
    visit_id VARCHAR(20) NOT NULL PRIMARY KEY UNIQUE,
	age_range VARCHAR(20) NOT NULL,
    frequency_group_aggregated VARCHAR(20) NOT NULL
);

------------------------------------------------------
-- Loading Data 

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/iP_task_publisher_events.csv'
INTO TABLE iP_task_publisher_events
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@date_index, @visit_id, @event_position, @container, @attribute, @metadata, @placement, @result, @clicks, @impressions, @event_start_datetime)
SET 
    date_index = @date_index,
    visit_id = @visit_id,
    event_position = @event_position,
    container = @container,
    attribute = @attribute,
    metadata = @metadata,
    placement = @placement,
    result = @result,
    clicks = @clicks,
    impressions = @impressions,
    event_start_datetime = STR_TO_DATE(@event_start_datetime, '%Y-%m-%dT%H:%i:%s');
    
    
------------------------------------------------------
    
-- Dup Table

CREATE TABLE IF NOT EXISTS iP_task_publisher_events_dup as select * from ip_task_publisher_events;
drop table iP_task_publisher_events_dup;


DELETE FROM iP_task_publisher_events_dup
WHERE (date_index, visit_id, result, extracted_code, event_start_hour) IN (
    SELECT date_index, visit_id, result, extracted_code, event_start_hour
    FROM (
        SELECT 
            date_index, 
            visit_id, 
            result, 
            extracted_code, 
            event_start_hour,
            COUNT(*) AS engagement_count
        FROM iP_task_publisher_events_dup
        GROUP BY date_index, visit_id, result, extracted_code, event_start_hour
        HAVING engagement_count != 3
    ) AS temp
);


-----------------------------------------------------

-- Aggregate Table
CREATE TABLE IF NOT EXISTS trailer_engagement_aggregate as 
SELECT
    start_event.date_index,
    start_event.visit_id,
    start_event.extracted_code,
    start_event.event_start_hour,
    start_event.result,
    start_event.event_start_datetime AS start_time,
    end_event.event_start_datetime AS end_time,
    TIMESTAMPDIFF(SECOND, start_event.event_start_datetime, end_event.event_start_datetime) AS duration_seconds,
    CASE
        WHEN MAX(end_event.attribute) = 'skip-pre-roll-trailer' THEN 'Skipped'
        WHEN MAX(end_event.attribute) = 'pre-roll-trailer-complete' THEN 'Completed'
    END AS event_type
FROM
    iP_task_publisher_events_dup start_event
JOIN
    iP_task_publisher_events_dup end_event
ON
    start_event.visit_id = end_event.visit_id
    AND start_event.date_index = end_event.date_index
    AND start_event.extracted_code = end_event.extracted_code
    AND start_event.event_start_hour = end_event.event_start_hour
    AND start_event.result = end_event.result
    AND start_event.attribute = 'pre-roll-trailer-start'
    AND end_event.attribute IN ('skip-pre-roll-trailer', 'pre-roll-trailer-complete')
    AND (end_event.attribute != 'skip-pre-roll-trailer' OR end_event.clicks = 1)
    AND start_event.event_position < end_event.event_position
GROUP BY
    start_event.date_index,
    start_event.visit_id,
    start_event.extracted_code,
    start_event.event_start_hour,
    start_event.result,
    start_time,
    end_time;
    
    
SELECT * FROM ip_task_episode_ids;
SELECT count(*) FROM ip_task_episode_ids;

SELECT * FROM ip_task_publisher_events;
SELECT count(*) FROM ip_task_publisher_events;

SELECT * FROM ip_task_trailer_ids;
SELECT count(*) FROM ip_task_trailer_ids;

SELECT * FROM iP_task_user_info;
SELECT count(*) FROM iP_task_user_info;

SELECT * FROM trailer_engagement_aggregate;
SELECT count(*) FROM ip_task_publisher_events;
