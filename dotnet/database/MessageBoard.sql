USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL,
	user_email varchar(250)NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);


CREATE TABLE forum(
	forum_id INT IDENTITY(1,1)NOT NULL,
	forum_title NVARCHAR(50)NOT NULL,
	forum_description NVARCHAR(1000)NOT NULL,
	image_path VARCHAR(200) NULL,
	date_created DATETIME NOT NULL,
	CONSTRAINT PK_forum PRIMARY KEY(forum_id),
);

CREATE TABLE posts(
	post_id int IDENTITY(1,1)NOT NULL,
	user_id int NOT NULL,
	post_title varchar NOT NULL,
	post_content NVARCHAR(MAX),
	post_image VARBINARY NULL,
	post_imgurl VARCHAR NULL,
	date_created DATETIME NOT NULL,
	forum_id INT NOT NULL,
	CONSTRAINT PK_posts PRIMARY KEY(post_id),
	CONSTRAINT FK_ForumPosts FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id),
	CONSTRAINT FK_UsersPosts FOREIGN KEY(user_id) REFERENCES [users] (user_id),	
);

CREATE TABLE comment(
	comment_id int IDENTITY(1,1) NOT NULL,
	user_id int NOT NULL,
	post_id int NOT NULL,
	comment_content NVARCHAR(MAX),
	date_created DATETIME NOT NULL,
	forum_id int NOT NULL,
	parent_id int NULL,
	CONSTRAINT PK_comment PRIMARY KEY(comment_id),
	CONSTRAINT FK_UsersComment FOREIGN KEY(user_id) REFERENCES users(user_id),
	CONSTRAINT FK_PostComment FOREIGN KEY (post_id) REFERENCES posts(post_id),
	CONSTRAINT FK_ForumComment FOREIGN KEY(forum_id) REFERENCES forum(forum_id),
	CONSTRAINT FK_CommentRecur FOREIGN KEY (parent_id) REFERENCES comment(comment_id),
);

CREATE TABLE user_forum(
	user_id INT NOT NULL,
	forum_id INT NOT NULL,
	is_favorited BIT NOT NULL,
	is_moderator BIT NOT NULL,
	CONSTRAINT [PK_user_forum] PRIMARY KEY (user_id, forum_id),
	CONSTRAINT FK_UserUF FOREIGN KEY(user_id) REFERENCES [users] (user_id),
	CONSTRAINT FK_ForumUF FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
);

CREATE TABLE post_votes(
	user_id INT NOT NULL,
	target_id INT NOT NULL,
	inc INT NOT NULL,
	CHECK (inc in (-1,1)),
	CONSTRAINT PK_post_votes PRIMARY KEY (user_id, target_id),
	CONSTRAINT FK_userPV FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_postPV FOREIGN KEY (target_id) REFERENCES posts(post_id)
);

CREATE TABLE comment_votes(
	user_id INT NOT NULL,
	target_id INT NOT NULL,
	inc INT NOT NULL,
	CHECK (inc in (-1,1)),
	CONSTRAINT PK_comment_votes PRIMARY KEY (user_id, target_id),
	CONSTRAINT FK_userCV FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_commentCV FOREIGN KEY (target_id) REFERENCES comment(comment_id)
);

