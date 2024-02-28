CREATE TEMPORARY TABLE temp_names AS
SELECT DISTINCT
        book_title_mod       
  FROM 
        books.book
 WHERE  book_id IN (452654,  451559, 1822593, 1157047, 1164957,     153, 1224028,  355924, 1429187,
  523427,  747750,  735452, 1299431,  805653, 1181761, 1075088, 1435848, 1799084,
 1436660, 1796973,  188149, 1192562, 1310206, 1903841,  265872, 1951169, 1780169,
 1681739,  827442, 1486288)
 AND status = 1
 ORDER BY FIELD(book_id, 452654,  451559, 1822593, 1157047, 1164957,     153, 1224028,  355924, 1429187,
  523427,  747750,  735452, 1299431,  805653, 1181761, 1075088, 1435848, 1799084,
 1436660, 1796973,  188149, 1192562, 1310206, 1903841,  265872, 1951169, 1780169,
 1681739,  827442, 1486288);
 
 CREATE TEMPORARY TABLE temp_details AS
	SELECT
			book_title,
            book_title_mod,
            book_ratings_count,
            book_average_rating,
            book_image_url
    
    FROM 
        books.book
 WHERE  book_id IN (452654,  451559, 1822593, 1157047, 1164957,     153, 1224028,  355924, 1429187,
  523427,  747750,  735452, 1299431,  805653, 1181761, 1075088, 1435848, 1799084,
 1436660, 1796973,  188149, 1192562, 1310206, 1903841,  265872, 1951169, 1780169,
 1681739,  827442, 1486288)
 AND status = 1
 ORDER BY FIELD(book_id, 452654,  451559, 1822593, 1157047, 1164957,     153, 1224028,  355924, 1429187,
  523427,  747750,  735452, 1299431,  805653, 1181761, 1075088, 1435848, 1799084,
 1436660, 1796973,  188149, 1192562, 1310206, 1903841,  265872, 1951169, 1780169,
 1681739,  827442, 1486288);

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
)SELECT *
FROM
  ranked_details
WHERE
  row_num = 1;

SELECT t1.*
FROM temp_ranked_details t1
JOIN temp_names t2 ON t1.book_title_mod = t2.book_title_mod
ORDER BY FIELD(t1.book_title_mod, t2.book_title_mod);

DROP TEMPORARY TABLE IF EXISTS temp_names;
DROP TEMPORARY TABLE IF EXISTS temp_details;
DROP TEMPORARY TABLE IF EXISTS temp_ranked_details;