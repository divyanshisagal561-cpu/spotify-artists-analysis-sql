/*
=============================================================================
SPOTIFY ARTISTS ANALYSIS USING SQL

Author      : Divyanshi Sagal
Database    : MySQL
Dataset     : Spotify artists analysis 1949 - 2021
Project Type: SQL Portfolio Project

=============================================================================
*/
-- ==========================================================================
-- Part 1 : Database Creation (DDL)
-- ==========================================================================
-- 1.1 : Create a database named spotify_db. 
CREATE DATABASE IF NOT EXISTS spotify_db ;
-- 1.2 : Use created database.
USE spotify_db ; 
-- 1.3 : Create a table named spotify_artists with appropriate data types for all 14 columns. 
CREATE TABLE spotify_artists
(artist_name VARCHAR(100),
sex CHAR(10),
country_of_origin VARCHAR(50),
primary_language VARCHAR(50),
primary_genre VARCHAR(50),
artist_type VARCHAR(50),
debut_year INT,
total_streams_millions DECIMAL(15, 2),
lead_streams_millions DECIMAL(15, 2),
feature_streams_millions DECIMAL(15, 2),
solo_streams_millions DECIMAL(15, 2),
solo_stream_percentage DECIMAL(5, 2),
collaborative_streams_millions DECIMAL(15, 2),
collaborative_stream_percentage DECIMAL(5, 2)) ;
-- 1.4 : Display the structure of the spotify_artists table using DESCRIBE.
DESCRIBE spotify_artists ;
-- 1.5 : Add appropriate NOT NULL constraints to columns where missing values should not be allowed.
ALTER TABLE spotify_artists
MODIFY artist_name VARCHAR(50) NOT NULL;
-- ==========================================================================
-- Part 2 : Data Import
-- ==========================================================================
-- 2.1 : Verify the total number of records imported.
SELECT 
      COUNT(*) AS total_records
FROM spotify_artists ;
-- 2.2 : Display the first 10 records from the table.
SELECT *
FROM spotify_artists
LIMIT 10 ;
-- 2.3 : Check whether any duplicate artist_name values were imported.
SELECT 
	  artist_name,
      COUNT(*) AS total_records
FROM spotify_artists
GROUP BY artist_name
HAVING total_records > 1 ;
-- ==========================================================================
-- Part 3 : Data Cleaning
-- ==========================================================================
-- 3.1 : Check for NULL values in every column.
SELECT 
      artist_name IS NULL AS artist_name,
      sex  IS NULL AS sex,
      country_of_origin  IS NULL AS country_of_origin,
      primary_language  IS NULL AS primary_language,
      primary_genre  IS NULL AS primary_genre,
      artist_type IS NULL AS artist_type,
      debut_year IS NULL AS debut_year,
      total_streams_millions IS NULL AS total_streams_millions,
      lead_streams_millions IS NULL AS lead_streams_millions,
      feature_streams_millions  IS NULL AS feature_streams_millions,
      solo_streams_millions IS NULL AS solo_streams_millions,
      solo_stream_percentage IS NULL AS solo_stream_percentage,
      collaborative_streams_millions IS NULL AS collaborative_streams_millions,
      collaborative_stream_percentage IS NULL AS collaborative_stream_percentage
FROM spotify_artists ;
-- 3.2 : Find artists whose country_of_origin is NULL or empty. 
SELECT *
FROM spotify_artists 
WHERE country_of_origin IS NULL
      OR TRIM(country_of_origin) = "";
-- 3.3 : Find artists whose primary_genre is NULL or empty. 
SELECT *
FROM spotify_artists 
WHERE primary_genre IS NULL
      OR TRIM(primary_genre) = "";
-- 3.4 : Check whether any artist names contain leading or trailing spaces.
SELECT 
      artist_name 
FROM spotify_artists
WHERE artist_name <> TRIM(artist_name) ;
-- 3.5 : Find artists with an invalid or unrealistic debut_year.
SELECT 
      artist_name,
      debut_year 
FROM spotify_artists
WHERE 
      debut_year < 1900 OR
      debut_year > 2026 OR 
      debut_year IS NULL ;
-- 3.6 : Check whether total_streams_millions contains zero or negative values.
SELECT 
      total_streams_millions 
FROM spotify_artists
WHERE 
     total_streams_millions <= 0 ;
-- 3.7 : Check whether any percentage values are below 0 or above 100.
SELECT 
      collaborative_stream_percentage
FROM spotify_artists
WHERE 
     collaborative_stream_percentage < 0 OR
     collaborative_stream_percentage > 100 ;
