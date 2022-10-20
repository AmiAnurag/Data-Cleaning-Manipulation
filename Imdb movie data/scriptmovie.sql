create database movie;
show databases;
use movie;
show tables;
select * from `top_1000_highest_grossing_movies_of_all_time`;

-- describe the table
select count(*) as `number of rows` from top_1000_highest_grossing_movies_of_all_time ;
SELECT count(*) as No_of_Column FROM information_schema.columns WHERE table_name ='top_1000_highest_grossing_movies_of_all_time';
desc top_1000_highest_grossing_movies_of_all_time;

-- change the datatype of Year of Realease field into date datatype
alter table top_1000_highest_grossing_movies_of_all_time
modify `Year of Realease` YEAR;


-- Introduce a new field showing how old the movie is
select `Year of Realease` , year(curdate())-`Year of Realease` as MovieAge
From `top_1000_highest_grossing_movies_of_all_time`;
select year(curdate());

Alter Table top_1000_highest_grossing_movies_of_all_time
add MovieAge int ;
Update top_1000_highest_grossing_movies_of_all_time
set MovieAge=year(curdate())-`Year of Realease`;
select MovieAge,`Year of Realease`
From top_1000_highest_grossing_movies_of_all_time;

-- Give an unique id to each movie
select sha1(`Movie Title`) from `top_1000_highest_grossing_movies_of_all_time`;

Alter table `top_1000_highest_grossing_movies_of_all_time`
Add MovieId varchar(50) not null after `Movie Title`; 
Update `top_1000_highest_grossing_movies_of_all_time`
set MovieId=sha1(concat(`Movie Title`,`Year of Realease`));
Alter table `top_1000_highest_grossing_movies_of_all_time`
add primary key(MovieId);

-- labelling film as Action , comedy , romance , horror , Sci-Fi , 'Drama'
select distinct Genre from `top_1000_highest_grossing_movies_of_all_time`;

Alter Table top_1000_highest_grossing_movies_of_all_time
add Action int;
Update top_1000_highest_grossing_movies_of_all_time
set Action=1
where Genre like "%Action%";

Alter Table top_1000_highest_grossing_movies_of_all_time
add comedy int,
add horror int,
add romance int,
add sci_fi int,
add drama int;
Update top_1000_highest_grossing_movies_of_all_time
set horror=1 where Genre like "_Horror_";
Update top_1000_highest_grossing_movies_of_all_time
set comedy=1 where Genre like "_Comedy_";
Update top_1000_highest_grossing_movies_of_all_time
set romance=1 where Genre like "_Romance_";
Update top_1000_highest_grossing_movies_of_all_time
set sci_fi=1 where Genre like "_Sci_";
Update top_1000_highest_grossing_movies_of_all_time
set drama=1 where Genre like "_Drama_";

Select * from top_1000_highest_grossing_movies_of_all_time
where comedy=1;

Update top_1000_highest_grossing_movies_of_all_time
set Action=ifnull(Action,0);
Update top_1000_highest_grossing_movies_of_all_time
set comedy=ifnull(comedy,0);
Update top_1000_highest_grossing_movies_of_all_time
set horror=ifnull(horror,0);
Update top_1000_highest_grossing_movies_of_all_time
set romance=ifnull(romance,0);
Update top_1000_highest_grossing_movies_of_all_time
set sci_fi=ifnull(sci_fi,0);
Update top_1000_highest_grossing_movies_of_all_time
set drama=ifnull(drama,0);

select sum(Action) ,sum(comedy), sum(romance), sum(horror),sum(sci_fi) from top_1000_highest_grossing_movies_of_all_time;
-- convert duration into hours format
select concat(cast(floor(Duration/60) as char),"hr ",cast(Duration%60 as char),"mins") as duration from top_1000_highest_grossing_movies_of_all_time;

Alter table top_1000_highest_grossing_movies_of_all_time
add MovieLength text;
Update top_1000_highest_grossing_movies_of_all_time
set MovieLength=concat(cast(floor(Duration/60) as char),"hr ",cast(Duration%60 as char),"mins");

-- convert gross & worldwide lifetime gross into numerical column
update `top_1000_highest_grossing_movies_of_all_time`
set Gross=replace(Gross,'$','');
update `top_1000_highest_grossing_movies_of_all_time`
set Gross=replace(Gross,'M','');

update `top_1000_highest_grossing_movies_of_all_time`
set Gross=NULL
where Gross like "%*%";
alter table `top_1000_highest_grossing_movies_of_all_time`
modify Gross integer;

alter table `top_1000_highest_grossing_movies_of_all_time`
change GrossM Gross_M integer;

update `top_1000_highest_grossing_movies_of_all_time`
set `Worldwide LT Gross`=replace(`Worldwide LT Gross`,'$','');
update `top_1000_highest_grossing_movies_of_all_time`
set `Worldwide LT Gross`=replace(`Worldwide LT Gross`,',','');

update `top_1000_highest_grossing_movies_of_all_time`
set `Worldwide LT Gross`=NULL
where `Worldwide LT Gross` like "%*%";
alter table `top_1000_highest_grossing_movies_of_all_time`
modify `Worldwide LT Gross` Bigint;

-- Convert votes into categorical data format

update `top_1000_highest_grossing_movies_of_all_time`
set Votes=replace(Votes,',','');

select distinct length(Votes) from `top_1000_highest_grossing_movies_of_all_time`;

Alter table `top_1000_highest_grossing_movies_of_all_time`
Add (Votes_cat text); 

Update `top_1000_highest_grossing_movies_of_all_time`
set Votes_cat=(case when length(Votes)=7 then "High"
					when length(Votes)=6 then "Adequate"
                    when length(Votes)=5 then "Satisfactory"
                    when length(Votes)=4 then "Low"
                    when length(Votes)<4 then "Unconsiderable"
				end);


-- Drop useless columns
Alter table `top_1000_highest_grossing_movies_of_all_time`
drop column `Movie Title`,
drop column `Year of Realease`,
drop column Genre,
drop column Votes,
drop column Logline;




