/* 
call books.sp_get_titles_by_index (@err, "5,2,3,1,4");
 */

DELIMITER $$

DROP PROCEDURE IF EXISTS books.sp_get_titles_by_index$$

CREATE  PROCEDURE books.sp_get_titles_by_index(OUT error_code INT
                                          ,IN in_book_id_list TEXT
                                          )
                                          
BEGIN
SET error_code = -2;
SET @q = CONCAT('

SELECT DISTINCT
        book_title_mod

        
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