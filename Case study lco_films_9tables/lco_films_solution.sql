show databases;
use lco_films;
show tables;
select * from film;

-- Q1) Which categories of movies released in 2018? Fetch with the number of movies. 
select * from(
select release_year,name 
from (
select release_year,category_id
from film f
join film_category fc
on (f.film_id=fc.film_id)
) s
join category c
on s.category_id=c.category_id
) cat
where release_year=2018;

-- Q2) Update the address of actor id 36 to “677 Jazz Street”. 
select * from actor
where actor_id=36; -- corrosponding adress id is 35 as retrieved from the actor dataset
select * from address
where address_id=35;
update address
set address='677 Jazz Street'
where address_id=35;

-- Q3) Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).
select * from film
where film_id=41;
select * from film_actor
where film_id=41;-- need to add new row
 Insert into film_actor(actor_id,film_id)
	select 105,41
    union all
    select 95,41;
    
    
-- Q4) Get the name of films of the actors who belong to India.
select country,count(title) as Total_films from
(select country,film_id from 
(select * from
(select country,actor_id from
(select address_id,country from
(select city_id,city,country 
from city c
join country cy
on c.country_id=cy.country_id) cyt
join address a
on a.city_id=cyt.city_id) ac
join actor a
on a.address_id=ac.address_id) st
where country like "%ndia%") s
join film_actor fa
on s.actor_id=fa.actor_id) sf
join film f
on sf.film_id=f.film_id
;


-- Q5) How many actors are from the United States?
select country,count(actor_id) from
(select address_id,country from
(select city_id,country
from city c
join country ct
on c.country_id=ct.country_id) s
join address a
on a.city_id=s.city_id) s
join actor a
on a.address_id=s.address_id
where country like "%nited sta%"
;

-- Q6) Get all languages in which films are released in the year between 2001 and 2010.
select distinct name
from film f
join language l
on f.language_id=l.language_id
where release_year between 2001 and 2010;



-- Q7) The film ALONE TRIP (id:17) was actually released in Mandarin, update the info.
select * from film where title like "%ALONE%";
select * from language where name like "%Manda%";
update film
set language_id=4
where title like "%ALONE%";


-- Q8) Fetch cast details of films released during 2005 and 2015 with PG rating.
select concat(first_name," ",last_name) as Name,title,rating,address,district,phone,city,country from
(select title,rating,first_name,last_name,address,district,phone,city,country_id from
(select title,rating,first_name,last_name,address,district,phone,city_id from
(select title,first_name,last_name,address_id,rating from
(select actor_id,title,rating from
(select rating,film_id,title from film
where rating='PG') s
join film_actor fa
on fa.film_id=s.film_id) s
join actor a
on a.actor_id=s.actor_id) s
join address a
on a.address_id=s.address_id) s
join city c
on c.city_id=s.city_id) s
join country c
on c.country_id=s.country_id
;

-- Q9) In which year most films were released?
select release_year,max(`Number of films realeased`) as Total_Movies from
(select release_year,count(title) as "Number of films realeased" from film
group by release_year
order by `Number of films realeased` desc) s;


-- Q10) In which year least number of films were released?
select * from
(select release_year,count(title) as "Number of films realeased" from film
group by release_year
order by `Number of films realeased`) s
limit 1;

-- Q11) Get the details of the film with maximum length released in 2014 .
select * from film where release_year=2014 
order by length desc
limit 1;

-- Q12) Get all Sci- Fi movies with NC-17 ratings and language they are screened in.
select title,name,rating,release_year from
(select title,category_id,rating,release_year
from film f
join film_category fc
on f.film_id=fc.film_id) s
join category c
where s.category_id=c.category_id and rating='NC-17' and name like "%Sci%"; 

