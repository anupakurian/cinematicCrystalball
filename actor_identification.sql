


select distinct(actor_name) from (
select movie_id, actor_name 
from movies_database.movie_cast 
where actor_id
 in (
select actor_id from

 (
select actor_id,count(*) from movies_database.movie_cast
group by actor_id having count(*) > 10
order by actor_id)A)

and 
movie_id in 
(select movie_id from movies_database.movies_finance
where Budget > 0))A;

/*actor identification query */

select movie_id, actor_name 
from movies_database.movie_cast 
where actor_id
 in (
select actor_id from

 (
select actor_id,count(*) from movies_database.movie_cast
group by actor_id having count(*) > 10
order by actor_id)A)

and 
movie_id in 
(select movie_id from movies_database.movies_finance
where Budget > 0);