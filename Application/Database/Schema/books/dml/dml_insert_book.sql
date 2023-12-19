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
(
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
    1, 
    1, 
    CURRENT_TIMESTAMP, 
    1,
    CURRENT_TIMESTAMP
);



