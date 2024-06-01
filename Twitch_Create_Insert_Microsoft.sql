
-- tables
DROP TABLE IF EXISTS Advertisement;

DROP TABLE IF EXISTS Category;

DROP TABLE IF EXISTS Chat_message;

DROP TABLE IF EXISTS Clip;

DROP TABLE IF EXISTS Donation;

DROP TABLE IF EXISTS Followers;

DROP TABLE IF EXISTS Moderator;

DROP TABLE IF EXISTS Notification;

DROP TABLE IF EXISTS Stream;

DROP TABLE IF EXISTS Stream_Advertisement;

DROP TABLE IF EXISTS Stream_Moderator;

DROP TABLE IF EXISTS Stream_Viewer;

DROP TABLE IF EXISTS [User];


-- tables
-- Table: Advertisement
CREATE TABLE Advertisement (
    adID INT PRIMARY KEY,
    content VARCHAR(50) NOT NULL,
    sponsorName VARCHAR(20) NOT NULL
);

-- Table: Category
CREATE TABLE Category (
    categoryID INT  PRIMARY KEY,
    name VARCHAR(20)  NOT NULL
);

-- Table: Chat_message
CREATE TABLE Chat_message (
    messageID INT  PRIMARY KEY,
    content VARCHAR(100)  NOT NULL,
    time DATETIME  NOT NULL,
    streamID INT  NOT NULL,
    userID INT  NOT NULL
);

-- Table: Clip
CREATE TABLE Clip (
    clipID INT  PRIMARY KEY,
    title VARCHAR(30)  NOT NULL,
    startTime DATETIME  NOT NULL,
    endTime DATETIME  NOT NULL,
    streamID INT  NOT NULL,
    userID INT  NOT NULL
);

-- Table: Donation
CREATE TABLE Donation (
    donationID INT  PRIMARY KEY,
    amount INT  NOT NULL,
    time DATETIME  NOT NULL,
    streamID INT  NOT NULL,
    userID INT  NOT NULL
);

-- Table: Followers
CREATE TABLE Followers (
    followerID INT,
    followedID INT,
  PRIMARY KEY (followerID, followedID)
);

-- Table: Moderator
CREATE TABLE Moderator (
    moderatorID INT  PRIMARY KEY,
    assignedDate DATETIME  NOT NULL,
    permissions VARCHAR(40)  NOT NULL,
    userID INT  NOT NULL
);

-- Table: Notification
CREATE TABLE Notification (
    notificationID INT PRIMARY KEY,
    notifiedUserID INT  NOT NULL,
    notificationMessage VARCHAR(120)  NOT NULL,
    time DATETIME  NOT NULL
);

-- Table: Stream
CREATE TABLE Stream (
    streamID INT  PRIMARY KEY,
    title VARCHAR(30)  NOT NULL,
    startTime DATETIME  NOT NULL,
    endTime DATETIME  NOT NULL,
    streamerID INT  NOT NULL,
    categoryID INT  NOT NULL
);

-- Table: Stream_Advertisement
CREATE TABLE Stream_Advertisement (
    adID INT,
    streamID INT,
    startTime DATETIME  NOT NULL,
    endTime DATETIME  NOT NULL,
  PRIMARY KEY (adID, streamID)
);

-- Table: Stream_Moderator
CREATE TABLE Stream_Moderator (
    moderatorID INT,
    streamID INT,
  PRIMARY KEY (moderatorID, streamID)
);

-- Table: Stream_Viewer
CREATE TABLE Stream_Viewer (
    viewerID INT,
    streamID INT,
    PRIMARY KEY (viewerID,streamID)
);


-- Table: User
CREATE TABLE [User] (
    userID INT  PRIMARY KEY,
    username VARCHAR(20)  NOT NULL,
    email VARCHAR(40)  NOT NULL,
    password VARCHAR(20)  NOT NULL,
    registrationDate DATETIME  NOT NULL,
    lastLogIn DATETIME  NOT NULL
);

ALTER TABLE Notification
DROP COLUMN notificationID;

ALTER TABLE Notification
ADD notificationID INT IDENTITY(1,1) PRIMARY KEY;

-- foreign keys
-- Reference: Chat_message_Stream (table: Chat_message)
ALTER TABLE Chat_message ADD CONSTRAINT FK_Chat_message_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Chat_message_User (table: Chat_message)
ALTER TABLE Chat_message ADD CONSTRAINT FK_Chat_message_User
    FOREIGN KEY (userID)
    REFERENCES [User] (userID)
;

