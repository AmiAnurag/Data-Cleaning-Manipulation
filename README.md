# Data-Cleaning-Manipulation

## Data Manipulation on IMDB MOVIE DATA
![image](https://user-images.githubusercontent.com/76867868/197213592-44b9d057-fa7f-4853-9ab4-7e056f1f1a85.png)

### About Dataset
This Dataset displays only the top 1000 highest grossing feature films of all time as of September 5, 2022. It is in the same order as displayed on the Box Office Mojo website. SOURCE.

DATA DICTIONARY:
Movie Title: The name of the movie.
Year of Release: The year the movie was released.
Genre: Categories where the movie belongs.
Movie Rating: Ratings given by IMDb registered users (on a scale of 1 to 10)
Duration: Movie running time in minutes.
Gross: Gross earnings in U.S. dollars.
Worldwide LT Gross: Worldwide Lifetime Gross (International + Domestic totals.
Metascore: Weighted average of many reviews coming from reputed critics (on a scale of 0 to 100)
Votes: Number of votes cast by IMDb registered users.
Logline: A one or two sentence summary of the film.

### Data Manipulations
1. Change the datatype of 'Year of Realease' field into 'date' datatype
2. Introduce a new field showing how old the movie is
3. Give an unique id to each movie
4. Labelling the film based on 'genre' column
5. Convert 'Duration' column into 'Hours:HH' format
6. Convert gross & worldwide lifetime gross into numerical column by removing special charecters and charecters.
7. Convert votes into categorical data format
8. Drop useless columns

## Case Study : LCO Films data
![DALL·E 2022-10-21 19 34 29](https://user-images.githubusercontent.com/76867868/197214901-022c159d-fa72-4c49-bb43-a027f289574f.png)

Q1) Which categories of movies released in 2018? Fetch with the number of movies. 

Q2) Update the address of actor id 36 to “677 Jazz Street”.

Q3) Add the new actors (id : 105 , 95) in film  ARSENIC INDEPENDENCE (id:41).

Q4) Get the name of films of the actors who belong to India.

Q5) How many actors are from the United States?

Q6) Get all languages in which films are released in the year between 2001 and 2010.

Q7) The film ALONE TRIP (id:17) was actually released in Mandarin, update the info.

Q8) Fetch cast details of films released during 2005 and 2015 with PG rating.

Q9) In which year most films were released?

Q10) In which year least number of films were released?

Q11) Get the details of the film with maximum length released in 2014 .

Q12) Get all Sci- Fi movies with NC-17 ratings and language they are screened in.

Q13) The actor FRED COSTNER (id:16) shifted to a new address:
 055,  Piazzale Michelangelo, Postal Code - 50125 , District - Rifredi at Florence, Italy. 
Insert the new city and update the address of the actor.

Q14) A new film “No Time to Die” is releasing in 2020 whose details are : 
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

Q15) Assign the category Action, Classics, Drama  to the movie “No Time to Die” .

Q16) Assign the cast: PENELOPE GUINESS, NICK WAHLBERG, JOE SWANK to the movie “No Time to Die” .

Q17) Assign a new category Thriller  to the movie ANGELS LIFE.

Q18) Which actor acted in most movies?

Q19) The actor JOHNNY LOLLOBRIGIDA was removed from the movie GRAIL FRANKENSTEIN. How would you update that record?

Q20) The HARPER DYING movie is an animated movie with Drama and Comedy. Assign these categories to the movie.

Q21) The entire cast of the movie WEST LION has changed. The new actors are DAN TORN, MAE HOFFMAN, SCARLETT DAMON. How would you update the record in the safest way?

Q22) The entire category of the movie WEST LION was wrongly inserted. The correct categories are Classics, Family, Children. How would you update the record ensuring no wrong data is left?

Q23) How many actors acted in films released in 2017?

Q24) How many Sci-Fi films released between the year 2007 to 2017?

Q25) Fetch the actors of the movie WESTWARD SEABISCUIT with the city they live in.

Q26) What is the total length of all movies played in 2008?

Q27) Which film has the shortest length? In which language and year was it released?

Q28) How many movies were released each year?

Q29)  How many languages of movies were released each year?.


