/* 
call books.sp_get_book (
       @err,
       NULL,
       1,
       NULL,
       NULL,
       NULL,
       NULL);
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_book$$

CREATE  PROCEDURE books.sp_get_book(OUT error_code INT
                                          ,IN in_book_id bigint(20) 
                                          ,IN in_gr_book_id bigint(20) 
                                          ,IN in_book_title text 
                                          ,IN in_book_isbn text 
                                          ,IN in_book_isbn13 text 
                                          ,IN in_book_publisher varchar(500)
                                   )
BEGIN
SET error_code = -2;
SET @q = CONCAT('

select      book_id,
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
            book_link,
            status,
            created_id,
            created_dtm,
            modified_id,
            modified_dtm
        
  FROM 
        books.book
     
 WHERE  1 = 1  ');
 
 IF in_book_id IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND book_id = ',in_book_id);
 END IF;

 IF in_gr_book_id IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND gr_book_id = ',in_gr_book_id);
 END IF;
 
 IF in_book_title IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND UPPER (book_title) = ', "'",UPPER(in_book_title),"'"); 
 END IF;

 IF in_book_isbn IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND UPPER (book_isbn) = ', "'",UPPER(in_book_isbn),"'"); 
 END IF;

 IF in_book_isbn13 IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND UPPER (book_isbn13) = ', "'",UPPER(in_book_isbn13),"'"); 
 END IF;

 IF in_book_publisher IS NOT NULL THEN
 SET @q = CONCAT(@q,' AND UPPER (book_publisher) = ', "'",UPPER(in_book_publisher),"'"); 
 END IF;
 
 SET @q = CONCAT(@q,' AND status = 1');
 -- SELECT @q;
 PREPARE stmt FROM @q;
 EXECUTE stmt;
 DEALLOCATE PREPARE stmt;
 
SET error_code = 0;
END$$

DELIMITER ;