-- 3.8 :  Verify whether solo_streams_millions + collaborative_streams_millions equals total_streams_millions.
SELECT 
      artist_name,
      solo_streams_millions,
      collaborative_streams_millions,
      total_streams_millions,
      ROUND((solo_streams_millions + collaborative_streams_millions),2) AS calculated_streams,
CASE
    WHEN total_streams_millions = ROUND((solo_streams_millions + collaborative_streams_millions),2) THEN "MATCH"
    ELSE "MISMATCH"
END validation_status    
FROM spotify_artists ;
-- 3.9 :  Find artists where lead_streams_millions + feature_streams_millions does not equal total_streams_millions.
SELECT  
      artist_name,
      lead_streams_millions,
      feature_streams_millions,
      total_streams_millions,
      ROUND((lead_streams_millions + feature_streams_millions),2) AS calculated_streams
FROM spotify_artists 
WHERE 
	 total_streams_millions <>
	 ROUND((lead_streams_millions + feature_streams_millions),2);
-- ==========================================================================
-- Part 4 : Exploratory Data Analysis
-- ==========================================================================
-- 4.1 : Find the total number of artists in the dataset.
SELECT 
      COUNT(DISTINCT artist_name) AS total_artists
FROM spotify_artists ;
-- 4.2 : Find the total number of countries represented.
SELECT 
      COUNT(DISTINCT country_of_origin) AS total_countries
FROM spotify_artists ;
-- 4.3 : Find the total number of primary genres.
SELECT 
      COUNT(DISTINCT primary_genre) AS total_genres
FROM spotify_artists ;
-- 4.4 : Find the earliest debut year.
SELECT 
	  MIN(debut_year) AS earliest_debut_year
FROM spotify_artists ;
-- 4.5 : Find the latest debut year.
SELECT 
      MAX(debut_year) AS latest_debut_year
FROM spotify_artists ;
-- 4.6 : Calculate the average debut year of all artists.
SELECT 
      ROUND(AVG(debut_year), 2) AS avg_debut_year
FROM spotify_artists ;
-- 4.7 : Calculate the average total streams across all artists.
SELECT 
      ROUND(AVG(total_streams_millions), 2) AS total_streams
FROM spotify_artists ;
-- 4.8 : Find the minimum and maximum total streams.
SELECT 
      MIN(total_streams_millions) AS min_streams,
	  MAX(total_streams_millions) AS max_streams
FROM spotify_artists ; 
-- 4.9 : Calculate the average solo-stream percentage.
SELECT 
      AVG(solo_stream_percentage) AS avg_solo_stream_percentage
FROM spotify_artists ;
-- 4.10 : Calculate the average collaborative-stream percentage.
SELECT 
      AVG(collaborative_stream_percentage) AS avg_collaborative_stream_percentage
FROM spotify_artists ;
-- ==========================================================================
-- Part 5 : Basic SQL
-- ==========================================================================
-- 5.1 : Display all artists from the dataset.
SELECT *
FROM spotify_artists ;
-- 5.2: Display only artist_name, country_of_origin, and primary_genre.
SELECT 
      artist_name,
      country_of_origin,
      primary_genre
FROM spotify_artists ;
-- 5.3 : Find all artists from the United States.
SELECT *
FROM spotify_artists 
WHERE country_of_origin = "United States" ;
-- 5.4 : Find all artists whose primary genre is Pop.
SELECT *
FROM spotify_artists 
WHERE primary_genre = "Pop" ;
-- 5.5 : Find artists who debuted after 2010.
SELECT *
FROM spotify_artists 
WHERE debut_year > 2010 ;
-- 5.6 : Find artists with more than 1,000 million total streams.
SELECT *
FROM spotify_artists 
WHERE total_streams_millions > 1000 ;
-- 5.7 : Find artists with less than 500 million total streams.
SELECT *
FROM spotify_artists 
WHERE total_streams_millions < 500 ;
-- 5.8 : Find artists whose solo-stream percentage is greater than 80%.
SELECT *
FROM spotify_artists 
WHERE solo_stream_percentage > 80 ;
-- 5.9 : Find artists whose collaborative-stream percentage is greater than 20%.
SELECT *
FROM spotify_artists 
WHERE collaborative_stream_percentage > 20 ;
-- 5.10 : Sort artists by total streams in descending order.
SELECT *
FROM spotify_artists 
ORDER BY total_streams_millions DESC ;
-- 5.11 : Display the 10 most-streamed artists.
SELECT 
	  artist_name,
      total_streams_millions
FROM spotify_artists
ORDER BY total_streams_millions DESC
LIMIT 10 ;
-- 5.12 : Display the 10 least-streamed artists.
SELECT 
      artist_name,
      total_streams_millions
