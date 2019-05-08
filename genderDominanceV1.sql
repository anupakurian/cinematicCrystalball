
create or replace view movies_database.Gender1 as
(select t1.movie_id, count(*) as Gender1Count from movies_database.movie_cast t1
where 
t1.gender = 1
and
t1.movie_id in (SELECT movie_id FROM movies_database.movies_finance)
group by t1.movie_id) ;

select count(*) from movies_database.movies_finance;
select count(*) from movies_database.Gender1;

create or replace view movies_database.nonGender1 as
(select movie_id,0 as Gender1Count from movies_database.movies_finance where movie_id not in 
(select movie_id from movies_database.Gender1));

select count(*) from movies_database.nonGender1;
select count(*) from movies_database.Gender1;

create or replace view movies_database.allGender1 as
(select * from movies_database.nonGender1
union
select * from movies_database.Gender1);

select count(*) from movies_database.allGender1;


create or replace view movies_database.Gender2 as
(select t2.movie_id, count(*) as Gender2Count from movies_database.movie_cast t2
where 
t2.gender = 2
and
t2.movie_id in (SELECT movie_id FROM movies_database.movies_finance)
group by t2.movie_id);

select count(*) from movies_database.movies_finance;
select count(*) from movies_database.Gender2;

create or replace view movies_database.nonGender2 as
(select movie_id,0 as Gender2Count from movies_database.movies_finance where movie_id not in 
(select movie_id from movies_database.Gender2));

select count(*) from movies_database.nonGender2;
select count(*) from movies_database.Gender2;

create or replace view movies_database.allGender2 as
(select * from movies_database.nonGender2
union
select * from movies_database.Gender2);

select count(*) from movies_database.allGender2;




create or replace view movies_database.Gender0 as 
(select t3.movie_id, count(*) as Gender0Count from movies_database.movie_cast t3
where 
t3.gender = 0
and
t3.movie_id in (SELECT movie_id FROM movies_database.movies_finance)
group by t3.movie_id);

select count(*) from movies_database.movies_finance;
select count(*) from movies_database.Gender0;

create or replace view movies_database.nonGender0 as
(select movie_id,0 as Gender0Count from movies_database.movies_finance where movie_id not in 
(select movie_id from movies_database.Gender0));

select count(*) from movies_database.nonGender0;
select count(*) from movies_database.Gender0;

create or replace view movies_database.allGender0 as
(select * from movies_database.nonGender0
union
select * from movies_database.Gender0);

select count(*) from movies_database.allGender0;



create or replace view movies_database.movie_cast_gender_profile as (
select 
a.movie_id, 
a.Gender1Count, 
b.Gender2Count, 
c.Gender0Count
from movies_database.allGender1 a inner join movies_database.allGender2 b 
on a.movie_id = b.movie_id
inner join movies_database.allGender0 c
on b.movie_id = c.movie_id
);

CREATE or replace view movies_database.movie_cast_gender_profile_final AS 
select 
movie_id, 
Gender1Count,
Gender2Count,
Gender0Count,
CASE
	WHEN Gender1Count > Gender2Count and Gender1Count > Gender0Count  THEN 'femaleDominated'
	WHEN Gender2Count > Gender1Count and Gender2Count > Gender0Count THEN 'maleDominated'
	WHEN Gender0Count > Gender1Count and Gender0Count > Gender1Count THEN 'Unknown'
	WHEN Gender0Count = Gender1Count and Gender0Count = Gender2Count THEN 'GenderEquality'
	ELSE 'unkown'
END AS GenderDominance
from 
movies_database.movie_cast_gender_profile
where gender1count >0 or gender2count>0 or gender0count>0
;

select count(distinct movie_id) from movies_database.movie_cast where movie_id in (select movie_id from
movies_database.movies_finance) ; 

select * from movies_database.movie_cast_gender_profile_final;

select * from movies_database.movie_cast_gender_profile_final;

select * from movies_database.movie_cast;