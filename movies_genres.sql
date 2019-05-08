select a.movie_id, b.description as genres_name
from movies_database.movies_genres A
inner join movies_database.genres_master B
on a.genres_id = b.genres_id
and movie_id in (
    select movie_id from movies_database.movies_finance
   );