FROM spotify_artists
ORDER BY total_streams_millions ASC
LIMIT 10 ; 
-- 5.13 : Find artists who debuted between 2000 and 2010.
SELECT 
      artist_name,
      debut_year
FROM spotify_artists
WHERE debut_year BETWEEN 2000 AND 2010 ;
-- 5.14 : Find artists whose names start with the letter A.
SELECT 
      artist_name 
FROM spotify_artists
WHERE artist_name LIKE "A%" ;
-- 5.15 : Find artists whose primary genre contains the word Rock.
SELECT 
      artist_name,
      primary_genre
FROM spotify_artists
WHERE primary_genre LIKE "%Rock%" ;
-- ==========================================================================
-- Part 6 : Intermediate SQL
-- ==========================================================================
-- 6.1 : Count the number of artists in each country.
SELECT 
	  country_of_origin, 
      COUNT(*) AS total_artists
FROM spotify_artists
GROUP BY country_of_origin 
ORDER BY total_artists DESC ;
-- 6.2 : Find the top 10 countries with the most artists.
SELECT  
      country_of_origin,
      COUNT(DISTINCT artist_name)AS total_artists
FROM spotify_artists
GROUP BY country_of_origin
ORDER BY total_artists DESC 
LIMIT 10 ;
-- 6.3 : Count the number of artists in each primary genre.
SELECT 
      primary_genre,
      COUNT(*) AS total_artists
FROM spotify_artists
GROUP BY primary_genre 
ORDER BY total_artists DESC ;
-- 6.4 : Find the average total streams for each genre.
SELECT  
      primary_genre,
      AVG(total_streams_millions) AS avg_total_streams
FROM spotify_artists
GROUP BY primary_genre 
ORDER BY avg_total_streams DESC ;
-- 6.5 : Find the maximum total streams for each country.
SELECT 
	  country_of_origin,
      MAX(total_streams_millions) AS max_total_streams
FROM spotify_artists
GROUP BY country_of_origin
ORDER BY max_total_streams DESC ;
-- 6.6 : Find the minimum total streams for each genre. 
SELECT 
	  primary_genre,
      MIN(total_streams_millions) AS min_total_streams
FROM spotify_artists
GROUP BY primary_genre
ORDER BY min_total_streams DESC ;
-- 6.7 : Calculate total streams generated by each country.
SELECT 
      country_of_origin,
      SUM(total_streams_millions) AS total_streams
FROM spotify_artists
GROUP BY country_of_origin
ORDER BY total_streams DESC ;
-- 6.8 : Calculate total streams generated by each genre.
SELECT 
      primary_genre,
      SUM(total_streams_millions) AS total_streams
FROM spotify_artists
GROUP BY primary_genre
ORDER BY total_streams DESC ;
-- 6.9 : Find genres having more than 20 artists.
SELECT 
      primary_genre,
      COUNT(*) AS total_artists
FROM spotify_artists
GROUP BY primary_genre
HAVING total_artists > 20 
ORDER BY total_artists DESC ;
-- 6.10 : Find countries having more than 10 artists.
SELECT 
      country_of_origin,
      COUNT(*) AS total_artists
FROM spotify_artists
GROUP BY country_of_origin
HAVING total_artists > 10 
ORDER BY total_artists DESC ;
-- 6.11 : Find genres whose average total streams are greater than the overall average.
SELECT 
     primary_genre,
     ROUND(AVG(total_streams_millions), 2) AS avg_genres
FROM spotify_artists
GROUP BY primary_genre
HAVING AVG(total_streams_millions) > (SELECT 
                                           AVG(total_streams_millions)
									  FROM spotify_artists) 
ORDER BY avg_genres DESC ;                                  
-- 6.12 : Find artists whose total streams are greater than the overall average. 
SELECT 
      artist_name,
      total_streams_millions
FROM spotify_artists
WHERE total_streams_millions > (SELECT 
									   AVG(total_streams_millions)
								 FROM spotify_artists) 
ORDER BY total_streams_millions DESC ;                                
-- 6.13 : Find artists who have above-average solo streams. 
SELECT 
	  artist_name,
      solo_streams_millions
FROM spotify_artists
WHERE solo_streams_millions > (SELECT 
									 AVG(solo_streams_millions)
								 FROM spotify_artists) 
ORDER BY solo_streams_millions DESC ;      
-- 6.14 : Find the average total streams by artist type.
SELECT 
      artist_type,
      AVG(total_streams_millions) AS avg_total_streams
FROM spotify_artists
GROUP BY artist_type
ORDER BY avg_total_streams DESC ;
-- 6.15 : Find the average total streams by debut year. 
SELECT 
      debut_year,
      AVG(total_streams_millions) AS avg_total_streams