-- Reference: Clip_Stream (table: Clip)
ALTER TABLE Clip ADD CONSTRAINT FK_Clip_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Clip_User (table: Clip)
ALTER TABLE Clip ADD CONSTRAINT FK_Clip_User
    FOREIGN KEY (userID)
    REFERENCES [User] (userID)
;

-- Reference: Donation_Stream (table: Donation)
ALTER TABLE Donation ADD CONSTRAINT FK_Donation_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Donation_User (table: Donation)
ALTER TABLE Donation ADD CONSTRAINT FK_Donation_User
    FOREIGN KEY (userID)
    REFERENCES [User] (userID)
;

-- Reference: Followers_User1 (table: Followers)
ALTER TABLE Followers ADD CONSTRAINT FK_Followers_User1
    FOREIGN KEY (followerID)
    REFERENCES [User] (userID)
;

-- Reference: Followers_User2 (table: Followers)
ALTER TABLE Followers ADD CONSTRAINT FK_Followers_User2
    FOREIGN KEY (followedID)
    REFERENCES [User] (userID)
;

-- Reference: Moderator_User (table: Moderator)
ALTER TABLE Moderator ADD CONSTRAINT FK_Moderator_User
    FOREIGN KEY (userID)
    REFERENCES [User] (userID)
;

-- Reference: Notification_User (table: Notification)
ALTER TABLE Notification ADD CONSTRAINT FK_Notification_User
    FOREIGN KEY (notifiedUserID)
    REFERENCES [User] (userID)
;

-- Reference: Stream_Advertisement_Advertisement (table: Stream_Advertisement)
ALTER TABLE Stream_Advertisement ADD CONSTRAINT FK_Stream_Advertisement_Advertisement
    FOREIGN KEY (adID)
    REFERENCES Advertisement (adID)
;

-- Reference: Stream_Advertisement_Stream (table: Stream_Advertisement)
ALTER TABLE Stream_Advertisement ADD CONSTRAINT FK_Stream_Advertisement_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Stream_Category (table: Stream)
ALTER TABLE Stream ADD CONSTRAINT FK_Stream_Category
    FOREIGN KEY (categoryID)
    REFERENCES Category (categoryID)
;

-- Reference: Stream_Moderator_Moderator (table: Stream_Moderator)
ALTER TABLE Stream_Moderator ADD CONSTRAINT FK_Stream_Moderator_Moderator
    FOREIGN KEY (moderatorID)
    REFERENCES Moderator (moderatorID)
;

-- Reference: Stream_Moderator_Stream (table: Stream_Moderator)
ALTER TABLE Stream_Moderator ADD CONSTRAINT FK_Stream_Moderator_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Stream_User (table: Stream)
ALTER TABLE Stream ADD CONSTRAINT FK_Stream_User
    FOREIGN KEY (streamerID)
    REFERENCES [User] (userID)
;

-- Reference: Stream_Viewer_Stream (table: Stream_Viewer)
ALTER TABLE Stream_Viewer ADD CONSTRAINT FK_Stream_Viewer_Stream
    FOREIGN KEY (streamID)
    REFERENCES Stream (streamID)
;

-- Reference: Stream_Viewer_User (table: Stream_Viewer)
ALTER TABLE Stream_Viewer ADD CONSTRAINT FK_Stream_Viewer_User
    FOREIGN KEY (viewerID)
    REFERENCES [User] (userID)
;


-- inserts
INSERT INTO Category (categoryID, name)
  VALUES
  (1, 'Art'),
  (2, 'Sports'),
  (3, 'Music'),
  (4, 'Games'),
  (5, 'Chatting'),
  (6, 'Food'),
  (7, 'Fitness & Health')
;

INSERT INTO [User] (userID, username, email, password, registrationDate, lastLogIn)
  VALUES
  (1, 'blanee', 'blanee@gmail.com', 'h4htr48y4', '2015-06-06', '2023-12-24 08:00:00'),
  (2, 'painterPete', 'painterPete@gmail.com', 'rh8247yr', '2020-12-09',  '2023-12-13 12:00:00'),
  (3, 'soccerSally', 'soccerSally@gmail.com', 'fh498q42', '2022-10-06', '2023-01-08 10:00:00'),
  (4, 'chatMatt', 'chatMatt@gmail.com', 'g728guiwr', '2018-03-08', '2023-01-05 23:00:00'),
  (5, 'lyricLiz', 'lyricLiz@gmail.com', 'ah392r4yy', '2019-05-23', '2023-01-09 15:00:00'),
  (6, 'chefCharlie', 'chefCharlie@gmail.com', 'hrY32Y32', '2022-11-15', '2023-12-31 10:00:00'),
  (7, 'yogaYolanda', 'yogaYolanda@gmail.com', 'hsaud932', '2021-01-20', '2023-01-07 16:00:00')
