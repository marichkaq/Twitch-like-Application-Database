
ALTER TABLE Chat_message
    DROP CONSTRAINT Chat_message_Stream;

ALTER TABLE Chat_message
    DROP CONSTRAINT Chat_message_User;

ALTER TABLE Clip
    DROP CONSTRAINT Clip_Stream;

ALTER TABLE Clip
    DROP CONSTRAINT Clip_User;

ALTER TABLE Donation
    DROP CONSTRAINT Donation_Stream;

ALTER TABLE Donation
    DROP CONSTRAINT Donation_User;

ALTER TABLE Followers
    DROP CONSTRAINT Followers_User1;

ALTER TABLE Followers
    DROP CONSTRAINT Followers_User2;

ALTER TABLE Moderator
    DROP CONSTRAINT Moderator_User;

ALTER TABLE Notification
    DROP CONSTRAINT Notification_User;

ALTER TABLE Stream
    DROP CONSTRAINT Stream_Category;

ALTER TABLE Stream_Moderator
    DROP CONSTRAINT Stream_Moderator_Moderator;

ALTER TABLE Stream_Moderator
    DROP CONSTRAINT Stream_Moderator_Stream;

ALTER TABLE Stream
    DROP CONSTRAINT Stream_User;

ALTER TABLE Stream_Advertisement
    DROP CONSTRAINT Stream_Advertisement_Advertisement;

ALTER TABLE Stream_Advertisement
    DROP CONSTRAINT Stream_Advertisement_Stream;

ALTER TABLE Stream_Viewer
    DROP CONSTRAINT Stream_Viewer_Stream;

ALTER TABLE Stream_Viewer
    DROP CONSTRAINT Stream_Viewer_User;

-- tables
DROP TABLE Advertisement;

DROP TABLE Category1;

DROP TABLE Chat_message;

DROP TABLE Clip;

DROP TABLE Donation;

DROP TABLE Followers;

DROP TABLE Moderator;

DROP TABLE Notification;

DROP TABLE Stream;

DROP TABLE Stream_Advertisement;

DROP TABLE Stream_Moderator;

DROP TABLE Stream_Viewer;

DROP TABLE "User";

-- tables
-- Table: Advertisement
CREATE TABLE Advertisement (
    adID int  NOT NULL,
    content varchar(50)  NOT NULL,
    sponsorName varchar(30)  NOT NULL,
    CONSTRAINT Advertisement_pk PRIMARY KEY (adID)
);

-- Table: Category
CREATE TABLE Category1 (
    categoryID int  NOT NULL,
    name varchar(20)  NOT NULL,
    CONSTRAINT Category1_pk PRIMARY KEY (categoryID)
);

-- Table: Chat_message
CREATE TABLE Chat_message (
    messageID int  NOT NULL,
    content varchar(100)  NOT NULL,
    time timestamp  NOT NULL,
    streamID int  NOT NULL,
    userID int  NOT NULL,
    CONSTRAINT Chat_message_pk PRIMARY KEY (messageID)
);

-- Table: Clip
CREATE TABLE Clip (
    clipID int  NOT NULL,
    title varchar(30)  NOT NULL,
    startTime timestamp  NOT NULL,
    endTime timestamp  NOT NULL,
    streamID int  NOT NULL,
    userID int  NOT NULL,
    CONSTRAINT Clip_pk PRIMARY KEY (clipID)
);

-- Table: Donation
CREATE TABLE Donation (
    donationID int  NOT NULL,
    amount int  NOT NULL,
    time timestamp  NOT NULL,
    streamID int  NOT NULL,
    userID int  NOT NULL,
    CONSTRAINT Donation_pk PRIMARY KEY (donationID)
);

-- Table: Followers
CREATE TABLE Followers (
    followerID int  NOT NULL,
    followedID int  NOT NULL,
    CONSTRAINT Followers_pk PRIMARY KEY (followerID,followedID)
);

-- Table: Moderator
CREATE TABLE Moderator (
    moderatorID int  NOT NULL,
    assignedDate date  NOT NULL,
    permissions varchar(40)  NOT NULL,
    userID int  NOT NULL,
    CONSTRAINT Moderator_pk PRIMARY KEY (moderatorID)
);

-- Table: Notification
CREATE TABLE Notification (
    notificationID int  NOT NULL,
    notifiedUserID int  NOT NULL,
    notificationMessage varchar(120)  NOT NULL,
    time timestamp  NOT NULL,
    CONSTRAINT Notification_pk PRIMARY KEY (notificationID)
);