FROM spotify_artists
GROUP BY debut_year
ORDER BY avg_total_streams DESC ;
-- ==========================================================================
-- Part 7 : Advanced SQL
-- ==========================================================================
-- 7.1 : Find the artist with the highest total streams using a subquery.
SELECT 
      artist_name,
      total_streams_millions
FROM spotify_artists
WHERE total_streams_millions = (SELECT 
                                      MAX(total_streams_millions)
                                FROM spotify_artists) ;
-- 7.2 : Find the second-highest-streamed artist.
SELECT 
	  artist_name,
      total_streams_millions
FROM spotify_artists
WHERE total_streams_millions = (SELECT 
                                      MAX(total_streams_millions)
                                FROM spotify_artists
                                WHERE total_streams_millions < (SELECT 
                                                                      MAX(total_streams_millions)
														FROM spotify_artists)) ;
-- ** Using CTE and Window function :-                                                       
WITH second_highest_streamed_artist AS 
		  (SELECT 
                 ROW_NUMBER() OVER(ORDER BY total_streams_millions DESC) AS rn,
                 artist_name,
                 total_streams_millions
           FROM spotify_artists)
       
SELECT *
FROM second_highest_streamed_artist       
WHERE rn = 2 ;									
-- 7.3 : Find the third-highest-streamed artist.
SELECT 
     artist_name,
     total_streams_millions
FROM spotify_artists     
WHERE total_streams_millions = (SELECT 
                                      MAX(total_streams_millions)
								FROM spotify_artists 
                                WHERE total_streams_millions < (SELECT 
                                                                      MAX(total_streams_millions)
                                                                 FROM spotify_artists
                                                                 WHERE total_streams_millions < (SELECT 
                                                                                                       MAX(total_streams_millions)
                                                                                                  FROM spotify_artists)));
-- ** Using CTE and Window function :-                                                       
WITH third_highest_streamed_artist AS 
	 (SELECT 
            ROW_NUMBER() OVER(ORDER BY total_streams_millions DESC) AS rn,
			artist_name,
			total_streams_millions
     FROM spotify_artists)
     
SELECT *
FROM third_highest_streamed_artist
WHERE rn = 3 ;  
-- 7.4 : Find artists whose total streams are greater than the average streams of their genre.
SELECT 
     artist_name,
     primary_genre,
     total_streams_millions
FROM spotify_artists AS s1
WHERE total_streams_millions > (SELECT 
                                      AVG(total_streams_millions)
								FROM spotify_artists AS s2
                                WHERE s2.primary_genre = s1.primary_genre)
ORDER BY total_streams_millions DESC ;                             
-- 7.5 : Find the country with the highest average artist streams.
SELECT 
     country_of_origin,
     ROUND(AVG(total_streams_millions), 2) AS avg_artist_streams
FROM spotify_artists 
GROUP BY country_of_origin
ORDER BY avg_artist_streams DESC
LIMIT 1 ;
-- 7.6 : Find the genre with the highest total streams. 
SELECT 
      primary_genre,
      SUM(total_streams_millions) AS total_streams
FROM spotify_artists 
GROUP BY primary_genre 
ORDER BY total_streams DESC
LIMIT 1 ;
-- 7.7 : Find artists who have higher solo streams than collaborative streams.
SELECT 
      artist_name,
      solo_streams_millions,
      collaborative_streams_millions
FROM spotify_artists 
WHERE solo_streams_millions > collaborative_streams_millions
ORDER BY solo_streams_millions DESC ;
-- 7.8 : Find artists whose solo-stream percentage is greater than the average solo-stream percentage.
SELECT 
      artist_name,
      solo_stream_percentage
FROM spotify_artists 
WHERE solo_stream_percentage > (SELECT 
                                      AVG(solo_stream_percentage)
						 		FROM spotify_artists) ;
-- 7.9 : Find the country that has the highest number of artists and calculate its total streams.
SELECT 
      country_of_origin,
      COUNT(*) AS total_artists,
      SUM(total_streams_millions) AS total_streams
FROM spotify_artists 
GROUP BY country_of_origin 
ORDER BY total_artists DESC
LIMIT 1 ;
-- 7.10 : Using a CTE, calculate the total streams and percentage contribution of each genre to overall streams. 
WITH genre_streams AS (
     SELECT  
           primary_genre,
           SUM(total_streams_millions) AS genre_total_streams
     FROM spotify_artists 
	 GROUP BY primary_genre)
    
SELECT   
	 primary_genre,
	 genre_total_streams,
	 ROUND(genre_total_streams * 100 / (SELECT SUM(total_streams_millions) FROM spotify_artists), 2) AS percentage_contribution 
