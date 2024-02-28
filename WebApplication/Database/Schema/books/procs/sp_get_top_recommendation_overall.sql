/*
call books.sp_get_top_recommendation_overall (@err);
*/

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_top_recommendation_overall$$

CREATE PROCEDURE books.sp_get_top_recommendation_overall(OUT error_code INT)
BEGIN
    -- Initialize error code
    SET error_code = -2;

    -- Create temporary table
    CREATE TEMPORARY TABLE sort_by_rating_count AS
        SELECT book_id, gr_book_id, book_title, book_ratings_count, book_average_rating
        FROM book
        ORDER BY book_ratings_count DESC
        LIMIT 100;

    -- Select top 20 from the temporary table
    SELECT *
    FROM sort_by_rating_count
    ORDER BY book_average_rating DESC
    LIMIT 20;

    -- Drop temporary table
    DROP TEMPORARY TABLE IF EXISTS sort_by_rating_count;

    -- Set error code to 0 (success)
    SET error_code = 0;
END$$

DELIMITER ;
