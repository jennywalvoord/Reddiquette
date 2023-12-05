CREATE TABLE replys(
reply_id int IDENTITY(100001,1)NOT NULL,
reply_content varchar(1000),
up_votes INT NULL,
down_votes INT NULL,
date_created DATE NOT NULL
CONSTRAINT PK_replys PRIMARY KEY(reply_id)
)

CREATE TABLE thread(
thread_id INT IDENTITY(10000,1)NOT NULL,
thread_title VARCHAR(50)NOT NULL,
posts_in_thread INT NULL,
date_created DATE NOT NULL
CONSTRAINT PK_thread PRIMARY KEY(thread_id)
)

CREATE TABLE forum(
forum_id INT IDENTITY(1001,1)NOT NULL,
forum_title VARCHAR(50)NOT NULL,
forum_description VARCHAR(250)NOT NULL,
image_path VARCHAR(200) NULL,
date_created DATE NOT NULL
CONSTRAINT PK_forum PRIMARY KEY(forum_id)
)

CREATE TABLE user_reply(
user_id INT NOT NULL,
reply_id INT NOT NULL
CONSTRAINT [PK_user_reply] PRIMARY KEY(user_id, reply_id)
FOREIGN KEY(user_id) REFERENCES [users] (user_id),
FOREIGN KEY(reply_id) REFERENCES [replys] (reply_id)
)

CREATE TABLE reply_thread(
reply_id INT NOT NULL,
thread_id INT NOT NULL
CONSTRAINT [PK_reply_thread] PRIMARY KEY(reply_id, thread_id)
FOREIGN KEY(reply_id) REFERENCES [replys] (reply_id),
FOREIGN KEY(thread_id) REFERENCES [thread] (thread_id)
)


CREATE TABLE thread_forum(
thread_id INT NOT NULL,
forum_id INT NOT NULL
CONSTRAINT [PK_thread_forum] PRIMARY KEY(thread_id, forum_id)
FOREIGN KEY(thread_id) REFERENCES [thread] (thread_id),
FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
)

CREATE TABLE user_forum(
user_id INT NOT NULL,
forum_id INT NOT NULL,
is_moderator BIT NOT NULL
CONSTRAINT [PK_user_forum] PRIMARY KEY (user_id, forum_id)
FOREIGN KEY(user_id) REFERENCES [users] (user_id),
FOREIGN KEY(forum_id) REFERENCES [forum] (forum_id)
)

CREATE TABLE favorited_forums(
user_id INT NOT NULL,
forum_id INT NOT NULL,
favorited BIT NOT NULL
)