FROM genre_streams
ORDER BY genre_total_streams DESC ;
-- ==========================================================================
-- Part 8 : Views
-- ==========================================================================
-- 8.1 : Create a view showing the top 20 artists by total streams.
CREATE VIEW artist_stream_summary AS 
			SELECT 
                  artist_name,
                  country_of_origin,
                  primary_genre,
                  total_streams_millions
            FROM spotify_artists ;
           
            
SELECT * 
FROM artist_stream_summary
ORDER BY total_streams_millions DESC 
LIMIT 20 ;   
-- 8.2 : Create a view showing country-wise artist count and total streams.
CREATE VIEW country_wise_artist AS
			 SELECT 
				   country_of_origin,
                   COUNT(artist_name) AS total_artist,
                   SUM(total_streams_millions) AS total_streams
			 FROM spotify_artists
             GROUP BY country_of_origin ;
             
SELECT *
FROM country_wise_artist ;
-- 8.3 : Create a view showing genre-wise artist count and average streams.
CREATE VIEW genre_wise_artist AS
            SELECT
                 primary_genre,
                 COUNT(artist_name) AS total_artist,
                 ROUND(AVG(total_streams_millions), 1) AS avg_streams
			FROM spotify_artists
            GROUP BY primary_genre ;
            
SELECT *
FROM genre_wise_artist ;           
-- 8.4 : Create a view showing artists with above-average total streams.
CREATE VIEW above_average_artists AS
            SELECT  
                  artist_name,
                  total_streams_millions
			FROM spotify_artists     
            WHERE total_streams_millions > (SELECT 
												  AVG(total_streams_millions)
											FROM spotify_artists) ;

SELECT *
FROM above_average_artists ;
-- 8.5 : Create a view for a dashboard containing artist name, country, genre, total streams, and debut year.
CREATE VIEW dashboard AS 
			SELECT 
                  artist_name,
                  country_of_origin AS country,
                  primary_genre AS genres,
                  total_streams_millions,
                  debut_year
			FROM spotify_artists ;

SELECT *
FROM dashboard ;
-- ==========================================================================
-- Part 9 : Indexes
-- ==========================================================================
-- 9.1 : Create an index on country_of_origin.
CREATE INDEX idx_country_of_origin
ON spotify_artists(country_of_origin) ; 
-- 9.2 : Create an index on primary_genre.
CREATE INDEX idx_primary_genre
ON spotify_artists(primary_genre) ;
-- 9.3 : Create an index on total_streams_millions.
CREATE INDEX idx_total_streams_millions
ON spotify_artists(total_streams_millions) ;
-- 9.4 : Create a composite index on country_of_origin and primary_genre.
CREATE INDEX idx_country_genre
ON spotify_artists(country_of_origin, primary_genre) ;
-- 9.5 : Show all index.
SHOW INDEX
FROM spotify_artists ;
-- 9.6 : Use EXPLAIN to compare query performance before and after creating an index. 
EXPLAIN 
SELECT *
FROM spotify_artists
WHERE country_of_origin = "Mexico";

EXPLAIN 
SELECT *
FROM spotify_artists
WHERE primary_genre = "Rock";

EXPLAIN 
SELECT *
FROM spotify_artists
WHERE total_streams_millions > 10000;
-- ==========================================================================
-- Part 10 : Window Functions
-- ==========================================================================
-- 10.1 : Assign a ROW_NUMBER() to artists based on total streams.
SELECT 
      ROW_NUMBER() OVER(ORDER BY total_streams_millions DESC) AS artist_rank,
      artist_name,
      total_streams_millions
FROM spotify_artists ;
-- 10.2 : Rank artists using RANK() based on total streams.
SELECT 
      RANK() OVER(ORDER BY total_streams_millions DESC) AS artist_rank,
      artist_name,
      total_streams_millions
FROM spotify_artists ;
-- 10.3 : Rank artists using DENSE_RANK() based on total streams.
SELECT 
      DENSE_RANK() OVER(ORDER BY total_streams_millions DESC) AS artist_rank,
      artist_name,
      total_streams_millions
FROM spotify_artists ;
-- 10.4 : Find the top 3 artists within each primary genre.
WITH rank_artists AS 
      (SELECT 
			 ROW_NUMBER() OVER(PARTITION BY primary_genre ORDER BY total_streams_millions DESC) AS top_artists,
             artist_name,
             primary_genre,
			 total_streams_millions
      FROM spotify_artists)
      
