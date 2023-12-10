DELETE FROM comment_votes 
WHERE comment_id IN (
	SELECT comment_id 
	FROM comment
	WHERE post_id IN (
		SELECT post_id
		FROM posts
		WHERE forum_id = @forum_id));

DELETE FROM comment
WHERE post_id IN (
	SELECT post_id
	FROM posts
	WHERE forum_id = @forum_id);

DELETE FROM post_votes 
WHERE post_id IN (
	SELECT post_id 
	FROM posts
	WHERE post_id IN (
		SELECT post_id
		FROM posts
		WHERE forum_id = @forum_id));

DELETE FROM posts
WHERE forum_id = @forum_id;

DELETE FROM user_forum
WHERE forum_id = @forum_id;

DELETE FROM forum
WHERE forum_id = @forum_id;