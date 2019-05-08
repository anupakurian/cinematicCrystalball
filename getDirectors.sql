/*get directors 1*/
select movie_id, crew_name 
from movies_database.movie_crew 
where job_title = 'Director'
and crew_name in (
select crew_name from

 (
select crew_name,count(*) from movies_database.movie_crew
where department = 'Directing' and
job_title = 'Director'
group by crew_name having count(*) > 20
order by crew_name)A)


UNION

/*get directors 2*/
select movie_id,crew_name 
from movies_database.movie_crew
where department = 'Directing' 
and job_title = 'Director' 
and movie_id in 
(select movie_id from movies_database.movies_finance
where Budget > 50000000
order by crew_name);
