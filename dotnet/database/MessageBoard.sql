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
	post_title varchar(1000) NOT NULL,
	post_content NVARCHAR(MAX) NOT NULL,
	--post_image VARBINARY NULL,
	post_imgurl VARCHAR(1000) NULL,
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
	forum_id int NULL,
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
SET IDENTITY_INSERT users ON

INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (1,'user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user', 'student@techelevator.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (2, 'admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'admin@rediquette.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (3, 'omar', 'CIg+yNbN/5HBMzjqZlmQvyJgxqU=', '47eHKmONCLQ=', 'admin', 'omar@omar.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (4, 'jenny', 'QWBFDVUqqT/lrUtlqXVwSvieIcE=', 'oTId1s8xJRs=', 'admin', 'jenny@jenny.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (5, 'mac','L9PuttSomTIhB+1pNvQQZq4Gz8M=', 'Y0PpDvZ6k3M=', 'admin', 'mac@mac.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (6, 'wayne', 'Q4l+GG376OQMip/n9pN3iaWcov0=', 'py0HLDIdK6Q=', 'admin', 'wayne@wayne.com');
INSERT INTO users (user_id, username, password_hash, salt, user_role, user_email) VALUES (7, 'john', 'w/dBq/PVRHyI9HJ/6RX04FPFv64=', 'QvRYQP+fnSg=', 'admin', 'john@john.com');
SET IDENTITY_INSERT users OFF

SET IDENTITY_INSERT forum ON
INSERT INTO forum (forum_id, forum_title, forum_description, image_path, date_created)
VALUES
  (1, 'Tech Enthusiasts Unite', 'Discuss the latest gadgets and innovations!', 'https://fastly.picsum.photos/id/7/300/400', '2023-01-01T10:00:00'),
  (2, 'Pop Culture Club', 'Discuss the latest in Pop Culture and related happenings!', 'https://picsum.photos/301/400', '2023-01-02T12:30:00'),
  (3, 'Creative Minds Hub', 'Share your art, writing, and other passions', 'https://picsum.photos/301/400', '2023-01-03T15:45:00'),
  (4, 'Fitness Fanatics Forum', 'Achieve your health and wellness goals together', 'https://picsum.photos/301/400', '2023-01-04T18:15:00'),
  (5, 'Travel Tales Exchange', 'Share your best travel stories!', 'https://picsum.photos/301/400', '2023-01-05T21:00:00'),
  (6, 'Global Conflicts Dialogue', 'Navigate discussions on the Israeli-Palestinian conflict and its parallels with the war in Ukraine. Foster understanding and explore potential connections for a world in search of peace.', 'https://picsum.photos/301/400', '2023-01-06T09:30:00'),
  (7,'Cleveland Sports Fever', 'Cheer for your favorite teams in the heart of the action!','https://picsum.photos/301/400','2023-01-03T15:35:00'),
  (8, 'Foodie Haven', 'Explore culinary delights, share recipes, and discuss your favorite dining experiences!', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  (9, 'Tech Tips and Tricks', 'Exchange hacks, tips, and tricks for mastering the latest technologies!', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  (10, 'Bookworms Corner', 'Dive into the world of literature! Share book recommendations, discuss plots, and connect with fellow book enthusiasts.', 'https://picsum.photos/301/400', '2023-01-07T11:45:00'),
  (11, 'Gaming Galore', 'Level up your gaming discussions! From latest releases to all-time classics, join fellow gamers in the ultimate gaming community.', 'https://picsum.photos/301/400', '2023-01-08T14:20:00'),
  (12, 'Mindfulness Oasis', 'Embark on a journey of self-discovery. Discuss mindfulness practices, meditation techniques, and wellness strategies.', 'https://picsum.photos/301/400', '2023-01-04T18:15:00'),
  (13, 'Science and Technology Hub', 'Explore the latest advancements in science and technology. Discuss breakthroughs, research findings, and future innovations!', 'https://picsum.photos/302/400', '2023-01-09T10:30:00'),
  (14, 'Music Lovers Lounge', 'Dive into the world of music! Share your favorite artists, discover new genres, and discuss the latest hits.', 'https://picsum.photos/303/400', '2023-01-10T12:45:00'),
  (15, 'Movie Buffs Club', 'Discuss the silver screen! Share your favorite movies, review the latest releases, and dive into discussions about cinematic masterpieces.', 'https://picsum.photos/304/400', '2023-01-11T15:00:00'),
  (16, 'Health and Wellness Exchange', 'Embrace a holistic approach to well-being. Share tips on fitness, nutrition, and mental health for a healthier lifestyle.', 'https://picsum.photos/305/400', '2023-01-12T17:15:00'),
  (17, 'Pet Lovers Paradise', 'Connect with fellow pet enthusiasts! Share stories about your furry friends, seek advice, and celebrate the joys of pet ownership.', 'https://picsum.photos/306/400', '2023-01-13T19:30:00'),
  (18, 'DIY Crafters Corner', 'Unleash your creativity! Share DIY projects, craft ideas, and connect with fellow artisans in this crafting haven.', 'https://picsum.photos/307/400', '2023-01-14T21:45:00'),
  (19, 'Language Learners Guild', 'Embark on a linguistic journey! Share language learning tips, resources, and connect with others passionate about mastering new languages.', 'https://picsum.photos/308/400', '2023-01-15T09:00:00'),
  (20, 'Environmental Advocates Hub', 'Discuss environmental issues, sustainable living, and advocate for a greener future. Join the conversation to make a positive impact on the planet.', 'https://picsum.photos/309/400', '2023-01-16T11:15:00'),
  (21, 'Fashion Trends Forum', 'Step into the world of fashion! Discuss the latest trends, share style tips, and connect with fashion enthusiasts from around the globe.', 'https://picsum.photos/310/400', '2023-01-17T13:30:00'),
  (22, 'Home Cooks Collective', 'Join fellow home cooks in sharing delicious recipes, cooking tips, and the joy of creating delightful meals in your own kitchen.', 'https://picsum.photos/311/400', '2023-01-18T15:45:00')
 SET IDENTITY_INSERT forum OFF;

 SET IDENTITY_INSERT posts ON;
INSERT INTO posts (post_id, user_id, post_title , post_content, post_imgurl, date_created, forum_id)
VALUES (1, 1, 'C# Better than Java?', 'C# is the supreme Coding Language! But Ultimately, the choice between C# and Java depends on the specific project requirements, the existing tech stack, and the preferences and expertise of the development team. Both languages have strengths and weaknesses, and neither is inherently better than the other in all situations.', 'https://www.bairesdev.com/wp-content/uploads/2021/07/Csharp.svg', '12/07/2023 12:31:25',1),
		(2, 1, 'Travel NE OHIO', 'Embark on a Northeast Ohio Adventure: Discover the hidden gems and vibrant landscapes of the region. From the scenic beauty of Cuyahoga Valley National Park to the cultural delights of Cleveland, explore the diverse experiences waiting for you in Northeast Ohio. Whether you''re into outdoor adventures, arts and culture, or culinary delights, this charming corner of the state offers something for every traveler.', 'https://i.gifer.com/9sbb.gif', '02/14/2023 04:34:55', 5),
		(3, 4, 'Junior Dev Jobs Real?', 'Junior developer positions are very much real and serve as valuable entry points for individuals entering the field of software development. These roles provide aspiring developers with hands-on experience, mentorship, and an opportunity to contribute to real projects while building a foundation for their career growth.', 'https://picsum.photos/301/400', '03/14/2023 15:53:34', 1),
		(4,  4, 'Taylor Swift New BF?', 'In an unexpected turn of events, the American Superstar, Taylor Swift, has been spotted cozying up with a mystery artist, sparking rumors of a budding romance. Fans are eagerly awaiting official confirmation and speculating about this potential power couple''s impact on both the music and Hollywood scenes.', 'https://images.saatchiart.com/saatchi/2039119/art/9754975/8818047-JEDUMUTR-7.jpg', '07/11/2022 17:23:34', 2),
		(5, 5, 'Big O Notation', 'Big O Notation, a key concept in computer science, provides a standardized way to express the efficiency of algorithms by characterizing their time or space complexity in relation to input size. It simplifies the comparison and analysis of algorithmic performance, aiding developers in making informed choices for designing scalable and efficient solutions.', 'https://www.doabledanny.com/static/2637207240bc4e7dcc8bca66c62c0560/2a43b/feature.jpg', '02/14/2023 02:00:00', 1),
		(6, 5, 'Ryan Days Time Up?', 'As the sporting landscape evolves, teams often find themselves at a crossroads, contemplating the prospect of a coaching change. Join the conversation as we discuss the factors that contribute to the decision of ushering in a new era with a fresh coaching perspective. From team performance and strategic vision to the dynamics of leadership, lets explore the signs that might indicate its time for a change on the sidelines. Share your thoughts, insights, and opinions on what makes the perfect timing for a team to bring in a new coach and the potential impacts on the future of the game.', 'https://images.sidearmdev.com/crop?url=https%3A%2F%2Fdxbhsrqyrr690.cloudfront.net%2Fsidearm.nextgen.sites%2Fohiostatebuckeyes.com%2Fimages%2F2023%2F11%2F18%2F111823_FB_v_Minnesota_82.JPG&width=540&height=540', '08/14/2023 15:35:02', 7),
		(7, 2, 'Tensions Rising in Palestine', 'In a world marked by geopolitical complexities, it''s essential to delve into the ongoing tensions in Palestine with a nuanced perspective. Join us in a thoughtful and respectful discussion as we explore the historical context, current events, and the multifaceted aspects contributing to the tensions in the region. Share your insights, engage in conversations about potential resolutions, and stay informed about the impact of these tensions on the lives of people in the area. Our aim is to foster understanding, empathy, and awareness as we navigate through the complexities of this pressing issue. Let''s engage in dialogue that encourages peaceful solutions and a path towards stability.', 'https://media.npr.org/assets/img/2023/10/26/gettyimages-1238754440-71b4adae9b304a022fb2f3c82ef9207d66f5cf96-s1100-c50.jpg', '07/10/2023 05:34:52',6),
		(8, 5, 'Van Gogh Inspiration', 'Vincent van Gogh, the legendary Dutch artist, continues to captivate hearts with his timeless masterpieces. Join us as we embark on a journey into the vibrant and emotionally charged world of Van Gogh''s art. From his iconic sunflowers to the swirling starry night sky, let''s delve into the profound inspiration behind his work.','https://i.pinimg.com/originals/35/94/d1/3594d121c1c289e72ea4e7fe52bf9a08.gif', '12/09/2023 20:43:23', 3),
		(9, 5, 'Art + Coding', 'Step into the mesmerizing realm where art and coding collide! Join us on a journey to explore the innovative and visually stunning projects that arise from the synergy between artistic expression and programming expertise. From generative art and interactive installations to animations powered by algorithms, discover how creatives are pushing the boundaries of traditional art using the language of code. Engage in conversations about the latest tools, techniques, and the limitless possibilities that arise when art meets technology. Whether you''re an artist looking to integrate code or a coder seeking to unleash your creative side, this is the space where inspiration knows no bounds!','https://camo.githubusercontent.com/61491d59e71fec5c794945fed916a4a682b6c0404fc31f30b08a0d919c558404/68747470733a2f2f696d616765732e73717561726573706163652d63646e2e636f6d2f636f6e74656e742f76312f3537363966633430316236333162616231616464623261622f313534313538303631313632342d5445363451474b524a4738535741495553374e532f6b6531375a77644742546f6464493870446d34386b506f73776c7a6a53564d4d2d53784f703743563539425a772d7a505067646e346a557756634a45315a7657515578776b6d794578676c4e714770304976544a5a616d574c49327a76595748384b332d735f3479737a63703272795449304871544f6161556f68724938504936465879386339505774426c7141566c555335697a7064634958445a71445976707252715a32395077306f2f636f64696e672d667265616b2e676966', '04/14/2023 21:34:12', 3),
		(10, 3, 'Top 10 Side Projects', 'Looking to supercharge your coding prowess? Dive into a world of innovation and skill-building with our curated list of the top 10 coding side projects. From creating your own mobile app to building a personalized website or diving into open-source contributions, these projects offer a perfect blend of challenge and creativity. Join the discussion, share your experiences, and discover how these side projects can not only enhance your coding skills but also make a meaningful impact on your portfolio. Let the coding adventures begin!', 'https://yt3.googleusercontent.com/ytc/APkrFKYLNsV9KKOx14NlioRaICEknmhkO5UvNx5gKPAG=s900-c-k-c0x00ffffff-no-rj', '07/14/2023 23:51:34',1),
		(11, 5, 'Deshaun Watson Mistake!', 'Deshaun Watson was a mistake because we took a cost controlled quarterback that we could have signed to a reasonable contract and built the team around and tossed him.  Deshaun came with too much baggage, cost too much and had not played in 2 years.  This is worse than Jimmy drafting JFF', 'https://www.cleveland.com/resizer/d7KTtoo3GLYDfFI4I0LyqTnVu7A=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/PSHW3MVM2NESBA6AUSE2ODE32A.jpg', '12/06/2023 03:31:01', 7),
		(12, 3, 'Kanyes New Album!', 'Get ready for a sonic journey like no other as Kanye West, the maestro of reinvention, drops his highly anticipated new album. Join the conversation as fans and music enthusiasts dissect the tracks, decipher the lyrics, and discuss the overall vibe of this latest musical creation. From unexpected collaborations to groundbreaking production, let''s explore the artistic evolution and cultural impact of Kanye''s newest masterpiece. Share your favorite tracks, memorable moments, and theories about the deeper meanings embedded in the album. It''s time to immerse ourselves in the world of Yeezy and embrace the next chapter of his musical legacy!', 'https://preview.redd.it/cuylsl10lkk81.png?auto=webp&s=cfbb32a73ea242f1a70c92024e6ece89a04855d2', '09/04/2023 02:55:23', 2),
		(13, 4, 'Drakes Hidden Message?', 'The rap icon and Toronto native, Drake, has set tongues wagging with a mysterious social media post that seems to hold a cryptic message about a potential baseball blockbuster trade. Fans and sports enthusiasts alike are speculating on the hidden meaning behind Drake''s latest Instagram or Twitter post, with many trying to connect the dots between his lyrics, emojis, and possible hints about player transfers.', 'https://www.si.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MjAyNzc2MDYzNDY4NjQzMzk2/drake-jersey.jpg', '12/10/2021 23:55:59', 2),
		(14, 1, 'Cardio And Wine?', 'Ever wondered if you can enjoy a good workout while sipping on your favorite glass of wine? Join us as we delve into the emerging trend that combines fitness and the love of wine. From wine-fueled cardio classes to wellness events that celebrate both the joys of movement and the pleasures of a fine vintage, discover how enthusiasts are embracing this unique fusion. Let''s uncork the possibilities, explore the balance between indulgence and exercise, and perhaps find a new way to raise our heart rates while toasting to a healthier lifestyle. Cheers to the unexpected synergy of cardio and wine!', 'https://vinepair.com/wp-content/uploads/2016/01/wine-fitness-social.png', '12/9/2022 07:03:34', 4),
		(15, 2, 'Best Yoga Alternatives', 'For those seeking a holistic approach to well-being beyond traditional yoga, join us on a journey to discover alternative practices that nurture mind, body, and spirit. From dynamic workouts that fuse strength and flexibility to mindful meditation practices that promote inner calm, explore a range of alternatives tailored to diverse preferences and fitness levels. Whether you''re a seasoned yogi looking to mix things up or a newcomer curious about holistic wellness, let''s explore the myriad paths to self-discovery and balance. Embrace the diversity of well-being practices that extend beyond the yoga mat!', 'https://mir-s3-cdn-cf.behance.net/project_modules/hd/2f572281374889.5cfe294fd0d7b.gif', '02/14/2023 06:24:55', 4),
		(16, 2, 'Niagara Trip Itinerary', 'Embark on a journey of natural wonder and adventure with our comprehensive guide to planning the ultimate Niagara trip! From the iconic falls to charming nearby attractions, we''ll help you curate an itinerary that maximizes your experience. Discover the best viewpoints, explore hidden gems, and find the tastiest local treats as you prepare for an unforgettable escapade to one of the world''s most awe-inspiring destinations. Let the planning begin, and get ready to immerse yourself in the breathtaking magic of Niagara Falls!', 'https://images.squarespace-cdn.com/content/v1/5f879a57f3f38524be9cc6cb/1629811536339-M1UNK5S9DQ5V84ARM8R7/Niagara-at-Night.gif', '10/07/2023 16:45:52', 5),
		(17, 5, 'Gaza Death Toll Rising', 'In this crucial conversation, we address the heartbreaking and concerning situation as the death toll rises in Gaza. Join us to discuss the human impact, the complexities of the conflict, and the pressing need for a peaceful resolution. Let''s foster understanding, empathy, and awareness as we explore the latest developments, humanitarian efforts, and the international community''s role in addressing this urgent crisis. Our thoughts are with those affected, and together, we strive to shine a light on the path toward peace and justice.', 'https://media.cnn.com/api/v1/images/stellar/prod/231208101322-gaza-bombing-120823.jpg?c=16x9&q=h_833,w_1480,c_fill', '11/14/2023 05:26:48', 6),
		(18, 6, 'Columbus Crew Champions!', 'Join us in jubilation as we salute the Columbus Crew, the undisputed champions! After an exhilarating season filled with grit, teamwork, and unforgettable moments, the Crew has emerged victorious. Share your elation, relive the standout plays, and discuss the key moments that led to this well-deserved triumph. It''s a celebration of soccer prowess and the unyielding spirit that defines champions. Congratulations to the Columbus Crew forever etched in the annals of soccer glory!', 'https://www.dispatch.com/gcdn/authoring/authoring-images/2023/12/03/NCOD/71792993007-crew-1202-fcc-ac-80.JPG?width=660&height=440&fit=crop&format=pjpg&auto=webp', '07/14/2023 14:53:42', 7),
		(19, 2, 'Historic Landmarks Destroyed', 'In this solemn discussion, we delve into the pages of history to mourn the loss of once-iconic landmarks that have succumbed to the ravages of time, conflict, or natural disasters. Join us as we remember and honor these architectural marvels, exploring their significance and the cultural heritage they held. Let''s engage in a thoughtful reflection on the fragility of our shared history and the importance of preservation for generations to come.', '"https://picsum.photos/301/407', '09/14/2020 17:52:35', 6),
		(20, 1, 'Exotic Flight Destinations', 'Unleash Your Wanderlust: Discover Exotic Flight Destinations! Ready to elevate your travel dreams? Explore the extraordinary with our guide to the most exotic flight destinations. From hidden gems nestled in tropical paradises to culturally rich cities off the beaten path, join us as we embark on a journey to uncover the worlds most enchanting and unforgettable places. Get ready to add a touch of exotic allure to your travel bucket list!', 'https://picsum.photos/306/400', '07/04/2022 18:23:46', 5),
		(21, 4, 'Need Help Dieting?', 'Embarking on a journey to better health through dieting? Whether you''re aiming for weight loss, muscle gain, or simply adopting a healthier lifestyle, our community is here to offer support, tips, and personalized advice. Join us in the quest for a balanced and sustainable diet that aligns with your fitness goals because achieving your best self starts with nourishing your body right!', 'https://www.heartfoundation.org.au/getmedia/70195972-0139-4ce8-a170-ffdf2aa24f60/200615-Healthy-Eating-Gif3.gif', '08/14/2022 19:36:25', 4),
		(48, 7, 'Hidden Gems in Local Eateries', 'Explore the culinary scene in your city! Recommend hidden gem restaurants, share your recent dining experiences, and lets create a Foodie Haven guide to the best local spots.', 'https://picsum.photos/301/400', '02/14/2022 08:00:00', 8),
		(49, 7, 'Delicious Dessert Discoveries', 'Indulge your sweet tooth! Share your favorite dessert recipes, explore local bakeries, and lets compile a delectable list of must-try treats.', 'https://picsum.photos/302/400', '2022-03-02 15:30:00', 8),
		(50, 7, 'Spicy Adventures: Hot Pepper Challenge', 'Calling all spice enthusiasts! Join in on the hot pepper challenge discussion. Share your spicy recipes, rate your favorite hot sauces, and lets turn up the heat together!', 'https://picsum.photos/303/400', '2022-03-10 12:45:00', 8),
		(51, 6, 'Optimizing Code Efficiency', 'Share your best practices for optimizing code efficiency! Whether its algorithmic tricks or performance enhancements, lets master the art of writing faster and more efficient code.', 'https://picsum.photos/304/400', '2022-03-20 09:15:00', 9),
		(52, 6, 'Gadget Recommendations', 'Discover the latest and greatest gadgets! Share your favorite tech devices, accessories, and hidden gems that have revolutionized your daily life.', 'https://picsum.photos/305/400', '2022-04-05 14:30:00', 9),
		(53, 6, 'Cybersecurity Essentials', 'Discuss essential cybersecurity tips and tricks. Share your insights on protecting systems, data, and personal information in an increasingly connected world.', 'https://picsum.photos/306/400', '2022-04-15 11:45:00', 9),
		(54, 5, 'Fantasy Favorites', 'Embark on a journey to magical realms! Share your favorite fantasy books, discuss world-building techniques, and connect with fellow fantasy enthusiasts.', 'https://picsum.photos/307/400', '2022-05-01 10:00:00', 10),
		(55, 5, 'Classic Literature Rediscovered', 'Delve into timeless classics! Recommend must-read literature, explore the profound themes in classic novels, and join the discussion on the enduring impact of these literary masterpieces.', 'https://picsum.photos/308/400', '2022-05-12 13:20:00', 10),
		(56, 5, 'Sci-Fi Saga Discussion', 'Calling all science fiction enthusiasts! Share your favorite sci-fi series, explore futuristic worlds, and discuss the influence of science fiction on literature and beyond.', 'https://picsum.photos/309/400', '2022-05-25 15:45:00', 10),
		(57, 7, 'Epic Boss Battles', 'Share your most memorable boss battles! Discuss strategies, challenges, and the adrenaline-pumping moments that make gaming unforgettable.', 'https://picsum.photos/310/400', '2022-06-08 12:30:00', 11),
		(58, 4, 'Indie Gems Spotlight', 'Explore the world of indie games! Recommend hidden gems, discuss unique gameplay mechanics, and support the thriving indie gaming community.', 'https://picsum.photos/311/400', '2022-06-20 14:15:00', 11),
		(59, 4, 'Multiplayer Madness', 'Dive into the world of multiplayer gaming! Share your favorite multiplayer experiences, discuss team strategies, and connect with fellow gamers for epic online adventures.', 'https://picsum.photos/312/400', '2022-07-02 16:45:00', 11),
		(60, 7, 'Guided Meditation Recommendations', 'Share your favorite guided meditations! Whether its for relaxation, focus, or mindfulness, lets create a collection of soothing meditation recommendations.', 'https://picsum.photos/313/400', '2022-07-15 10:30:00', 12),
		(61, 3, 'Mindful Living Tips', 'Discuss practical tips for incorporating mindfulness into daily life. Share your experiences, challenges, and success stories on the journey to mindful living.', 'https://picsum.photos/314/400', '2022-07-28 12:15:00', 12),
		(62, 3, 'Wellness Retreat Recommendations', 'Explore wellness retreats around the world! Share your recommendations, experiences, and discover rejuvenating destinations for a mindful escape.', 'https://picsum.photos/315/400', '2022-08-05 14:45:00', 12)
	SET IDENTITY_INSERT posts OFF;

SET IDENTITY_INSERT posts OFF;
SET IDENTITY_INSERT posts ON;

-- Tech Enthusiasts Unite (Forum ID: 1)
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES 
  (63, 1, 'Favorite Programming Languages?', 'Let''s discuss our favorite programming languages and why they stand out. Share your experiences and insights!', 'https://i.imgur.com/abc123.jpg', '12/07/2021 12:31:25', 1),
  (64, 3, 'Future of AI in Tech', 'What are your thoughts on the future of AI in the tech industry? Share your predictions and insights!', 'https://i.imgur.com/def456.png', '02/14/2021 04:34:55', 1),
  (65, 6, 'VR Gaming Revolution', 'Explore the exciting world of virtual reality gaming! Share your favorite VR games and experiences.', 'https://i.imgur.com/ghi789.gif', '03/14/2021 15:53:34', 1),
  (66, 2, 'Web Development Trends 2023', 'Discuss the latest trends in web development for the year 2023. What technologies are you excited about?', 'https://i.imgur.com/jkl012.jpg', '07/11/2021 17:23:34', 1),
  (67, 4, 'Cybersecurity Challenges', 'Let''s talk about the current challenges in cybersecurity and how the industry is evolving to address them.', 'https://i.imgur.com/mno345.png', '02/14/2021 02:00:00', 1);

-- Pop Culture Club (Forum ID: 2)
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES 
  (68, 5, 'Marvel vs. DC: Your Preference?', 'Join the debate! Are you a Marvel fan or a DC enthusiast? Share your favorite characters and storylines.', 'https://i.imgur.com/pqr678.jpg', '08/14/2021 15:35:02', 2),
  (69, 2, 'Binge-Worthy TV Shows', 'What TV shows are you currently binge-watching? Recommend your favorites and discover new gems!', 'https://i.imgur.com/stu901.gif', '07/10/2021 05:34:52', 2),
  (70, 5, 'Movie Night Recommendations', 'Looking for movie recommendations? Share your top picks and find cinematic treasures suggested by fellow members.', 'https://i.imgur.com/vwx234.jpg', '12/09/2021 20:43:23', 2),
  (71, 3, 'Video Game Soundtracks', 'Discuss your favorite video game soundtracks and the impact they have on the gaming experience.', 'https://i.imgur.com/xyz567.png', '04/14/2021 21:34:12', 2),
  (72, 1, 'Pop Culture Predictions 2023', 'Make your predictions for the hottest pop culture trends in 2023. What do you think will dominate the entertainment scene?', 'https://i.imgur.com/uvw890.png', '07/14/2021 23:51:34', 2);

-- Creative Minds Hub (Forum ID: 3)
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES 
  (73, 5, 'Digital Art Showcase', 'Share your latest digital art creations and discuss the techniques you used to bring them to life.', 'https://i.imgur.com/abc123.jpg', '12/06/2021 03:31:01', 3),
  (74, 3, 'Writing Prompts Galore', 'Need inspiration for your next writing piece? Explore and share writing prompts to ignite creativity.', 'https://i.imgur.com/def456.jpg', '09/04/2021 02:55:23', 3),
  (75, 4, 'Coding and Art Fusion', 'How do you combine coding and art in your projects? Share your experiences and learn from others in this creative coding community.', 'https://i.imgur.com/ghi789.gif', '07/14/2021 14:53:42', 3),
  (76, 1, 'Artistic Photography Tips', 'Discuss tips and tricks for capturing stunning photographs. Share your favorite photography techniques!', 'https://i.imgur.com/jkl012.jpg', '08/14/2021 19:36:25', 3),
  (77, 2, 'Interactive Art Installations', 'Explore the world of interactive art installations. Share your favorite projects and discuss the impact of technology on art.', 'https://i.imgur.com/mno345.png', '07/04/2021 18:23:46', 3);

-- Fitness Fanatics Forum (Forum ID: 4)
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES 
  (78, 2, 'High-Intensity Workouts', 'Share your favorite high-intensity workouts and tips for staying motivated during challenging exercises.', 'https://i.imgur.com/pqr678.jpg', '10/07/2021 16:45:52', 4),
  (79, 5, 'Nutrition Q&A', 'Have questions about nutrition? Ask the community for advice on healthy eating and dietary choices.', 'https://i.imgur.com/stu901.gif', '11/14/2021 05:26:48', 4),
  (80, 6, 'Running Club Meetup', 'Plan a running club meetup in your area. Connect with fellow runners and share your favorite running routes.', 'https://i.imgur.com/vwx234.jpg', '07/14/2021 23:55:59', 4),
  (81, 2, 'Yoga for Beginners', 'Discuss the benefits of yoga for beginners and share your favorite poses and routines.', 'https://i.imgur.com/xyz567.png', '09/14/2020 17:52:35', 4),
  (82, 1, 'Wellness Retreat Recommendations', 'Recommend wellness retreats and discuss your experiences with rejuvenating getaways.', 'https://i.imgur.com/uvw890.png', '07/04/2021 18:23:46', 4);

-- Travel Tales Exchange (Forum ID: 5)
INSERT INTO posts (post_id, user_id, post_title, post_content, post_imgurl, date_created, forum_id)
VALUES 
  (83, 4, 'Hidden Gems in Southeast Asia', 'Share your favorite hidden gems in Southeast Asia and recommend off-the-beaten-path destinations.', 'https://i.imgur.com/abc123.jpg', '12/06/2021 03:31:01', 5),
  (84, 6, 'Solo Traveler Chronicles', 'Embark on a journey of solo travel experiences. Share your stories, tips, and recommendations for fellow solo adventurers.', 'https://i.imgur.com/def456.jpg', '09/04/2021 02:55:23', 5),
  (85, 3, 'Culinary Adventures Abroad', 'Discuss your most memorable culinary experiences while traveling abroad. Share restaurant recommendations and local delicacies.', 'https://i.imgur.com/ghi789.gif', '07/14/2021 14:53:42', 5),
  (86, 5, 'Road Trip Essentials', 'Compile a list of must-have items for an epic road trip. Share your experiences and recommendations for the open road.', 'https://i.imgur.com/jkl012.jpg', '08/14/2021 19:36:25', 5),
  (87, 2, 'Photography in Paradise', 'Explore the art of travel photography. Share your favorite travel photos and discuss photography tips for capturing the essence of a destination.', 'https://i.imgur.com/mno345.png', '07/04/2021 18:23:46', 5);

SET IDENTITY_INSERT posts OFF;

INSERT INTO post_votes (user_id, target_id, inc)
VALUES 
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(5, 1, 1),
(6, 1, 1),
(7, 1, 1),
(4, 2, -1),
(5, 2, -1),
(6, 2, 1),
(7, 2, 1),
(1, 3, -1),
(2, 3, -1),
(4, 3, 1),
(6, 3, 1),
(7, 3, -1),
(2, 21, -1),
(3, 21, -1),
(4, 21, 1),
(5, 21, -1),
(6, 21, -1),
(7, 21, -1),
(2, 2, 1),
(3, 3, 1),
(4, 4, -1),
(5, 5, 1),
(6, 6, 1),
(1, 7, -1),
(2, 8, 1),
(4, 10, 1),
(6, 12, -1),
(7, 13, 1),
(2, 15, -1),
(3, 16, 1),
(5, 18, 1),
(6, 19, -1),
(7, 20, 1),
(1, 21, 1)


INSERT INTO comment (user_id, post_id, comment_content, date_created, forum_id)
VALUES (3, 1, 'Great post very informative !', CURRENT_TIMESTAMP, 1),
    (3, 6, 'Thanks for sharing this information!', CURRENT_TIMESTAMP, 2),
    (3, 2, 'I have a question about this topic.', CURRENT_TIMESTAMP, 3),
    (4, 4, 'Well researched and nicely presented.', CURRENT_TIMESTAMP, 3),
    (5, 5, 'I appreciate the effort put into this post.', CURRENT_TIMESTAMP, 3),
    (6, 3, 'Great insights, keep it up!', CURRENT_TIMESTAMP, 4),
    (7, 4, 'I found this very helpful for my project.', CURRENT_TIMESTAMP, 4),
    (6, 6, 'Looking forward to more discussions on this topic.', CURRENT_TIMESTAMP, 5),
    (5, 1, 'Awesome content, thank you!', CURRENT_TIMESTAMP, 5),
    (4, 4, 'This post deserves more attention.', CURRENT_TIMESTAMP, 5),
    (3, 6, 'I shared this with my colleagues. Great work!', CURRENT_TIMESTAMP, 6),
	(2, 1, 'Thanks for sharing this information!', CURRENT_TIMESTAMP, 11),
    (3, 3, 'I have a question about this topic.', CURRENT_TIMESTAMP, 10),
    (4, 6, 'Well researched and nicely presented.', CURRENT_TIMESTAMP, 8),
    (5, 4, 'I appreciate the effort put into this post.', CURRENT_TIMESTAMP, 7),
    (6, 3, 'Great insights, keep it up!', CURRENT_TIMESTAMP, 6),
    (7, 3, 'I found this very helpful for my project.', CURRENT_TIMESTAMP, 9),
    (7, 2, 'Looking forward to more discussions on this topic.', CURRENT_TIMESTAMP, 11),
    (6, 4, 'Awesome content, thank you!', CURRENT_TIMESTAMP, 5),
    (5, 2, 'This post deserves more attention.', CURRENT_TIMESTAMP, 6),
    (4, 1, 'I shared this with my colleagues. Great work!', CURRENT_TIMESTAMP, 2);


-- Inserting