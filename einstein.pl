same_position(X, Y, Lx, Ly) :-
    nth0(I, Lx, X), nth0(I, Ly, Y).

left_of(X, Y, Lx, Ly) :-
    nth0(Ix, Lx, X), Iy is Ix + 1, nth0(Iy, Ly , Y).

right_of(X, Y, Lx, Ly) :-
    nth0(Ix, Lx, X), Iy is Ix - 1, nth0(Iy, Ly, Y).

adjacent(X, Y, Lx, Ly) :-
    left_of(X, Y, Lx, Ly).
adjacent(X, Y, Lx, Ly) :-
    right_of(X, Y, Lx, Ly).

'The Brit lives in the Red house'(Nationalities, Colors) :-
    same_position(brit, red, Nationalities, Colors).

'The Swede keeps dogs as pets'(Nationalities, Pets) :-
    same_position(swede, dogs, Nationalities, Pets).

'The Dane drinks tea'(Nationalities, Drinks) :-
    same_position(dane, tea, Nationalities, Drinks).

'The Green house is next to the White house, on the left'(Colors) :-
    left_of(green, white, Colors, Colors).

'The owner of the Green house drinks coffee'(Colors, Drinks) :-
    same_position(green, coffee, Colors, Drinks).

'The person who smokes Pall Mall rears birds'(Cigarettes, Pets) :-
    same_position(pallmall, birds, Cigarettes, Pets).

'The owner of the Yellow house smokes Dunhill'(Colors, Cigarettes) :-
    same_position(yellow, dunhill, Colors, Cigarettes).

'The man living in the centre house drinks milk'([_, _, milk, _, _]).

'The Norwegian lives in the first house'([norwegian, _, _, _, _]).

'The man who smokes Blends lives next to the one who keeps cats'(Cigarettes, Pets) :-
    adjacent(blends, cats, Cigarettes, Pets).

'The man who keeps horses lives next to the man who smokes Dunhill'(Pets, Cigarettes) :-
    adjacent(horses, dunhill, Pets, Cigarettes).

'The man who smokes Blue Master drinks beer'(Cigarettes, Drinks) :-
    same_position(bluemaster, beer, Cigarettes, Drinks).

'The German smokes Prince'(Nationalities, Cigarettes) :-
    same_position(german, prince, Nationalities, Cigarettes).

'The Norwegian lives next to the Blue house'(Nationalities, Colors) :-
    adjacent(norwegian, blue, Nationalities, Colors).

'The man who smokes Blends has a neighbour who drinks water'(Cigarettes, Drinks) :-
    adjacent(blends, water, Cigarettes, Drinks).

'Someone has fish'(Pets) :-
    nth1(I, Pets, Fish),
    var(Fish),
    nth1(I, Pets, fish).

solve([Nationalities, Colors, Drinks, Cigarettes, Pets]) :-
    length(Colors, 5), length(Nationalities, 5), length(Drinks, 5), length(Cigarettes, 5), length(Pets, 5),
    'The Brit lives in the Red house'(Nationalities, Colors),
    'The Swede keeps dogs as pets'(Nationalities, Pets),
    'The Dane drinks tea'(Nationalities, Drinks),
    'The Green house is next to the White house, on the left'(Colors),
    'The owner of the Green house drinks coffee'(Colors, Drinks),
    'The person who smokes Pall Mall rears birds'(Cigarettes, Pets),
    'The owner of the Yellow house smokes Dunhill'(Colors, Cigarettes),
    'The man living in the centre house drinks milk'(Drinks),
    'The Norwegian lives in the first house'(Nationalities),
    'The man who smokes Blends lives next to the one who keeps cats'(Cigarettes, Pets),
    'The man who keeps horses lives next to the man who smokes Dunhill'(Pets, Cigarettes),
    'The man who smokes Blue Master drinks beer'(Cigarettes, Drinks),
    'The German smokes Prince'(Nationalities, Cigarettes),
    'The Norwegian lives next to the Blue house'(Nationalities, Colors),
    'The man who smokes Blends has a neighbour who drinks water'(Cigarettes, Drinks),
    'Someone has fish'(Pets).

solve_and_present(Solution) :-
    use_module(library(clpfd)),
    solve(Y),
    transpose(Y, Solution).

has_fish(X) :-
    solve([Nationalities, _, _, _, Pets]),
    nth1(I, Pets, fish),
    nth1(I, Nationalities, X).