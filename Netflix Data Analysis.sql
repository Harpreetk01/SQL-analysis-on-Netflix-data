use netflix_imdb;

#Load data
select * from genre;
select * from netflix_original;

#1. Change the premiere date column into sql date format
Alter Table netflix_original add column new_date date;
Update netflix_original Set bew_date = str_to_date(substr(Premiere_Date, 1, 10), '%d-%m-%Y');

#2. Total Count of Language
select Language, count(*) from netflix_original group by Language;

#3. Which language has higher IMDBScore rate?
select Language, round(avg(IMDBScore),2) AS IMDBScore from netflix_original group by Language order by IMDBScore desc;

#4. Higher, Lower and Average rating of IMDBScore
select max(IMDBScore) as Highest_IMDBScore, min(IMDBScore) as Lowest_IMDBScore, round(avg(IMDBScore),2) as Average_IMDBScore from netflix_original;

#5. Highest and Lowest rated movie
#5.1.  Highest Rated Movie
select Movie, IMDB_Rate, Language from (
select (Title) as Movie, avg(IMDBScore) as IMDB_Rate, Language from netflix_original group by Movie, Language
)
netflix_original where IMDB_Rate >= 9;

#5.2  Lowest Rated Movie
select Movie, IMDBScore, Language from (
select (Title) as Movie, IMDBScore, Language, dense_rank() over(order by IMDBScore) as d_rank from netflix_original
)
netflix_original where d_rank = 1;

#6. Which film has higher runtime?
select (Title) as Movie, avg(Runtime) Runtime from netflix_original group by Movie order by Runtime desc limit 10;

#7. Which year highest no.of film release
select year(new_date) as year, count(*) Number_of_film_release from netflix_original group by year order by year desc;

#8. Which genre has higher imdb score?
select Genre, IMDBScore, rnk  from  
(
select genre.Genre, netflix_original.IMDBScore, row_number() over(partition by Genre) as rnk from netflix_original
INNER JOIN genre
ON netflix_original.GenreID = genre.GenreID
order by IMDBScore desc
)
netflix_original where rnk = 1;

												# OR

select genre.Genre, round(avg(netflix_original.IMDBScore),2) as IMDB_Rate from netflix_original, genre
where netflix_original.GenreID = genre.GenreID
group by Genre
order by IMDB_Rate desc;

#9. Which language has higher runtime
select language, round(avg(runtime),2) as Runtime from netflix_original 
group by language
order by Runtime desc;
