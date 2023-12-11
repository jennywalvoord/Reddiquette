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
	CONSTRAINT PK_forum PRIMARY KEY(forum_id)
);

CREATE TABLE posts(
	post_id int IDENTITY(1,1)NOT NULL,
	user_id int NOT NULL,
	post_content NVARCHAR(MAX),
	up_votes INT NOT NULL,
	down_votes INT NOT NULL,
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
	up_votes int NOT NULL,
	down_votes INT NOT NULL,
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
	post_id INT NOT NULL,
	inc INT NOT NULL,
	CHECK (inc in (-1,1)),
	CONSTRAINT PK_post_votes PRIMARY KEY (user_id, post_id),
	CONSTRAINT FK_userPV FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_postPV FOREIGN KEY (post_id) REFERENCES posts(post_id)
);

CREATE TABLE comment_votes(
	user_id INT NOT NULL,
	comment_id INT NOT NULL,
	inc INT NOT NULL,
	CHECK (inc in (-1,1)),
	CONSTRAINT PK_comment_votes PRIMARY KEY (user_id, comment_id),
	CONSTRAINT FK_userCV FOREIGN KEY (user_id) REFERENCES users(user_id),
	CONSTRAINT FK_commentCV FOREIGN KEY (comment_id) REFERENCES comment(comment_id)
);

--populate default data
--Inserting Users --
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user', 'student@techelevator.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'admin@rediquette.com');


INSERT INTO forum (forum_title, forum_description, image_path, date_created)
VALUES
  ('Tech Enthusiasts Unite', 'Discuss the latest gadgets and innovations!', 'https://fastly.picsum.photos/id/7/300/400', '2023-01-01T10:00:00'),
  ('Pop Culture Club', 'Discuss the latest in Pop Culture and related happenings!', 'https://picsum.photos/301/400', '2023-01-02T12:30:00'),
  ('Creative Minds Hub', 'Share your art, writing, and other passions', 'https://picsum.photos/301/400', '2023-01-03T15:45:00'),
  ('Fitness Fanatics Forum', 'Achieve your health and wellness goals together', 'https://picsum.photos/301/400', '2023-01-04T18:15:00'),
  ('Travel Tales Exchange', 'Share your best travel stories!', 'https://picsum.photos/301/400', '2023-01-05T21:00:00'),
  ('Global Conflicts Dialogue', 'Navigate discussions on the Israeli-Palestinian conflict and its parallels with the war in Ukraine. Foster understanding and explore potential connections for a world in search of peace.', 'https://picsum.photos/301/400', '2023-01-06T09:30:00'),
  ('Foodie Haven', 'Explore culinary delights, share recipes, and discuss your favorite dining experiences!', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  ('Tech Tips and Tricks', 'Exchange hacks, tips, and tricks for mastering the latest technologies!', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  ('Bookworms Corner', 'Dive into the world of literature! Share book recommendations, discuss plots, and connect with fellow book enthusiasts.', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  ('Gaming Galore', 'Level up your gaming discussions! From latest releases to all-time classics, join fellow gamers in the ultimate gaming community.', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  ('Mindfulness Oasis', 'Embark on a journey of self-discovery. Discuss mindfulness practices, meditation techniques, and wellness strategies.', 'https://picsum.photos/301/400', '2023-01-04T18:15:00');

  INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' ,
			23, 
			532, 
			(CURRENT_TIMESTAMP -1),
			1,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' ,
			345, 
			23, 
			(CURRENT_TIMESTAMP +1),
			2,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			432, 
			231, 
			(CURRENT_TIMESTAMP -2),
			3,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			84320, 
			2313, 
			(CURRENT_TIMESTAMP-3),
			4,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			3422, 
			123, 
			(CURRENT_TIMESTAMP -4),
			5,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			7432, 
			323, 
			(CURRENT_TIMESTAMP -5),
			6,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			92932, 
			3271, 
			(CURRENT_TIMESTAMP -6),
			7,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			232, 
			23421, 
			CURRENT_TIMESTAMP,
			8,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			32348, 
			321932, 
			CURRENT_TIMESTAMP,
			1,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			32428, 
			5692, 
			CURRENT_TIMESTAMP,
			2,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			929282, 
			1, 
			CURRENT_TIMESTAMP,
			3,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			53921, 
			9328, 
			CURRENT_TIMESTAMP,
			4,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			28201, 
			52921, 
			CURRENT_TIMESTAMP,
			5,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			83291, 
			3421, 
			CURRENT_TIMESTAMP, 
			6,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			7238, 
			3291, 
			CURRENT_TIMESTAMP,
			7,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			32821, 
			992, 
			CURRENT_TIMESTAMP,
			8,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			82921, 
			3292, 
			CURRENT_TIMESTAMP,
			1,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			9281, 
			3214, 
			CURRENT_TIMESTAMP,
			2,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			8291, 
			321, 
			CURRENT_TIMESTAMP,
			3,
			1);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			3282, 
			482, 
			CURRENT_TIMESTAMP,
			4,
			2);
INSERT INTO posts (post_content, up_votes, down_votes, date_created, forum_id, user_id) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 
			92821, 
			32991, 
			CURRENT_TIMESTAMP,
			5,
			1);


-- Inserting