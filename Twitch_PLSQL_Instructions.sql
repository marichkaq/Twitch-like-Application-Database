SET Serveroutput ON;


-- Procedures 
-- 1. Total donations received by streamer
CREATE OR REPLACE PROCEDURE TotalDonationsForStreamer(streamer_id IN INT, total OUT INT)
AS 
	donation_sum INT;
	streamer_username VARCHAR(20);
BEGIN 
	SELECT SUM(amount) into donation_sum 
	FROM Donation
	JOIN Stream ON Donation.streamID = Stream.streamID
	WHERE Stream.streamerID = streamer_id;

	SELECT username INTO streamer_username
	FROM "User"
	WHERE userID = streamer_id;

	IF donation_sum IS NULL THEN 
	total := 0;
	ELSE 
	total := donation_sum;
	END IF;

	dbms_output.put_line('Total donations for streamer ' || streamer_username || ': ' || total);
END;
/

DECLARE 
	total_donations INT;
BEGIN
	TotalDonationsForStreamer(streamer_id => 1, total => total_donations);
END;
/

-- 2. List the most active users in a stream chat
CREATE OR REPLACE PROCEDURE ListViewersByChatActivity(stream_id IN INT)
AS 
	CURSOR active_users_cursor IS SELECT u.username, COUNT(*) AS message_count
	FROM Chat_message c
    JOIN "User" u ON c.userID = u.userID
	WHERE c.streamID = stream_id
	GROUP BY u.username
	ORDER BY message_count DESC;

	username VARCHAR(20);
	user_message_count INT;
BEGIN
	OPEN active_users_cursor;
	LOOP 
		FETCH active_users_cursor INTO username, user_message_count;
		EXIT WHEN active_users_cursor%NOTFOUND;
		dbms_output.put_line('Active users in the chat: ' || username || ' - Messages: ' || user_message_count) ;
	END LOOP;
	CLOSE active_users_cursor;
END;
/

BEGIN 
	ListViewersByChatActivity(stream_id => 3);
END;
/


-- Triggers
-- 1. Trigger for automatic chat message timestamp and notification for streamer to show the message on his screen
CREATE OR REPLACE TRIGGER ChatMessageSent
BEFORE INSERT ON Chat_message
FOR EACH ROW
DECLARE 
    sender_username VARCHAR(20);
    streamer_id INT;
BEGIN
	:NEW.time := SYSTIMESTAMP;
    
    SELECT username INTO sender_username
    FROM "User"
    WHERE userID = :NEW.userID;
    
    SELECT streamerID INTO streamer_id
    FROM Stream
    WHERE streamID = :NEW.streamID;
    
    INSERT INTO Notification(notificationID, notifiedUserID, notificationMessage, time)
    VALUES (notification_sequence.NEXTVAL, streamer_id, sender_username || ': ' || :NEW.content, SYSTIMESTAMP);
END;
/


CREATE SEQUENCE message_sequence
START WITH 12
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE stream_sequence
START WITH 7
INCREMENT BY 1
NOMAXVALUE;

CREATE SEQUENCE notification_sequence
START WITH 12
INCREMENT BY 1
NOMAXVALUE;

-- 2. Trigger to notify subscribers of a streamer when he or she starts a stream
CREATE OR REPLACE TRIGGER NotifyFollowersOnStreamStart 
AFTER INSERT ON Stream
FOR EACH ROW
DECLARE 
	streamer_username VARCHAR(20);
BEGIN 
    SELECT username INTO streamer_username
    FROM "User"
	WHERE userID = :NEW.streamerID;

	FOR follower IN (SELECT followerID FROM Followers WHERE followedID = :NEW.streamerID)
	LOOP 
		INSERT INTO Notification(notificationID, notifiedUserID, notificationMessage, time)
		VALUES (notification_sequence.NEXTVAL, follower.followerID, streamer_username || ' is live!', CURRENT_TIMESTAMP);
	END LOOP;
END;
/ 

DECLARE
    last_stream_id INT;
BEGIN
    INSERT INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID)
    VALUES (stream_sequence.NEXTVAL, 'New stream title', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '2' HOUR, 1, 4)
    RETURNING streamID INTO last_stream_id;

    INSERT INTO Chat_message (messageID, content, streamID, userID)
    VALUES (message_sequence.NEXTVAL, 'Hi, I am new message', last_stream_id, 2);

    COMMIT;
END;
/
SELECT * FROM Stream;
SELECT * FROM Chat_message;
SELECT * FROM Notification;
