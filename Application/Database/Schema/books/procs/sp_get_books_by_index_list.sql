/* 
call books.sp_get_books_by_index_list (@err, "5,2,3,1,4");
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_books_by_index_list$$

CREATE PROCEDURE books.sp_get_books_by_index_list(
    OUT error_code INT,
    IN in_book_id_list TEXT
)
BEGIN
    SET error_code = -2;

    SET @q = CONCAT('
        CREATE TEMPORARY TABLE temp_subset AS
            SELECT      
                book_title,
                book_title_mod,
                book_ratings_count,
                book_average_rating,
                book_image_url
            FROM 
                books.book
            WHERE  
                book_id IN (', in_book_id_list, ')
                AND status = 1
            ORDER BY FIELD(book_id, ', in_book_id_list, ')
    ');

    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET @q = 'WITH RankedResults AS (
        SELECT      
            book_title,
            book_title_mod,
            book_ratings_count,
            book_average_rating,
            book_image_url,
            ROW_NUMBER() OVER (PARTITION BY book_title_mod ORDER BY book_ratings_count DESC) AS row_num
        FROM
            temp_subset
    ) SELECT * FROM RankedResults WHERE row_num = 1';

    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    DROP TEMPORARY TABLE IF EXISTS temp_subset;

    SET error_code = 0;
END$$

DELIMITER ;