--populate default data
--Inserting Users --
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user', 'student@techelevator.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'admin@rediquette.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('omar', 'CIg+yNbN/5HBMzjqZlmQvyJgxqU=', '47eHKmONCLQ=', 'admin', 'omar@omar.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('jenny', 'QWBFDVUqqT/lrUtlqXVwSvieIcE=', 'oTId1s8xJRs=', 'admin', 'jenny@jenny.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('mac','L9PuttSomTIhB+1pNvQQZq4Gz8M=', 'Y0PpDvZ6k3M=', 'admin', 'mac@mac.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('wayne', 'Q4l+GG376OQMip/n9pN3iaWcov0=', 'py0HLDIdK6Q=', 'admin', 'wayne@wayne.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('john', 'w/dBq/PVRHyI9HJ/6RX04FPFv64=', 'QvRYQP+fnSg=', 'admin', 'john@john.com');

SET IDENTITY_INSERT forum ON
INSERT INTO forum (forum_id, forum_title, forum_description, image_path, date_created)
VALUES
  (1, 'Tech Enthusiasts Unite', 'Discuss the latest gadgets and innovations!', 'https://fastly.picsum.photos/id/7/300/400', '2023-01-01T10:00:00'),
  (2, 'Pop Culture Club', 'Discuss the latest in Pop Culture and related happenings!', 'https://picsum.photos/301/400', '2023-01-02T12:30:00'),
  (3, 'Creative Minds Hub', 'Share your art, writing, and other passions', 'https://picsum.photos/301/400', '2023-01-03T15:45:00'),
  (4, 'Fitness Fanatics Forum', 'Achieve your health and wellness goals together', 'https://picsum.photos/301/400', '2023-01-04T18:15:00'),
  (5, 'Travel Tales Exchange', 'Share your best travel stories!', 'https://picsum.photos/301/400', '2023-01-05T21:00:00'),
  (6, 'Global Conflicts Dialogue', 'Navigate discussions on the Israeli-Palestinian conflict and its parallels with the war in Ukraine. Foster understanding and explore potential connections for a world in search of peace.', 'https://picsum.photos/301/400', '2023-01-06T09:30:00'),
  (7, 'Foodie Haven', 'Explore culinary delights, share recipes, and discuss your favorite dining experiences!', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  (8, 'Tech Tips and Tricks', 'Exchange hacks, tips, and tricks for mastering the latest technologies!', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  (9, 'Bookworms Corner', 'Dive into the world of literature! Share book recommendations, discuss plots, and connect with fellow book enthusiasts.', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  (10, 'Gaming Galore', 'Level up your gaming discussions! From latest releases to all-time classics, join fellow gamers in the ultimate gaming community.', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  (11, 'Mindfulness Oasis', 'Embark on a journey of self-discovery. Discuss mindfulness practices, meditation techniques, and wellness strategies.', 'https://picsum.photos/301/400', '2023-01-04T18:15:00');
SET IDENTITY_INSERT forum OFF

SET IDENTITY_INSERT posts ON
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES (1, 1, 'C# Better than Java?', 'C# is the supreme Coding Language! But Ultimately, the choice between C# and Java depends on the specific project requirements, the existing tech stack, and the preferences and expertise of the development team. Both languages have strengths and weaknesses, and neither is inherently better than the other in all situations.', 'https://www.bairesdev.com/wp-content/uploads/2021/07/Csharp.svg', '12/07/2023 12:31:25',1),
		(2, 1, 'Travel NE OHIO', 'Embark on a Northeast Ohio Adventure: Discover the hidden gems and vibrant landscapes of the region. From the scenic beauty of Cuyahoga Valley National Park to the cultural delights of Cleveland, explore the diverse experiences waiting for you in Northeast Ohio. Whether you''re into outdoor adventures, arts and culture, or culinary delights, this charming corner of the state offers something for every traveler.', 'https://i.gifer.com/9sbb.gif', '02/14/2021 04:34:55', 5),
		(3, 4, 'Junior Dev Jobs Real?', 'Junior developer positions are very much real and serve as valuable entry points for individuals entering the field of software development. These roles provide aspiring developers with hands-on experience, mentorship, and an opportunity to contribute to real projects while building a foundation for their career growth.', 'https://picsum.photos/301/400', '03/14/2022 15:53:34', 1),
		(4, 4, 'Taylor Swift New BF?', 'In an unexpected turn of events, the American Superstar, Taylor Swift, has been spotted cozying up with a mystery artist, sparking rumors of a budding romance. Fans are eagerly awaiting official confirmation and speculating about this potential power couple''s impact on both the music and Hollywood scenes.', 'https://images.saatchiart.com/saatchi/2039119/art/9754975/8818047-JEDUMUTR-7.jpg', '07/11/2022 17:23:34', 2)
		(5, 5, 'Big O Notation', 'Big O Notation, a key concept in computer science, provides a standardized way to express the efficiency of algorithms by characterizing their time or space complexity in relation to input size. It simplifies the comparison and analysis of algorithmic performance, aiding developers in making informed choices for designing scalable and efficient solutions.', 'https://www.doabledanny.com/static/2637207240bc4e7dcc8bca66c62c0560/2a43b/feature.jpg', '02/14/2022 02:00:00', 1)
		(6, 5, 'Ryan Days Time Up?', 'As the sporting landscape evolves, teams often find themselves at a crossroads, contemplating the prospect of a coaching change. Join the conversation as we discuss the factors that contribute to the decision of ushering in a new era with a fresh coaching perspective. From team performance and strategic vision to the dynamics of leadership, let's explore the signs that might indicate it's time for a change on the sidelines. Share your thoughts, insights, and opinions on what makes the perfect timing for a team to bring in a new coach and the potential impacts on the future of the game.', 'https://images.sidearmdev.com/crop?url=https%3A%2F%2Fdxbhsrqyrr690.cloudfront.net%2Fsidearm.nextgen.sites%2Fohiostatebuckeyes.com%2Fimages%2F2023%2F11%2F18%2F111823_FB_v_Minnesota_82.JPG&width=540&height=540', '08/14/2022 15:35:02'

INSERT INTO comment (user_id, post_id, comment_content, date_created, forum_id)
VALUES (3, 1, 'Great post very informative !', CURRENT_TIMESTAMP, 1),
    (3, 6, 'Thanks for sharing this information!', CURRENT_TIMESTAMP, 2),
    (3, 7, 'I have a question about this topic.', CURRENT_TIMESTAMP, 3),
    (4, 8, 'Well researched and nicely presented.', CURRENT_TIMESTAMP, 3),
    (5, 9, 'I appreciate the effort put into this post.', CURRENT_TIMESTAMP, 3),
    (6, 10, 'Great insights, keep it up!', CURRENT_TIMESTAMP, 4),
    (7, 11, 'I found this very helpful for my project.', CURRENT_TIMESTAMP, 4),
    (6, 12, 'Looking forward to more discussions on this topic.', CURRENT_TIMESTAMP, 5),
    (5, 13, 'Awesome content, thank you!', CURRENT_TIMESTAMP, 5),
    (4, 14, 'This post deserves more attention.', CURRENT_TIMESTAMP, 5),
    (3, 15, 'I shared this with my colleagues. Great work!', CURRENT_TIMESTAMP, 6),
	(2, 16, 'Thanks for sharing this information!', CURRENT_TIMESTAMP, 11),
    (3, 17, 'I have a question about this topic.', CURRENT_TIMESTAMP, 10),
    (4, 18, 'Well researched and nicely presented.', CURRENT_TIMESTAMP, 8),
    (5, 19, 'I appreciate the effort put into this post.', CURRENT_TIMESTAMP, 7),
    (6, 21, 'Great insights, keep it up!', CURRENT_TIMESTAMP, 6),
    (7, 20, 'I found this very helpful for my project.', CURRENT_TIMESTAMP, 9),
    (7, 19, 'Looking forward to more discussions on this topic.', CURRENT_TIMESTAMP, 11),
    (6, 18, 'Awesome content, thank you!', CURRENT_TIMESTAMP, 5),
    (5, 17, 'This post deserves more attention.', CURRENT_TIMESTAMP, 6),
    (4, 15, 'I shared this with my colleagues. Great work!', CURRENT_TIMESTAMP, 2);
*/

-- Inserting