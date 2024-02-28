/*

call books.sp_create_book_genres_lookup (
       @err,
       1,
       1,
       5,
       @aid);
*/

DROP PROCEDURE IF EXISTS books.sp_create_book_genres_lookup;

DELIMITER $$
CREATE PROCEDURE books.sp_create_book_genres_lookup(OUT error_code INT
				              ,IN in_app_user_id INT
                                          ,IN in_book_id BIGINT 
                                          ,IN in_genres_lookup_id BIGINT 
                                          ,OUT out_book_genres_lookup_id INT
                                          )
BEGIN

SET error_code=-2;

INSERT INTO books.book_genres_lookup
(
    book_genres_lookup_id,
    book_id,
    genres_lookup_id,
    status,
    created_id,
    created_dtm,
    modified_id,
    modified_dtm
) 
VALUES
       (NULL,
       in_book_id,
       in_genres_lookup_id,
        1,
        in_app_user_id,
        CURRENT_TIMESTAMP,
        in_app_user_id,
        CURRENT_TIMESTAMP
       );
       
SET out_book_genres_lookup_id=LAST_INSERT_ID();

SET error_code=0;
 
END$$
DELIMITER ;


