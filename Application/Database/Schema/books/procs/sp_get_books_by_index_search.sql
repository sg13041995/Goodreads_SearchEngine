/* 
call books.sp_get_books_by_index_search (@err, "452654,  451559, 1822593, 1157047, 1164957,     153, 1224028,  355924, 1429187, 523427,  747750,  735452, 1299431,  805653, 1181761, 1075088, 1435848, 1799084, 1436660, 1796973,  188149, 1192562, 1310206, 1903841,  265872, 1951169, 1780169,
 1681739, 827442, 1486288");
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_books_by_index_search$$

CREATE PROCEDURE books.sp_get_books_by_index_search(
    OUT error_code INT,
    IN in_book_id_list TEXT
)
BEGIN
    SET error_code = -2;

    -- Create temp_names table
    SET @q_names = CONCAT('
        CREATE TEMPORARY TABLE temp_names AS
        SELECT DISTINCT
            book_title_mod       
        FROM 
            books.book
        WHERE  book_id IN (', in_book_id_list, ')
            AND status = 1
        ORDER BY FIELD(book_id, ', in_book_id_list, ')
    ');

    PREPARE stmt_names FROM @q_names;
    EXECUTE stmt_names;
    DEALLOCATE PREPARE stmt_names;

    -- Create temp_details table
    SET @q_details = CONCAT('
        CREATE TEMPORARY TABLE temp_details AS
        SELECT
            book_title,
            book_title_mod,
            book_ratings_count,
            book_average_rating,
            book_image_url
        FROM 
            books.book
        WHERE  book_id IN (', in_book_id_list, ')
            AND status = 1
        ORDER BY FIELD(book_id, ', in_book_id_list, ')
    ');

    PREPARE stmt_details FROM @q_details;
    EXECUTE stmt_details;
    DEALLOCATE PREPARE stmt_details;

    -- Create temp_ranked_details table
    SET @q_ranked_details = '
        CREATE TEMPORARY TABLE temp_ranked_details AS
        WITH ranked_details AS (
            SELECT      
                book_title,
                book_title_mod,
                book_ratings_count,
                book_average_rating,
                book_image_url,
                ROW_NUMBER() OVER (PARTITION BY book_title_mod ORDER BY book_ratings_count DESC) AS row_num
            FROM
                temp_details
        ) SELECT * FROM ranked_details WHERE row_num = 1
    ';

    PREPARE stmt_ranked_details FROM @q_ranked_details;
    EXECUTE stmt_ranked_details;
    DEALLOCATE PREPARE stmt_ranked_details;

    -- Select and join results
    SET @q_final = '
        SELECT t1.*
        FROM temp_ranked_details t1
        JOIN temp_names t2 ON t1.book_title_mod = t2.book_title_mod
        ORDER BY FIELD(t1.book_title_mod, t2.book_title_mod)
    ';

    PREPARE stmt_final FROM @q_final;
    EXECUTE stmt_final;
    DEALLOCATE PREPARE stmt_final;

    -- Drop temporary tables
    DROP TEMPORARY TABLE IF EXISTS temp_names;
    DROP TEMPORARY TABLE IF EXISTS temp_details;
    DROP TEMPORARY TABLE IF EXISTS temp_ranked_details;

    SET error_code = 0;
END$$

DELIMITER ;