/* Q13) The actor FRED COSTNER (id:16) shifted to a new address:
 055,  Piazzale Michelangelo, Postal Code - 50125 , District - Rifredi at Florence, Italy. 
 Insert the new city and update the address of the actor.*/

   -- From country dataset and note its country id
   -- Add Florence in the city dataset corrosponding to country id of italy and note its city id
   -- in adress dataset insert the new data and note the adress id
   -- update the adress id corrosponding to the actor_id:16 in actor dataset
   
select * from address order by address_id desc limit 5;
desc address;
select * from country where country='Italy';
select * from city where country_id=49; 
desc city;

Insert into city(city,country_id)
values('Florence',49); -- city id we get is 601
Insert into address(address,district,city_id,postal_code,phone)
values('055,  Piazzale Michelangelo','Rifredi',601,'50125','123456');

select * from address where postal_code='50125'; -- address_id recieved is 606
select * from actor where actor_id=16;
update actor
set address_id=606
where actor_id=16;

/* Q14) A new film “No Time to Die” is releasing in 2020 whose details are : 
Title :- No Time to Die
Description: Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.
Language: English
Org. Language : English
Length : 100
Rental duration : 6
Rental rate : 3.99
Rating : PG-13
Replacement cost : 20.99
Special Features = Trailers,Deleted Scenes

Insert the above data.
*/
select * from language where name='English'; -- langugae_id=1
Insert into film(title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating,special_features)
values('No Time to Die',"Recruited to rescue a kidnapped scientist, globe-trotting spy James Bond finds himself hot on the trail of a mysterious villain, who's armed with a dangerous new technology.",
2020,1,1,6,3.99,100,20.99,'PG-13','Trailers,Deleted Scenes');

select * from film where title like "%Time%";

-- Q15) Assign the category Action, Classics, Drama  to the movie “No Time to Die” .
		-- against film id 1001 introduce three entries one for action other for classic and another is drama.
select * from film_category where film_id=1001;
INSERT INTO `film_category`(`category_id`, `film_id`) VALUES ((SELECT category_id
FROM category WHERE category.name = "Action"), (SELECT film_id FROM film WHERE
film.title = "No Time to Die" )),
((SELECT category_id FROM category WHERE category.name = "Classics") , (SELECT film_id
FROM film WHERE film.title = "No Time to Die" )) ,
((SELECT category_id FROM category WHERE category.name = "Drama") , (SELECT film_id
FROM film WHERE film.title = "No Time to Die" ));

-- Q16) Assign the cast: PENELOPE GUINESS, NICK WAHLBERG, JOE SWANK to the movie “No Time to Die” .
select * from actor where last_name like  "%GUINESS%" or last_name like "%WAHLBERG%" or last_name like "%SWANK%";
	-- actor id of penelope:1 , nick:2 , Joe:9
select * from film_actor;
	-- film id of No Time To Die is : 1001
Insert into film_actor(film_id,actor_id) values (1001,1),(1001,2),(1001,9);
select * from film_actor where film_id=1001;


-- Q17) Assign a new category Thriller  to the movie ANGELS LIFE.
insert into category(name) values('Thriller');
select film_id from film where title like "%ANGELS LI%";
select * from film_category where film_id=25;

insert into film_category(film_id,category_id) 
values((select film_id from film where title like "%ANGELS LI%"),(select category_id from category where name='Thriller'));
select * from film_category where film_id=25;

-- Q18) Which actor acted in most movies?
select concat(first_name," ",last_name) as Name,Number_of_films from 
(select actor_id,count(film_id) as Number_of_films from film_actor
group by actor_id ) s
join actor a
on a.actor_id=s.actor_id
order by Number_of_films desc
Limit 1
;

-- Q19) The actor JOHNNY LOLLOBRIGIDA was removed from the movie GRAIL FRANKENSTEIN. How would you update that record?
	-- just update in the film_actor dataset by dropping the actor id corrosponding to JOHNNY LOLLOBRIGIDA against the film id of GRAIL FRANKENSTEIN
 	select actor_id from actor where first_name ='JOHNNY' and last_name='LOLLOBRIGIDA';
        select film_id from film where title='GRAIL FRANKENSTEIN';
        
        delete from film_actor 
        where 
        actor_id=(select actor_id from actor where first_name ='JOHNNY' and last_name='LOLLOBRIGIDA')
        and 
        film_id=(select film_id from film where title='GRAIL FRANKENSTEIN');
    
