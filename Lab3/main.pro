implement main
    open core, stdio, file

domains
    world = australia; africa; asia; america; europe.
    list = integer*.

class facts - worldDb
    country : (integer Id_country, string Name_country, world World, real Population_country).
    capital : (integer Id_capital, string Name_capital, real Population_capital).
    present : (integer Id_capital, integer Id_country).
    ethnicity : (integer Id_ethnicity, string Name_ethnicity).
    lives_here : (integer Id_country, integer Id_ethnicity).
    list : (integer*).
    %sum_list : (list A, integer Z).

class predicates
    find_capital : (string Name_capital, world World) nondeterm anyflow.
    find_world : (integer Id_capital, world World) nondeterm anyflow.
    find_ethnicity : (world World, string Name_ethnicity) nondeterm anyflow.
    printCountry : () nondeterm anyflow.
    migration : (real H) nondeterm anyflow.
    sum_list : (list List, integer Sum) nondeterm anyflow.

clauses
    find_capital(Name_capital, World) :-
        capital(Id_capital, Name_capital, _),
        country(Id_country, _, World, _),
        present(Id_capital, Id_country).

    find_world(Id_capital, World) :-
        capital(Id_capital, _, _),
        country(Id_country, _, World, _),
        present(Id_capital, Id_country).

    find_ethnicity(World, Name_ethnicity) :-
        country(Id_country, _, World, _),
        ethnicity(Id_ethnicity, Name_ethnicity),
        lives_here(Id_country, Id_ethnicity).

    migration(H) :-
        retract(country(Id_country, Name_country, World, Population_country)),
        asserta(country(Id_country, Name_country, World, Population_country + H)),
        fail.
    migration(_).

    printCountry() :-
        country(_, Name_country, _, Population_country),
        write(Name_country, ":\t", Population_country, " million people"),
        nl,
        fail.
    printCountry() :-
        write("All countries are shown above\n").

    sum_list([], 0) :-
        !.

    sum_list([Head | Tail], Sum) :-
        sum_list(Tail, TailSum),
        Sum = Head + TailSum.

clauses
    run() :-
        console::init(),
        reconsult("../clouses.txt", worldDb),
        fail.
    run() :-
        find_capital(Name_capital, World),
        stdio::write(Name_capital, " is in ", World, "\n"),
        fail.

    run() :-
        find_world(Id_capital, World),
        stdio::write(Id_capital, " is for ", World, "\n"),
        fail.

    run() :-
        find_ethnicity(World, Name_ethnicity),
        stdio::write(Name_ethnicity, " is in ", World, "\n"),
        fail.
    run() :-
        printCountry(),
        stdio::write(" Enter a number of migrarion:  "),
        X = stdio::readLine(),
        migration(toTerm(X)),
        printCountry(),
        stdio::write(X, " million have migrated", "\n"),
        fail.
    run() :-
        List =
            [ Pop ||
                country(_, _, _, Pop),
                Pop > 100
            ],
        write(List),
        !.

    run() :-
        stdio::write("End test\n").

end implement main

goal
    console::runUtf8(main::run).
