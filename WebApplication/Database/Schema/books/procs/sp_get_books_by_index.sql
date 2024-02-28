/* 
call books.sp_get_books_by_index (@err, "5,2,3,1,4");
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_books_by_index$$

CREATE  PROCEDURE books.sp_get_books_by_index(OUT error_code INT
                                          ,IN in_book_id_list TEXT
                                          )
                                          
BEGIN
SET error_code = -2;
SET @q = CONCAT('

SELECT      book_id,
            gr_book_id,
            book_title,
            book_title_mod,
            book_title_series,
            book_title_series_mod,
            book_description,
            book_ratings_count,
            book_average_rating,
            book_num_pages,
            book_publication_day,
            book_publication_month,
            book_publication_year,
            book_isbn,
            book_isbn13,
            book_publisher,
            book_country_code,
            book_language_code,
            book_url,
            book_image_url,
            book_link
        
  FROM 
        books.book
     
 WHERE  book_id IN (', in_book_id_list, ')
 AND status = 1
 ORDER BY FIELD(book_id, ', in_book_id_list, ')
 ');
 
 SET @q = CONCAT(@q);

 PREPARE stmt FROM @q;
 EXECUTE stmt;
 DEALLOCATE PREPARE stmt;
 
SET error_code = 0;
END$$

DELIMITER ;