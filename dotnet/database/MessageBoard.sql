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

CREATE TABLE replys(
	reply_id int IDENTITY(1,1)NOT NULL,
	reply_content NVARCHAR(MAX),
	up_votes INT NOT NULL,
	down_votes INT NOT NULL,
	date_created DATETIME NOT NULL,
	CONSTRAINT PK_replys PRIMARY KEY(reply_id)
);

--CREATE TABLE thread(
--thread_id INT IDENTITY(10000,1)NOT NULL,
--thread_title VARCHAR(50)NOT NULL,
--posts_in_thread INT NULL,
--date_created DATE NOT NULL
--CONSTRAINT PK_thread PRIMARY KEY(thread_id)
--)

CREATE TABLE user_reply(
	user_id INT NOT NULL,
	reply_id INT NOT NULL,
	CONSTRAINT [PK_user_reply] PRIMARY KEY(user_id, reply_id),
	FOREIGN KEY(user_id) REFERENCES [users] (user_id),
	FOREIGN KEY(reply_id) REFERENCES [replys] (reply_id)
);

CREATE TABLE reply_forum(
	reply_id INT NOT NULL,
	forum_id INT NOT NULL,
	CONSTRAINT [PK_reply_thread] PRIMARY KEY(reply_id, forum_id),
	FOREIGN KEY(reply_id) REFERENCES [replys] (reply_id),
	FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
);


--CREATE TABLE thread_forum(
--thread_id INT NOT NULL,
--forum_id INT NOT NULL,
--CONSTRAINT [PK_thread_forum] PRIMARY KEY(thread_id, forum_id)
--FOREIGN KEY(thread_id) REFERENCES [thread] (thread_id),
--FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
--)

CREATE TABLE user_forum(
	user_id INT NOT NULL,
	forum_id INT NOT NULL,
	is_moderator BIT NOT NULL,
	CONSTRAINT [PK_user_forum] PRIMARY KEY (user_id, forum_id),
	FOREIGN KEY(user_id) REFERENCES [users] (user_id),
	FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
);

CREATE TABLE favorited_forums(
	user_id INT NOT NULL,
	forum_id INT NOT NULL,
	favorited BIT NOT NULL,
	CONSTRAINT [PK_favorited_forums] PRIMARY KEY (user_id, forum_id),
	FOREIGN KEY(user_id) REFERENCES [users] (user_id),
	FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
);

--populate default data
--Inserting Users --
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');


INSERT INTO forum (forum_title, forum_description, image_path, date_created)
VALUES
  ('Technology Forum', 'Discuss the latest in technology', '/images/tech_forum.jpg', '2023-01-01T10:00:00'),
  ('Travel Enthusiasts', 'Share your travel experiences and tips', '/images/travel_forum.jpg', '2023-01-02T12:30:00'),
  ('Fitness Fanatics', 'Stay fit and healthy together', '/images/fitness_forum.jpg', '2023-01-03T15:45:00'),
  ('Book Lovers Club', 'Explore the world of literature', '/images/book_forum.jpg', '2023-01-04T18:15:00'),
  ('Gaming Galaxy', 'Level up your gaming experience', '/images/gaming_forum.jpg', '2023-01-05T21:00:00'),
  ('Cooking Corner', 'Share your favorite recipes and cooking tips', '/images/cooking_forum.jpg', '2023-01-06T09:30:00'),
  ('Artistic Minds', 'Discuss and showcase your artistic creations', '/images/art_forum.jpg', '2023-01-07T11:45:00'),
  ('Finance Wizards', 'Master the art of personal finance', '/images/finance_forum.jpg', '2023-01-08T14:20:00');

  INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP -1));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP +1));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP -2));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP-3));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP -4));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP -5));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, (CURRENT_TIMESTAMP -6));
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);
INSERT INTO replys (reply_content, up_votes, down_votes, date_created) 
VALUES ('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie at elementum eu facilisis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Ac tortor vitae purus faucibus ornare suspendisse. Lectus nulla at volutpat diam. Dui accumsan sit amet nulla facilisi morbi tempus iaculis. Ultricies lacus sed turpis tincidunt id aliquet. Cursus euismod quis viverra nibh cras pulvinar mattis. Nec dui nunc mattis enim ut tellus elementum sagittis vitae. Aliquam faucibus purus in massa tempor nec feugiat. Commodo nulla facilisi nullam vehicula ipsum. Feugiat vivamus at augue eget arcu dictum varius. Nisl condimentum id venenatis a condimentum.' , 0, 0, CURRENT_TIMESTAMP);


-- Inserting