SELECT *
FROM rank_artists      
WHERE top_artists <= 3 
ORDER BY primary_genre, top_artists;
-- 10.5 : Find the top 3 artists within each country.
WITH artists_rank AS
     (SELECT 
            ROW_NUMBER() 
            OVER(PARTITION BY country_of_origin
            ORDER BY total_streams_millions DESC)
            AS top_artists,
            artist_name,
            country_of_origin,
            total_streams_millions
      FROM spotify_artists)

SELECT *
FROM artists_rank
WHERE top_artists <= 3
ORDER BY country_of_origin, top_artists;
-- 10.6 : Calculate each artist's percentage contribution to total streams.
SELECT 
      artist_name,
      sex,
      country_of_origin,
      primary_genre,
      ROUND(total_streams_millions * 100 / 
      SUM(total_streams_millions) OVER(), 2)
      AS percentage_contribution 
FROM spotify_artists 
ORDER BY percentage_contribution DESC ;
-- 10.7 : Calculate the cumulative total streams ordered by artist ranking.
SELECT
      artist_name,
      total_streams_millions,
      SUM(total_streams_millions) 
      OVER(ORDER BY total_streams_millions DESC
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
	       AS cumulative_total_streams
FROM spotify_artists 
ORDER BY total_streams_millions DESC ;       
-- 10.8 : Use LAG() to compare each artist's streams with the previous artist.
SELECT 
	  artist_name,
	  total_streams_millions,
	  LAG(total_streams_millions) 
	  OVER(ORDER BY total_streams_millions DESC) AS previous_stream,
      
      (total_streams_millions - LAG(total_streams_millions) 
	  OVER(ORDER BY total_streams_millions DESC)) AS stream_difference
FROM spotify_artists ;
-- 10.9 : Use LEAD() to compare each artist's streams with the next artist.
SELECT 
      artist_name,
      total_streams_millions,
      LEAD(total_streams_millions) 
      OVER(ORDER BY total_streams_millions DESC) AS next_stream,
      
      (total_streams_millions - LEAD(total_streams_millions) 
      OVER(ORDER BY total_streams_millions DESC)) AS stream_difference
FROM spotify_artists ;
-- 10.10 : Divide artists into four groups using NTILE(4) based on total streams.
WITH artist_quartile AS
      (SELECT 
			 artist_name,
			 total_streams_millions,
			 NTILE(4) OVER(ORDER BY total_streams_millions DESC) AS stream_quartile
      FROM spotify_artists)
      
SELECT 
	  artist_name,
	  total_streams_millions,
      stream_quartile,
      CASE NTILE(4) OVER(ORDER BY total_streams_millions DESC) 
           WHEN 1 THEN "Top 25%"
           WHEN 2 THEN "25% - 50%"
           WHEN 3 THEN "50% - 75%"
           ELSE "Bottom 25%"
	  END AS stream_group
FROM artist_quartile ;
-- ==========================================================================
-- Part 11 : Business Insights
-- ==========================================================================
-- 11.1 : Which country has the strongest Spotify artist presence based on artist count?
SELECT
      country_of_origin,
      COUNT(*) AS total_artists
FROM spotify_artists 
GROUP BY country_of_origin
ORDER BY total_artists DESC 
LIMIT 1 ;
-- 11.2 : Which country generates the highest total streams?
SELECT 
      country_of_origin,
      SUM(total_streams_millions) AS total_streams
FROM spotify_artists 
GROUP BY country_of_origin
ORDER BY total_streams DESC 
LIMIT 1 ;
-- 11.3 : Which genre generates the highest total streams?.
SELECT 
      primary_genre,
      ROUND(SUM(total_streams_millions), 2) AS total_streams
FROM spotify_artists 
GROUP BY primary_genre
ORDER BY total_streams DESC
LIMIT 1 ;
-- 11.4 : Which genre has the highest average streams per artist?.
SELECT 
      primary_genre,
      COUNT(*) AS total_artists,
      ROUND(AVG(total_streams_millions), 2) AS average_streams_per_artists
FROM spotify_artists 
GROUP BY primary_genre
ORDER BY average_streams_per_artists DESC 
LIMIT 1 ;
-- 11.5 : Which artists rely most heavily on collaborations?
SELECT 
	  artist_name,
      collaborative_streams_millions,
      collaborative_stream_percentage
FROM spotify_artists 
ORDER BY collaborative_stream_percentage DESC 
LIMIT 10 ;
-- 11.6 : Which artists have the strongest solo-stream performance? 
SELECT
      artist_name,
      solo_streams_millions,
      solo_stream_percentage
FROM spotify_artists 
ORDER BY solo_stream_percentage DESC
LIMIT 10 ;
-- 12.1 : Create an executive summary report containing:
-- Total Artists
-- Total Countries
-- Total Genres
-- Total Streams
-- Average Streams per Artist
-- Average Solo-Stream Percentage
-- Average Collaborative-Stream Percentage
-- Highest-Streamed Artist
-- Top Country by Artist Count
-- Top Country by Total Streams
-- Top Genre by Artist Count
-- Top Genre by Total Streams
-- Genre with the Highest Average Streams per Artist
-- Top Artist by Solo Streams
-- Top Artist by Collaborative Streams
-- Artist with the Highest Solo-Stream Percentage
-- Artist with the Highest Collaborative-Stream Percentage
-- Earliest Debut Year
-- Latest Debut Year
WITH  executive_summary_report AS
      (SELECT
            (SELECT 
				   COUNT(DISTINCT artist_name) 
	         FROM spotify_artists)
             AS total_artists,
             
             (SELECT 
                   COUNT(DISTINCT country_of_origin)
             FROM spotify_artists) 
             AS total_countries,
             
             (SELECT 
                    COUNT(DISTINCT primary_genre)
              FROM spotify_artists)
              AS total_genres,
              
			 (SELECT 
                     SUM(total_streams_millions)
			  FROM spotify_artists) 
              AS total_streams,
               
			 (SELECT 
                     ROUND(AVG(total_streams_millions), 2)
              FROM spotify_artists) 
              AS average_streams_per_artists,
              
			 (SELECT 
					ROUND(AVG(solo_stream_percentage), 2)
			  FROM spotify_artists) 
              AS average_solo_stream_percentage,
               
			 (SELECT 
                    ROUND(AVG(collaborative_stream_percentage), 2)
			  FROM spotify_artists) 
              AS average_collaborative_stream_percentage,
					
			  (SELECT 
                     artist_name
               FROM spotify_artists
               ORDER BY total_streams_millions DESC
               LIMIT 1) 
               AS top_artist_by_highest_streamed_artist,
               
               (SELECT 
                      country_of_origin
				FROM spotify_artists
                GROUP BY country_of_origin
                ORDER BY COUNT(*) DESC
                LIMIT 1) 
                AS top_country_by_artists_count,
                
                (SELECT 
                       country_of_origin
                 FROM spotify_artists
                 GROUP BY country_of_origin
                 ORDER BY SUM(total_streams_millions) DESC
                 LIMIT 1) 
                 AS top_country_by_total_streams,
                 
                 (SELECT 
                        primary_genre
			      FROM spotify_artists
                  GROUP BY primary_genre
                  ORDER BY COUNT(*) DESC
                  LIMIT 1) 
                  AS top_genre_by_artist_count,
              
                 (SELECT 
                        primary_genre
                  FROM spotify_artists
                  GROUP BY primary_genre
                  ORDER BY SUM(total_streams_millions) DESC
                  LIMIT 1) AS top_genre_by_total_streams,
                  
                  (SELECT 
                         primary_genre
                   FROM spotify_artists
                   GROUP BY primary_genre
				   ORDER BY ROUND(AVG(total_streams_millions), 2) DESC
                   LIMIT 1) AS highest_average_streams,
                   
                   (SELECT 
                          artist_name
                    FROM spotify_artists
                    ORDER BY solo_streams_millions DESC
                    LIMIT 1) AS top_artist_by_solo_streams,
                    
                    (SELECT
						   artist_name
                    FROM spotify_artists
                    ORDER BY collaborative_streams_millions DESC
                    LIMIT 1) 
                    AS top_artist_by_collaboratives_streams,
                    
                   (SELECT 
                          artist_name
				    FROM spotify_artists
                    ORDER BY solo_stream_percentage DESC
                    LIMIT 1) 
                    AS top_artist_by_highest_solo_stream_percentage,
                    
                    (SELECT 
                          artist_name
				    FROM spotify_artists
                    ORDER BY collaborative_stream_percentage DESC
                    LIMIT 1) 
                    AS top_artist_by_highest_collaborative_stream_percentage,
                    
                    (SELECT 
                           MIN(debut_year)
                     FROM spotify_artists
                     ORDER BY debut_year ASC) 
                     AS earliest_debut_year,
                     
                     (SELECT 
                           MAX(debut_year)
                     FROM spotify_artists
                     ) 
                     AS latest_debut_year
                     )
                     
SELECT *
FROM executive_summary_report ;
				
-- 12.2 Top 10 Artists' Contribution to Total Streams
WITH top_10_artists AS 
	 (SELECT 
			artist_name,
			total_streams_millions
	  FROM spotify_artists
	  ORDER BY total_streams_millions DESC
	  LIMIT 10)
                            
SELECT                  
	  artist_name,
	  total_streams_millions,
	  ROUND(
      total_streams_millions * 100 / 
      (SELECT SUM(total_streams_millions)
       FROM spotify_artists), 
      2
      ) 
      AS percentage_contribution
FROM top_10_artists
ORDER BY total_streams_millions DESC ;

/*
==========================================================================================

                        SPOTIFY ARTISTS ANALYSIS PROJECT

===========================================================================================

Project Name : Spotify Artists Analysis using SQL
Database     : MySQL
Dataset      : Spotify Artists Analysis 1949 - 2021
Author       : Divyanshi Sagal
Project Type : SQL Data Analysis Portfolio Project

---

## PROJECT OBJECTIVE

This project analyzes a Spotify Artists dataset to demonstrate practical SQL
skills, including database creation, data validation, exploratory data analysis,
advanced SQL queries, window functions, views, indexes, and business insights.
The project focuses on analyzing artist popularity, streaming performance,
genres, countries, debut years, and solo versus collaborative streaming behavior
using MySQL.

---

## SQL TOPICS COVERED

✔ Database Creation (DDL)
✔ Table Creation & Data Types
✔ Data Import
✔ Data Cleaning & Validation
✔ Exploratory Data Analysis (EDA)
✔ Basic SQL Queries
✔ Aggregate Functions
✔ GROUP BY & HAVING
✔ CASE Statements
✔ String Functions
✔ Date/Year Analysis
✔ Subqueries
✔ Common Table Expressions (CTEs)
✔ Views
✔ Indexes
✔ Query Optimization using EXPLAIN
✔ Window Functions
✔ Business Insight Queries
✔ Executive Summary Report

---

## KEY BUSINESS QUESTIONS ANSWERED

✔ Total Number of Artists
✔ Total Countries Represented
✔ Total Primary Genres
✔ Most-Streamed Artists
✔ Least-Streamed Artists
✔ Country with the Most Artists
✔ Country Generating the Highest Total Streams
✔ Genre Generating the Highest Total Streams
✔ Genre with the Highest Average Streams per Artist
✔ Average Streams by Genre
✔ Average Streams by Artist Type
✔ Artists with Above-Average Total Streams
✔ Artists with Above-Average Solo Streams
✔ Artists with the Highest Solo-Stream Performance
✔ Artists with the Highest Collaboration Dependency
✔ Solo vs Collaborative Streaming Performance
✔ Genre-wise Streaming Contribution
✔ Country-wise Artist Count and Streaming Performance
✔ Top Artists within Each Genre
✔ Top Artists within Each Country

---

## SQL CONCEPTS DEMONSTRATED

✔ SELECT, WHERE, ORDER BY
✔ DISTINCT
✔ LIMIT
✔ LIKE & BETWEEN
✔ COUNT, SUM, AVG, MIN & MAX
✔ GROUP BY & HAVING
✔ CASE Expressions
✔ String Functions
✔ Subqueries
✔ Correlated Subqueries
✔ Common Table Expressions (CTEs)
✔ Views
✔ Indexes
✔ EXPLAIN
✔ ROW_NUMBER()
✔ RANK()
✔ DENSE_RANK()
✔ LAG()
✔ LEAD()
✔ NTILE()
✔ PARTITION BY
✔ Window Aggregations
✔ Cumulative Calculations
✔ Percentage Contribution Analysis

---

## DATA QUALITY & VALIDATION

✔ Duplicate Artist Detection
✔ NULL Value Detection
✔ Empty Value Detection
✔ Leading & Trailing Space Detection
✔ Debut Year Validation
✔ Invalid Stream Value Detection
✔ Percentage Range Validation
✔ Total Stream Consistency Checks
✔ Lead + Feature Stream Validation
✔ Solo + Collaborative Stream Validation

---

## ANALYTICAL AREAS

✔ Artist Popularity Analysis
✔ Streaming Performance Analysis
✔ Genre Analysis
✔ Country-wise Analysis
✔ Artist Type Analysis
✔ Debut Year Analysis
✔ Solo Streaming Analysis
✔ Collaborative Streaming Analysis
✔ Artist Ranking Analysis
✔ Streaming Contribution Analysis
✔ Cumulative Streaming Analysis
✔ Top Artist Analysis

---

## PROJECT OUTCOME

This project demonstrates practical SQL skills for analyzing music streaming
data. It showcases the ability to design a database, validate and clean data,
perform exploratory analysis, use advanced SQL techniques, apply window
functions, create reusable views, optimize queries using indexes, and generate
business-oriented insights from Spotify artist streaming data.

The project provides a complete SQL workflow from data preparation and
exploration to advanced analysis and reporting, making it suitable as an
intermediate-level SQL data analytics portfolio project.

=========================================================================================

                              END OF PROJECT

=========================================================================================
*/


