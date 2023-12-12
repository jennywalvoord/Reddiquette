DELETE FROM comment_votes
WHERE comment_id = @commentId;

DELETE FROM comment
WHERE parent_id = @commentId;

DELETE FROM comment
WHERE comment_id =@commentId;