-- Q20) The HARPER DYING movie is an animated movie with Drama and Comedy. Assign these categories to the movie.
    insert into film_category(film_id,category_id)
    values
    ((select film_id from film where title='HARPER DYING'),(select category_id from category where name='Comedy')),
    ((select film_id from film where title='HARPER DYING'),(select category_id from category where name='Drama'));
    
    select * from film_category order by last_update desc;
    
-- Q21) The entire cast of the movie WEST LION has changed. 
-- The new actors are DAN TORN, MAE HOFFMAN, SCARLETT DAMON. How would you update the record in the safest way?
    select film_id from film where title='WEST LION';
    delete from film_actor where film_id=(select film_id from film where title='WEST LION');
    Insert into film_actor(film_id,actor_id)
    values 
    ((select film_id from film where title='WEST LION'),(select actor_id from actor where concat(first_name,last_name)='DANTORN')),
    ((select film_id from film where title='WEST LION'),(select actor_id from actor where concat(first_name,last_name)='MAEHOFFMAN')),
    ((select film_id from film where title='WEST LION'),(select actor_id from actor where concat(first_name,last_name)='SCARLETTDAMON'));
    
-- Q22) The entire category of the movie WEST LION was wrongly inserted. The correct categories are Classics, Family, Children.
-- How would you update the record ensuring no wrong data is left?
    select category_id,film_id from film_category where film_id=(select film_id from film where title="WEST LION");
    select category_id from category where name='Classics' or name='Family' or name='Children';
    delete from film_category where film_id=(select film_id from film where title='WEST LION');
    insert into film_category(film_id,category_id)
    values
    ((select film_id from film where title='WEST LION'),(select category_id from category where name='Classics')),
    ((select film_id from film where title like "%WEST LION%"),(select category_id from category where name='Family')),
    ((select film_id from film where title='WEST LION'),(select category_id from category where name='Children'));
    
-- Q23) How many actors acted in films released in 2017?
	select count(actor_id) as `Number of actors whoose film released in year 2017` 
	from film_actor 
	where film_id in (select film_id from film where release_year=2017);

-- Q24) How many Sci-Fi films released between the year 2007 to 2017?
	select count(title) as `Total number of scifi movies released in year between 2007 and 2017`
	from film 
	where release_year between 2007 and 2017 
	and film_id in 
	(
	select film_id from film_category 
	where 
	category_id=(
	select category_id from category where name='Sci-Fi' 
		) 
	);

-- Q25) Fetch the actors of the movie WESTWARD SEABISCUIT with the city they live in.
    select first_name,last_name,city from(
    select city_id,first_name,last_name from (
    select first_name,last_name,address_id from
    film_actor f
    join actor a
    where a.actor_id=f.actor_id and film_id=(select film_id from film where title='WESTWARD SEABISCUIT')
    ) s
    join address a
    where a.address_id=s.address_id) s
    join city c
    where c.city_id=s.city_id;
    
    
-- Q26) What is the total length of all movies played in 2008?
    select release_year,sum(length) as `Total Length` 
    from film 
    where release_year=2008;
    
-- Q27) Which film has the shortest length? In which language and year was it released?
	select title,release_year,name 
	from(
	select title,release_year,language_id 
	from film 
	where length=(select min(length) from film)
	) s
	join language l
	where l.language_id=s.language_id;

-- Q28) How many movies were released each year?
	select release_year,count(film_id) as `Number of films released` 
	from film 
	group by release_year 
	order by release_year desc;

-- Q29)  How many languages of movies were released each year?.
	select release_year,count(distinct language_id) 
	from film
	group by release_year
	order by release_year desc;
	
