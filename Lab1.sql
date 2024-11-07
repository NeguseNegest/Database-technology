
-----------TASK 2------------


CREATE TABLE Users (
    UserID INTEGER NOT NULL,
    Username VARCHAR(30) NOT NULL,
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
    CHECK (PostID >= 0), -- this is attribute-based constraint
    UserID INTEGER NOT NULL,
    Title VARCHAR(300),
    Date DATE NOT NULL,
    Place VARCHAR(300),
    Tags VARCHAR(30)[], 
    PRIMARY KEY (PostID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CHECK (Tags <@ ARRAY['Crypto', 'Studying', 'Question', 'Social']::VARCHAR(30)[])
    /*Ive added tags here in post table, now each tag entry can be multivalued, we have enforced the constraint
    that the entries to be either crypto , studying, question or social by using <@ operator.  */
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
    PostID INTEGER,
    UserID INTEGER NOT NULL,
    Timestamp DATE NOT NULL,
    PRIMARY KEY (PostID, UserID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PostID) REFERENCES Post(PostID)
);

CREATE TABLE Event (
    EventID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,
    Title VARCHAR(300),
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

CREATE TABLE Subscriptions (
    SubscriptionID INTEGER NOT NULL,
    UserID INTEGER NOT NULL,  
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(30) NOT NULL, 
    CHECK (PaymentMethod IN ('Klarna', 'Swish', 'Card', 'Bitcoin')),
    ExpiryDate DATE NOT NULL,
    CHECK(ExpiryDate>=PaymentDate),
    PRIMARY KEY (SubscriptionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


/*
1. What is a trigger?
2. Name 3 events that can cause a trigger to activate
3. What can be done with triggers?

1.Triggers in SQL are types of stored procedures that run in response to an event

2. Examples of triggers are INSERT, CREATE statement and DELETE.

3. Triggers are useful for maintaing the data integrity in the database. For example if we have a 
table that stores all the sales of a person then the total sale atttribute will be updated when a 
person makes a sale. 


*/

-------------------TASK 3------------------

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

INSERT INTO Post (PostID, UserID, Title, Date, Place, Tags) VALUES
    (7, 1, 'Trying to finish the lab', '2024-11-06', 'Stockholm Central', ARRAY['Studying']),
    (8, 3, 'Have you heard about this crypto?', '2024-07-05', 'Cafe', ARRAY['Crypto', 'Question']),
    (9, 6, 'Sitting at this wonderful place', '2024-09-15', 'Beach', ARRAY['Social']);
  

INSERT INTO TextPost(PostID, Content) VALUES 
    (7, 'I am really trying to finish this lab on time! Anyone want to to join?');

INSERT INTO ImagePost(PostID, URL, Filter) VALUES 
    (8, 'http://images.png', 'OLDSCHOOL');

INSERT INTO VideoPost(PostID, URL, Codec) VALUES 
    (9, 'http://videos.mp4', 'H.400');

INSERT INTO PostLike(PostID, UserID, Timestamp) VALUES 
    (7, 2, '2024-11-03'),
    (7, 4, '2024-11-01'),
    (8, 1, '2024-07-05'),
    (8, 5, '2024-07-06'),
    (9, 3, '2024-09-15'),
    (9, 6, '2024-09-16');

INSERT INTO Event(EventID, UserID, Title, Place, StartDate, EndDate, Duration) VALUES 
    (1, 1, 'Study Group', 'Uni Library', '2024-11-04', '2024-11-04', 2);

INSERT INTO Attendee(EventID, UserID) VALUES 
    (1, 5),
    (1, 6);

INSERT INTO Subscriptions(SubscriptionID, UserID, PaymentDate, PaymentMethod, ExpiryDate) VALUES 
    (1, 1, '2024-10-01', 'Klarna', '2024-10-31'),
    (2, 2, '2024-10-02', 'Swish', '2024-11-01'),
    (3, 3, '2024-10-03', 'Card', '2024-11-02'),
    (4, 4, '2024-10-04', 'Bitcoin', '2024-11-03'),
    (5, 5, '2024-10-05', 'Klarna', '2024-11-04'),
    (6, 6, '2024-10-06', 'Swish', '2024-11-06');



----------------------------TASK 4----------------------------

--SELECT * FROM Users;

SELECT Username AS FULLNAME FROM Users;
SELECT * FROM Friendship;
--SELECT * FROM Post INNER JOIN TextPost ON Post.postid=TextPost.postid;
SELECT * FROM TextPost;
SELECT * FROM VideoPost;
SELECT * FROM ImagePost;
SELECT EventID, UserID AS Host, Title, Place, StartDate, EndDate, Duration FROM Event;
SELECT * FROM Subscription;
SELECT PostID, Tag FROM PostTags;



--TRUNCATE TABLE PostLike, Users, TextPost, ImagePost, VideoPost, Post, Friendship, Event, Attendee, Subscriptions;

-------------------------- TASK P+------------------------