;

INSERT INTO Stream (streamID, title, startTime, endTime, streamerID, categoryID)
  VALUES
  (1, 'playing osu!', '2023-12-20 19:00:00', '2023-12-20 23:00:00', 1, 4),
  (2, 'sketching', '2023-12-12 15:30:00', '2023-12-12 17:15:00', 2, 1),
  (3, 'training for osu tournir', '2023-10-06 20:00:00', '2023-12-07 01:20:00', 1, 4),
  (4, 'watching league of champions', '2023-09-30 18:00:00', '2023-09-30 22:00:00', 3, 2),
  (5, 'playing guitar', '2024-01-07 19:10:00', '2024-01-07 20:40:00', 5, 3),
  (6, 'evening yoga practice', '2024-01-06 20:00:00', '2024-01-06 21:45:00', 7, 7)
;

INSERT INTO Stream_Viewer (viewerID, streamID)
	VALUES
	(3, 1),
	(4, 1),
	(6, 2),
	(4, 2),
	(2, 3),
	(4, 3),
	(3, 3),
	(5, 3),
	(6, 3),
	(1, 4),
	(6, 4),
	(4, 5),
	(2, 5),
	(1, 6),
	(2, 6),
	(5, 6)
;


INSERT INTO Chat_message (messageID, content, time, streamID, userID)
  VALUES
  (1, 'Hi!', '2023-10-06 20:05:00', 3, 4),
  (2, 'How are you?', '2023-10-06 20:06:00', 3, 4),
  (3, 'You are doing well :)', '2023-10-06 20:15:00', 3, 2),
  (4, 'Wish you good luck tommorow', '2023-10-06 21:30:00', 3, 4),
  (5, 'Hey', '2023-12-12 15:40:00', 2, 6),
  (6, 'Could you draw my cat?', '2023-12-12 15:42:00', 2, 6),
  (7, 'How nice is that!', '2023-12-12 16:20:00', 2, 6),
  (8, 'Thanks for sharing this practice', '2024-01-06 21:40:00', 6, 5),
  (9, 'I feel much better after this', '2024-01-06 21:40:00', 6, 2),
  (10, 'Hi! Whats the model of your guitar?', '2024-01-07 19:30:00', 5, 2),
  (11, 'Could you play The Cure?', '2024-01-07 19:52:00', 5, 4)
;

INSERT INTO Donation (donationID, amount, time, streamID, userID)
  VALUES
  (1, 10, '2023-10-06 20:16:00', 3, 2),
  (2, 25, '2023-12-12 16:22:00', 2, 6),
  (3, 12, '2024-01-07 19:52:00', 5, 4)
;

INSERT INTO Clip (clipID, title, startTime, endTime, streamID, userID)
  VALUES
  (1, 'Highest score on map', '2023-10-06 20:12:00', '2023-10-06 20:17:00', 3, 4),
  (2, 'risky moment', '2023-09-30 20:26:00', '2023-09-30 20:30:00', 4, 6)
;

INSERT INTO Moderator (moderatorID, assignedDate, permissions, userID)
  VALUES
  (1, '2023-10-17', 'change chat modes', 2),
  (2, '2023-03-06', 'change chat modes, ban users', 4),
  (3, '2022-07-12', 'ban users', 1)
;

INSERT INTO Stream_Moderator (moderatorID, streamID)
  VALUES
  (1, 2),
  (2, 3),
  (3, 4)
;

INSERT INTO Advertisement (adID, content, sponsorName)
  VALUES
  (1, 'video ad', 'Arizona'),
  (2, 'streamer showing the product', 'LogiTech'),
  (3, 'video ad', 'Nike'),
  (4, 'streamer showing the product', 'YogaWear')
;

INSERT INTO Stream_Advertisement (adID, streamID, startTime, endTime)
  VALUES
  (1, 1, '2023-12-20 21:00:00', '2023-12-20 21:01:00'),
  (1, 2, '2023-12-12 16:30:00', '2023-12-12 16:31:00'),
  (2, 1, '2023-12-20 19:20:00', '2023-12-20 19:25:00'),
  (3, 4, '2023-09-30 18:00:00', '2023-09-30 18:02:00'),
  (4, 6, '2024-01-06 20:05:00', '2024-01-06 20:08:00')
;

INSERT INTO Followers (followerID, followedID)
  VALUES
  (4, 1),
  (2, 1),
  (5, 1),
  (6, 2),
  (2, 3),
  (5, 7),
  (2, 7),
  (1, 2),
  (4, 5)
;

