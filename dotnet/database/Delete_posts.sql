DELETE FROM post_votes
WHERE post_id = @postId;

DELETE FROM comment_votes
WHERE comment_id IN (
	SELECT comment_id
	FROM comment
	WHERE post_id = @postId); 

DELETE FROM comment
WHERE post_id = @postId;

DELETE FROM posts
WHERE post_id = @postId;