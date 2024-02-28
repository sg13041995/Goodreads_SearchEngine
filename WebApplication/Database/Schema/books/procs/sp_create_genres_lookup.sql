/*

call books.sp_create_genres_lookup (
       @err,
       1,
       "genres lookup name",
       "genres lookup desc",
       @aid);
*/

DROP PROCEDURE IF EXISTS books.sp_create_genres_lookup;

DELIMITER $$
CREATE PROCEDURE books.sp_create_genres_lookup(OUT error_code INT
				              ,IN in_app_user_id INT
                                          ,IN in_genres_lookup_name VARCHAR(500) 
                                          ,IN in_genres_lookup_desc TEXT
                                          ,OUT out_genres_lookup_id INT
                                          )
BEGIN

SET error_code=-2;

INSERT INTO books.genres_lookup
(
    genres_lookup_id,
    genres_lookup_name,
    genres_lookup_desc,
    status,
    created_id,
    created_dtm,
    modified_id,
    modified_dtm
) 
VALUES
       (NULL,
       in_genres_lookup_name,
       in_genres_lookup_desc,
        1,
        in_app_user_id,
        CURRENT_TIMESTAMP,
        in_app_user_id,
        CURRENT_TIMESTAMP
       );
       
SET out_genres_lookup_id=LAST_INSERT_ID();

SET error_code=0;
 
END$$
DELIMITER ;