-- Table: Stream
CREATE TABLE Stream (
    streamID int  NOT NULL,
    title varchar(30)  NOT NULL,
    startTime timestamp  NOT NULL,
    endTime timestamp  NOT NULL,
    streamerID int  NOT NULL,
    categoryID int  NOT NULL,
    CONSTRAINT Stream_pk PRIMARY KEY (streamID)
);

-- Table: Stream_Advertisement
CREATE TABLE Stream_Advertisement (
    adID int  NOT NULL,
    streamID int  NOT NULL,
    startTime timestamp  NOT NULL,
    endTime timestamp  NOT NULL,
    CONSTRAINT Stream_Advertisement_pk PRIMARY KEY (adID,streamID)
);

-- Table: Stream_Moderator
CREATE TABLE Stream_Moderator (
    moderatorID int  NOT NULL,
    streamID int  NOT NULL,
    CONSTRAINT Stream_Moderator_pk PRIMARY KEY (moderatorID,streamID)
);

-- Table: Stream_Viewer
CREATE TABLE Stream_Viewer (
    viewerID int  NOT NULL,
    streamID int  NOT NULL,
    CONSTRAINT Stream_Viewer_pk PRIMARY KEY (viewerID,streamID)
);


-- Table: User
CREATE TABLE "User" (
    userID int  NOT NULL,
    username varchar(20)  NOT NULL,
    email varchar(40)  NOT NULL,
    password varchar(20)  NOT NULL,
    registrationDate date  NOT NULL,
    lastLogIn timestamp  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (userID)
);

