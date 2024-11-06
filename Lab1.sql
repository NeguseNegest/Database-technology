CREATE TABLE Users (
    UserID INTEGER NOT NULL,
    Username VARCHAR(300) NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE Friendship (
    UserID1 INTEGER NOT NULL,
    UserID2 INTEGER NOT NULL,
    PRIMARY KEY (UserID1, UserID2),
    FOREIGN KEY (UserID1) REFERENCES Users(UserID),
    FOREIGN KEY (UserID2) REFERENCES Users(UserID)
);

CREATE TABLE Post (
    PostID INTEGER NOT NULL,
    CHECK (PostID >= 0),--This is an attribute based constraint 
    UserID INTEGER NOT NULL,
    Title VARCHAR(300),
    Date DATE NOT NULL,
    Place VARCHAR(300),
    PRIMARY KEY (PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE PostTags (
    PostID INTEGER NOT NULL,
    Tag VARCHAR(10) NOT NULL CHECK (Tag IN ('Crypto', 'Studying', 'Question', 'Social')),
    FOREIGN KEY (PostID) REFERENCES Post(PostID),
    PRIMARY KEY (PostID, Tag)  
);

CREATE TABLE ImagePost (
    PostID INTEGER,
    URL VARCHAR(300) NOT NULL,
    Filter VARCHAR(300),
    PRIMARY KEY (PostID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

CREATE TABLE TextPost (
    PostID INTEGER,
    Content VARCHAR(700) NOT NULL,
    PRIMARY KEY (PostID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

CREATE TABLE VideoPost (
    PostID INTEGER,
    URL VARCHAR(300) NOT NULL,
    Codec VARCHAR(50) NOT NULL,
    PRIMARY KEY (PostID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

CREATE TABLE PostLike (
    PostID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    Timestamp DATE NOT NULL,
    PRIMARY KEY (PostID, UserID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

CREATE TABLE Event (
    EventID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    Title VARCHAR(300) NOT NULL,
    Place VARCHAR(300) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Duration INTEGER NOT NULL,
    PRIMARY KEY (EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CHECK (StartDate <= EndDate)  -- This is a tuple based constraint, this essentially means we are comparing two columns.
);

CREATE TABLE Attendee (
    EventID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    PRIMARY KEY (EventID, UserID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Subscription (
    SubscriptionID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,  
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL, 
    CHECK (PaymentMethod IN ('Klarna', 'Swish', 'Card', 'Bitcoin')),
    ExpiryDate DATE NOT NULL,
    PRIMARY KEY (SubscriptionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Populating the database. Task 3 in lab. 
/*The database must contain at least:
a. 6 users
b. At least 4 friend relationships
c. 3 posts, one of each type (Text, Video & Image)
Each post must have:
- between 0-2 tags, where at least one must have 2 or more tags.
- between 1-6 likes
d. 1 Event
- created/hosted by 1 user
- only friends of the host will attend
e. 6 subscriptions'*/

INSERT INTO Users(UserID,Username) VALUES
(1,'JAMES'),
(2,'Michael'),
(3,'Mrbean'),
(4,'Alfred'),
(5,'Jonathan'),
(6,'Gabriel');

INSERT INTO Friendship(UserID1,UserID2) VALUES
(1,5),
(2,4),
(1,6),
(3,5);

INSERT INTO Post(PostID, UserID, Title, Date, Place) VALUES
    (7, 1, 'Trying to finish the lab', '2024-11-01', 'Stockholm Central'),
    (8, 3, 'Have you heard about this crypto?', '2024-07-05', 'Cafe'),
    (9, 6, 'Sitting at this wonderful place', '2024-09-15', 'Beach');

INSERT INTO PostTags(PostID, Tag) VALUES
    (7, 'Studying'),       
    (8, 'Crypto'),          
    (8, 'Question'),        
    (9, 'Social');          

INSERT INTO TextPost(PostID, Content) VALUES 
    (7, 'I am really trying to finish this lab on time! Anyone want to join?');

INSERT INTO ImagePost(PostID, URL, Filter) VALUES 
    (8, 'http://images.example.com/crypto_talk.png', 'Vintage');

INSERT INTO VideoPost(PostID, URL, Codec) VALUES 
    (9, 'http://videos.example.com/beach_view.mp4', 'H.264');

INSERT INTO PostLike(PostID, UserID, Timestamp) VALUES 
    (7, 2, '2024-11-01'),
    (7, 4, '2024-11-01'),
    (8, 1, '2024-07-05'),
    (8, 5, '2024-07-06'),
    (9, 3, '2024-09-15'),
    (9, 6, '2024-09-16');

INSERT INTO Event(EventID, UserID, Title, Place, StartDate, EndDate, Duration) VALUES 
    (1, 1, 'Study Group Meetup', 'University Library', '2024-11-04', '2024-11-04', 2);

INSERT INTO Attendee(EventID, UserID) VALUES 
    (1, 5),
    (1, 6);

INSERT INTO Subscription(SubscriptionID, UserID, PaymentDate, PaymentMethod, ExpiryDate) VALUES 
    (1, 1, '2024-10-01', 'Klarna', '2024-10-31'),
    (2, 2, '2024-10-02', 'Swish', '2024-11-01'),
    (3, 3, '2024-10-03', 'Card', '2024-11-02'),
    (4, 4, '2024-10-04', 'Bitcoin', '2024-11-03'),
    (5, 5, '2024-10-05', 'Klarna', '2024-11-04'),
    (6, 6, '2024-10-06', 'Swish', '2024-11-05');


SELECT Username AS FULLNAMES FROM Users;
SELECT UserID1, UserID2 FROM Friendship;
SELECT PostID, Content FROM TextPost;
SELECT PostID, URL, Codec FROM VideoPost;
SELECT PostID, URL, Filter FROM ImagePost;
SELECT EventID, UserID AS Host, Title, Place, StartDate, EndDate, Duration FROM Event;

SELECT SubscriptionID, UserID, PaymentDate, PaymentMethod, ExpiryDate FROM Subscription;


