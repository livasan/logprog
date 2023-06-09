﻿/* country(Id, Name, World, Population). */

country(1,"Egypt",africa,80).
country(2,"China",asia,1411).
country(3,"England",europe,336).

/*capital(Id, Name, Population).*/

capital(1,"Cairo",10).
capital(2,"Beijing",21).
capital(3, "London",9).

/* present(Id_capital, Id_country). */

present(1, 1).
present(2, 2).
present(3, 3)..

/* ethnicity(Id_ethnicity,Name). */

ethnicity(1,"Egyptians").
ethnicity(3,"Chinese").
ethnicity(4,"Briton").

/* lives_here(Id_country,Id_ethnicity). */
lives_here(1,1).
lives_here(2,1).
lives_here(2,2).
lives_here(3,3).



find_capital(Capital,World) :-
    capital(Id_Capital,Capital,_),
    country(Id_Country,_,World,_),
    present(Id_Capital,Id_Country).

find_world(Id_Capital,World) :-
    capital(Id_Capital,Capital,_),
    country(Id_Country,_,World,_),
    present(Id_Capital,Id_Country).

find_ethnicity(World, Et_Name):-
    country(Id_country, _, World, _),
    ethnicity(Id_ethnicity,Et_Name),
    lives_here(Id_country,Id_ethnicity).

where_more(First_Id,Second_Id,Res_Id):-
    country(First_Id,First_Name,_,First_Population),
    country(Second_Id,Second_Name,_,Second_Population),
    First_Population<Second_Population,!,Res_Id is Second_Name; Res_Id is First_Name.