-- foreign keys
-- Reference: Chat_message_Stream (table: Chat_message)
ALTER TABLE Chat_message ADD CONSTRAINT Chat_message_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Chat_message_User (table: Chat_message)
ALTER TABLE Chat_message ADD CONSTRAINT Chat_message_User
    FOREIGN KEY (userID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Clip_Stream (table: Clip)
ALTER TABLE Clip ADD CONSTRAINT Clip_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Clip_User (table: Clip)
ALTER TABLE Clip ADD CONSTRAINT Clip_User
    FOREIGN KEY (userID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Donation_Stream (table: Donation)
ALTER TABLE Donation ADD CONSTRAINT Donation_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Donation_User (table: Donation)
ALTER TABLE Donation ADD CONSTRAINT Donation_User
    FOREIGN KEY (userID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Followers_User1 (table: Followers)
ALTER TABLE Followers ADD CONSTRAINT Followers_User1
    FOREIGN KEY (followerID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Followers_User2 (table: Followers)
ALTER TABLE Followers ADD CONSTRAINT Followers_User2
    FOREIGN KEY (followedID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Moderator_User (table: Moderator)
ALTER TABLE Moderator ADD CONSTRAINT Moderator_User
    FOREIGN KEY (userID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Notification_User (table: Notification)
ALTER TABLE Notification ADD CONSTRAINT Notification_User
    FOREIGN KEY (notifiedUserID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Advertisement_Advertisement (table: Stream_Advertisement)
ALTER TABLE Stream_Advertisement ADD CONSTRAINT Stream_Advertisement_Advertisement
    FOREIGN KEY (adID)
    REFERENCES Advertisement (adID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Advertisement_Stream (table: Stream_Advertisement)
ALTER TABLE Stream_Advertisement ADD CONSTRAINT Stream_Advertisement_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Category (table: Stream)
ALTER TABLE Stream ADD CONSTRAINT Stream_Category
    FOREIGN KEY (categoryID)
    REFERENCES Category1 (categoryID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Moderator_Moderator (table: Stream_Moderator)
ALTER TABLE Stream_Moderator ADD CONSTRAINT Stream_Moderator_Moderator
    FOREIGN KEY (moderatorID)
    REFERENCES Moderator (moderatorID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Moderator_Stream (table: Stream_Moderator)
ALTER TABLE Stream_Moderator ADD CONSTRAINT Stream_Moderator_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_User (table: Stream)
ALTER TABLE Stream ADD CONSTRAINT Stream_User
    FOREIGN KEY (streamerID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Viewer_Stream (table: Stream_Viewer)
ALTER TABLE Stream_Viewer ADD CONSTRAINT Stream_Viewer_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Stream_Viewer_User (table: Stream_Viewer)
ALTER TABLE Stream_Viewer ADD CONSTRAINT Stream_Viewer_User
    FOREIGN KEY (viewerID)
    REFERENCES "User" (userID)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;


--inserts
INSERT ALL
  INTO Category1 (categoryID, name) VALUES (1, 'Art')
  INTO Category1 (categoryID, name) VALUES (2, 'Sports')
  INTO Category1 (categoryID, name) VALUES (3, 'Music')
  INTO Category1 (categoryID, name) VALUES (4, 'Games')
  INTO Category1 (categoryID, name) VALUES (5, 'Chatting')
  INTO Category1 (categoryID, name) VALUES (6, 'Food')
  INTO Category1 (categoryID, name) VALUES (7, 'Fitnes')
SELECT * FROM dual;

INSERT ALL 
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (1, 'blanee', 'blanee@gmail.com', 'h4htr48y4', TO_DATE('2015-06-06', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-12-24 08:00:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (2, 'painterPete', 'painterPete@gmail.com', 'rh8247yr', TO_DATE('2020-12-09', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-12-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (3, 'soccerSally', 'soccerSally@gmail.com', 'fh498q42', TO_DATE('2022-10-06', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-01-08 10:00:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (4, 'chatMatt', 'chatMatt@gmail.com', 'g728guiwr', TO_DATE('2018-03-08', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-01-05 23:00:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (5, 'lyricLiz', 'lyricLiz@gmail.com', 'ah392r4yy', TO_DATE('2019-05-23', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-01-09 15:00:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (6, 'chefCharlie', 'chefCharlie@gmail.com', 'hrY32Y32', TO_DATE('2022-11-15', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-12-31 10:00:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO "User" (userID, username, email, password, registrationDate, lastLogIn) VALUES (7, 'yogaYolanda', 'yogaYolanda@gmail.com', 'hsaud932', TO_DATE('2021-01-20', 'YYYY-MM-DD'),  TO_TIMESTAMP('2023-01-07 16:00:00', 'YYYY-MM-DD HH24:MI:SS'))

SELECT * FROM dual;

INSERT ALL
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (1, 'playing osu!', TO_TIMESTAMP('2023-12-20 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-20 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4)
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (2, 'sketching', TO_TIMESTAMP('2023-12-12 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-12 17:15:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 1)
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (3, 'training for osu tournir', TO_TIMESTAMP('2023-10-06 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-07 01:20:00', 'YYYY-MM-DD HH24:MI:SS'), 1, 4)
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (4, 'watching league of champions', TO_TIMESTAMP('2023-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-09-30 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 2)
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (5, 'playing guitar', TO_TIMESTAMP('2024-01-07 19:10:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-07 20:40:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 3)
	INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID) VALUES (6, 'evening yoga practice', TO_TIMESTAMP('2024-01-06 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-06 21:45:00', 'YYYY-MM-DD HH24:MI:SS'), 7, 7)
SELECT * FROM dual;

INSERT ALL
	INTO Stream_Viewer (viewerID, streamID) VALUES (3, 1)
	INTO Stream_Viewer (viewerID, streamID) VALUES (4, 1)
	INTO Stream_Viewer (viewerID, streamID) VALUES (6, 2)
	INTO Stream_Viewer (viewerID, streamID) VALUES (4, 2)
	INTO Stream_Viewer (viewerID, streamID) VALUES (2, 3)
	INTO Stream_Viewer (viewerID, streamID) VALUES (4, 3)
	INTO Stream_Viewer (viewerID, streamID) VALUES (3, 3)
	INTO Stream_Viewer (viewerID, streamID) VALUES (5, 3)
	INTO Stream_Viewer (viewerID, streamID) VALUES (6, 3)
	INTO Stream_Viewer (viewerID, streamID) VALUES (6, 4)
	INTO Stream_Viewer (viewerID, streamID) VALUES (1, 4)
	INTO Stream_Viewer (viewerID, streamID) VALUES (4, 5)
	INTO Stream_Viewer (viewerID, streamID) VALUES (2, 5)
	INTO Stream_Viewer (viewerID, streamID) VALUES (1, 6)
	INTO Stream_Viewer (viewerID, streamID) VALUES (2, 6)
	INTO Stream_Viewer (viewerID, streamID) VALUES (5, 6)

SELECT * FROM dual;



INSERT ALL
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (1, 'Hi!', TO_TIMESTAMP('2023-10-06 20:05:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (2, 'How are you?', TO_TIMESTAMP('2023-10-06 20:06:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (3, 'You are doing well :)', TO_TIMESTAMP('2023-10-06 20:15:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 2)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (4, 'Wish you good luck tommorow', TO_TIMESTAMP('2023-10-06 21:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (5, 'Hey', TO_TIMESTAMP('2023-12-12 15:40:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 6)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (6, 'Could you draw my cat?', TO_TIMESTAMP('2023-12-12 15:42:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 6)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (7, 'How nice is that!', TO_TIMESTAMP('2023-12-12 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 6)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (8, 'Thanks for sharing this practice', TO_TIMESTAMP('2024-01-06 21:40:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 5)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (9, 'I feel much better after this', TO_TIMESTAMP('2024-01-06 21:40:00', 'YYYY-MM-DD HH24:MI:SS'), 6, 2)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (10, 'Hi! Whats the model of your guitar?', TO_TIMESTAMP('2024-01-07 19:30:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 2)
	INTO Chat_message (messageID, content, time, streamID, userID) VALUES (11, 'Could you play The Cure?', TO_TIMESTAMP('2024-01-07 19:52:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 4)

SELECT * FROM dual;

INSERT ALL 
	INTO Donation (donationID, amount, time, streamID, userID) VALUES (1, 10, TO_TIMESTAMP('2023-10-06 20:16:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 2)
	INTO Donation (donationID, amount, time, streamID, userID) VALUES (2, 25, TO_TIMESTAMP('2023-12-12 16:22:00', 'YYYY-MM-DD HH24:MI:SS'), 2, 6)
	INTO Donation (donationID, amount, time, streamID, userID) VALUES (3, 12, TO_TIMESTAMP('2024-01-07 19:52:00', 'YYYY-MM-DD HH24:MI:SS'), 5, 4)

SELECT * FROM dual;

INSERT ALL
	INTO Clip (clipID, title, startTime, endTime, streamID, userID) VALUES (1, 'Highest score on map', TO_TIMESTAMP('2023-10-06 20:12:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-10-06 20:17:00', 'YYYY-MM-DD HH24:MI:SS'), 3, 4)
	INTO Clip (clipID, title, startTime, endTime, streamID, userID) VALUES (2, 'risky moment', TO_TIMESTAMP('2023-09-30 20:26:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-09-30 20:30:00', 'YYYY-MM-DD HH24:MI:SS'), 4, 6)

SELECT * FROM dual;

INSERT ALL
	INTO Moderator (moderatorID, assignedDate, permissions, userID) VALUES (1, TO_DATE('2023-10-17', 'YYYY-MM-DD'), 'change chat modes', 2)
	INTO Moderator (moderatorID, assignedDate, permissions, userID) VALUES (2, TO_DATE('2023-03-06', 'YYYY-MM-DD'), 'change chat modes, ban users', 4)
	INTO Moderator (moderatorID, assignedDate, permissions, userID) VALUES (3, TO_DATE('2022-07-12', 'YYYY-MM-DD'), 'ban users', 1)
SELECT * FROM dual;

INSERT ALL 
	INTO Stream_Moderator (moderatorID, streamID) VALUES (1, 2)
	INTO Stream_Moderator (moderatorID, streamID) VALUES (2, 3)
	INTO Stream_Moderator (moderatorID, streamID) VALUES (3, 4)
SELECT * FROM dual;

INSERT ALL
	INTO Advertisement (adID, content, sponsorName) VALUES (1, 'video ad', 'Arizona')
	INTO Advertisement (adID, content, sponsorName) VALUES (2, 'streamer showing the product', 'LogiTech')
	INTO Advertisement (adID, content, sponsorName) VALUES (3, 'video ad', 'Nike')
	INTO Advertisement (adID, content, sponsorName) VALUES (4, 'streamer showing the product', 'YogaWear')
    
SELECT * FROM dual;

INSERT ALL
	INTO Stream_Advertisement (adID, streamID, startTime, endTime) VALUES (1, 1, TO_TIMESTAMP('2023-12-20 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-20 21:01:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO Stream_Advertisement (adID, streamID, startTime, endTime) VALUES (1, 2, TO_TIMESTAMP('2023-12-12 16:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-12 16:31:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO Stream_Advertisement (adID, streamID, startTime, endTime) VALUES (2, 1, TO_TIMESTAMP('2023-12-20 19:20:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-20 19:25:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO Stream_Advertisement (adID, streamID, startTime, endTime) VALUES (3, 4, TO_TIMESTAMP('2023-09-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-09-30 18:02:00', 'YYYY-MM-DD HH24:MI:SS'))
	INTO Stream_Advertisement (adID, streamID, startTime, endTime) VALUES (4, 6, TO_TIMESTAMP('2024-01-06 20:05:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-06 20:08:00', 'YYYY-MM-DD HH24:MI:SS'))

SELECT * FROM dual;

INSERT ALL
	INTO Followers (followerID, followedID) VALUES (4, 1)
	INTO Followers (followerID, followedID) VALUES (2, 1)
	INTO Followers (followerID, followedID) VALUES (6, 2)
	INTO Followers (followerID, followedID) VALUES (5, 7)
	INTO Followers (followerID, followedID) VALUES (2, 7)
	INTO Followers (followerID, followedID) VALUES (1, 2)

SELECT * FROM dual; 