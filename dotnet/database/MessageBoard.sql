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

--populate default data
--Inserting Users --
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user', 'student@techelevator.com');
INSERT INTO users (username, password_hash, salt, user_role, user_email) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'admin@rediquette.com');


INSERT INTO forum (forum_title, forum_description, image_path, date_created)
VALUES
  ('Technology Forum', 'Discuss the latest in technology', 'https://picsum.photos/301/400', '2023-01-01T10:00:00'),
  ('Travel Enthusiasts', 'Share your travel experiences and tips', 'https://picsum.photos/301/400', '2023-01-02T12:30:00'),
  ('Fitness Fanatics', 'Stay fit and healthy together', 'https://picsum.photos/301/400', '2023-01-03T15:45:00'),
  ('Book Lovers Club', 'Explore the world of literature', 'https://picsum.photos/301/400', '2023-01-04T18:15:00'),
  ('Gaming Galaxy', 'Level up your gaming experience', 'https://picsum.photos/301/400', '2023-01-05T21:00:00'),
  ('Cooking Corner', 'Share your favorite recipes and cooking tips', 'https://picsum.photos/301/400', '2023-01-06T09:30:00'),
  ('Artistic Minds', 'Discuss and showcase your artistic creations', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  ('Finance Wizards', 'Master the art of personal finance', 'https://picsum.photos/301/400', '2023-01-08T14:20:00');

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