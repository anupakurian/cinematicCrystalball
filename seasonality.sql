  select * from movies_database.movies_metadata where month(release_date) = 12;
  
  select min(release_date) from movies_database.movies_metadata ;
  
  /*Seasonality*/
  select movie_id
  ,release_date
  ,case WHEN  month(release_date)= 12 Then 'Xmas'
  WHEN month(release_date)= 11 Then 'Thanks Giving'
  WHEN month(release_date) in (6,7,8) Then 'Summer'
  Else 'Regular'
  END as 'Seasonlaity'
  from movies_database.movies_metadata 
  where movie_id in 
(select movie_id from movies_database.movies_finance)
  ;
 