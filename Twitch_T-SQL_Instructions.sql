-- Procedures
-- 1. List the top streamers by followers
-- can be used for statistics, giving special signs to top streamers
DROP PROCEDURE IF EXISTS TopStreamersByFollowers;
DROP PROCEDURE IF EXISTS PopularityOfStreamsByCategory;

CREATE PROCEDURE TopStreamersByFollowers
AS
BEGIN
    DECLARE @TotalUsers INT ;

    SELECT @TotalUsers = COUNT(DISTINCT userID) FROM [User];

    SELECT u.username, COUNT(f.followerID) AS NumberOfFollowers
    FROM [User] u
    JOIN Followers f ON u.userID = f.followedID
    GROUP BY u.username
    ORDER BY NumberOfFollowers DESC;
END;


EXEC TopStreamersByFollowers;

-- 2. Popularity of streams by category
-- Statistics which category has the most streams in it
CREATE PROCEDURE PopularityOfStreamsByCategory
AS
BEGIN
    DECLARE @MaxNumberOfStreams INT;

    SELECT @MaxNumberOfStreams = MAX(StreamCount) FROM
    (SELECT COUNT(s.streamID) AS StreamCount
     FROM Category c
     Left JOIN Stream s ON c.categoryID = s.categoryID
     GROUP BY c.name) AS StreamCounts;

    SELECT c.name AS CategoryName, COUNT(s.streamID) as NumberOfStreams
    FROM Category c
    JOIN Stream s ON c.categoryID = s.categoryID
    GROUP BY c.name
    ORDER BY NumberOfStreams DESC;

     PRINT 'The highest number of streams in any category is ' + CAST(@MaxNumberOfStreams AS VARCHAR(10)) + '.';
END;

EXEC PopularityOfStreamsByCategory;


-- Triggers
-- 1. Notification for user about the assignment a moderator role
CREATE TRIGGER ModeratorAssignmentNotification
ON Stream_Moderator
AFTER INSERT
AS
BEGIN
    IF EXISTS(SELECT 1 FROM inserted)
    BEGIN
        INSERT INTO Notification(notifiedUserID, notificationMessage, time)
        SELECT m.userID, u.username + ' made you a moderator of their stream', CURRENT_TIMESTAMP
        FROM inserted i
        INNER JOIN Moderator m ON i.moderatorID = m.moderatorID
        INNER JOIN Stream s ON i.streamID = s.streamID
        INNER JOIN [User] u ON s.streamerID = u.userID;
    END;
END;

-- 2. Notification for subscribers of a streamer about creation a new clip of their stream
CREATE TRIGGER ClipCreatedNotification
    ON CLIP
    AFTER INSERT
    AS
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted)
        BEGIN
            DECLARE @clipID INT, @streamID INT, @clipTitle VARCHAR(30);
            DECLARE clip_cursor CURSOR FOR SELECT clipID, streamID, title FROM inserted;
            OPEN clip_cursor;
            FETCH NEXT FROM clip_cursor INTO @clipID, @streamID, @clipTitle;
            WHILE @@FETCH_STATUS = 0
            BEGIN
                DECLARE @streamerUsername VARCHAR(20);
                SELECT @streamerUsername = u.username FROM [User] u
                JOIN Stream s ON u.userID = s.streamerID
                WHERE s.streamID = @streamID;

                INSERT INTO Notification(notifiedUserID, notificationMessage, time)
                SELECT followerID, 'New clip "' + @clipTitle + '" was created of ' + @streamerUsername + ' stream!',
                       CURRENT_TIMESTAMP FROM Followers WHERE followedID = (SELECT streamerID FROM Stream WHERE streamID = @streamID);

                FETCH NEXT FROM clip_cursor INTO @clipID, @streamID, @clipTitle;

            END
            CLOSE clip_cursor;
            DEALLOCATE  clip_cursor;

        END
    END;

INSERT INTO Stream_Moderator (moderatorID, streamID) VALUES (1, 6);
SELECT * FROM Stream_Moderator;
SELECT * FROM Notification;

INSERT INTO Clip (clipID, title, startTime, endTime, streamID, userID)
    VALUES (4, 'Best song', '2024-01-07 20:10:00', '2024-01-07 20:23:00', 3, 4);
SELECT * FROM Clip;
SELECT * FROM Notification;
