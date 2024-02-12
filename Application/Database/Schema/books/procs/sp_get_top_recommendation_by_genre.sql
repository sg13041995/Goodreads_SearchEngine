/*
call books.sp_get_top_recommendation_by_genre (@err);
*/

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_top_recommendation_by_genre$$

CREATE PROCEDURE books.sp_get_top_recommendation_by_genre(OUT error_code INT)
BEGIN
    -- Initialize error code
    SET error_code = -2;

CREATE TEMPORARY TABLE sort_by_rating_count AS
    SELECT 
        b.book_id, 
        b.gr_book_id, 
        b.book_title, 
        b.book_ratings_count, 
        b.book_average_rating, 
        bg.genres_lookup_id
    FROM 
        book b
    LEFT JOIN 
        book_genres_lookup bg ON b.book_id = bg.book_id
    ORDER BY 
        book_ratings_count DESC
    LIMIT 1500;

SELECT *
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY genres_lookup_id ORDER BY book_average_rating DESC) AS row_num
    FROM 
        sort_by_rating_count
) AS ranked_items
WHERE 
    row_num <= 10;

DROP TEMPORARY TABLE IF EXISTS sort_by_rating_count;

    -- Set error code to 0 (success)
    SET error_code = 0;
END$$

DELIMITER ;
