/*

call books.sp_create_book (
       @err,
       1,
       1,
       "book_title",
       "book_title_mod",
       "book_title_series",
       "book_title_series_mod",
       "book_description",
       100,
       4.5,
       500,
       1,
       1,
       2023,
       "9999999999",
       "9999999999000",
       "book_publisher",
       "book_country_code",
       "book_language_code",
       "book_url",
       "book_image_url",
       "book_link",
       @aid);
*/

DROP PROCEDURE IF EXISTS books.sp_create_book;

DELIMITER $$
CREATE PROCEDURE books.sp_create_book(OUT error_code INT
				              ,IN in_app_user_id INT
                                          ,IN in_gr_book_id bigint(20) 
                                          ,IN in_book_title text 
                                          ,IN in_book_title_mod text 
                                          ,IN in_book_title_series text 
                                          ,IN in_book_title_series_mod text 
                                          ,IN in_book_description text 
                                          ,IN in_book_ratings_count int(11) 
                                          ,IN in_book_average_rating float 
                                          ,IN in_book_num_pages int(11) 
                                          ,IN in_book_publication_day tinyint(4) 
                                          ,IN in_book_publication_month tinyint(4) 
                                          ,IN in_book_publication_year int(11) 
                                          ,IN in_book_isbn text 
                                          ,IN in_book_isbn13 text 
                                          ,IN in_book_publisher varchar(500) 
                                          ,IN in_book_country_code varchar(100) 
                                          ,IN in_book_language_code varchar(100) 
                                          ,IN in_book_url text 
                                          ,IN in_book_image_url text 
                                          ,IN in_book_link text
                                          ,OUT out_book_id INT
                                          )
BEGIN

SET error_code=-2;

INSERT INTO books.book
(
    book_id,
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
) 
VALUES
       (NULL,
       in_gr_book_id,
       in_book_title,
       in_book_title_mod,
       in_book_title_series,
       in_book_title_series_mod,
       in_book_description,
       in_book_ratings_count,
       in_book_average_rating,
       in_book_num_pages,
       in_book_publication_day,
       in_book_publication_month,
       in_book_publication_year,
       in_book_isbn,
       in_book_isbn13,
       in_book_publisher,
       in_book_country_code,
       in_book_language_code,
       in_book_url,
       in_book_image_url,
       in_book_link,
        1,
        in_app_user_id,
        CURRENT_TIMESTAMP,
        in_app_user_id,
        CURRENT_TIMESTAMP
       );
       
SET out_book_id=LAST_INSERT_ID();

SET error_code=0;
 
END$$
DELIMITER ;


