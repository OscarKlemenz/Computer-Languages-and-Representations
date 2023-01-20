/*Begin Question 3.1*/
indices( IS, XS, ES )
  :- find_indices(IS, XS, ES).

find_indices([], _, []).
find_indices([H|T], XS, [Y|YS])
 :- nth0(H, XS, Y),
    find_indices(T, XS, YS).

/*End Question 3.1*/

/*Begin Question 3.2*/
possible( GRID )
  :- permutation([1,2,3,4,5,6,7,8,9], GRID).

    appendlist([], X, X).
appendlist([T|H], X, [T|L]) 
 :- appendlist(H, X, L).

permutation([], []).
permutation([X], [X]) 
 :-!.
permutation([T|H], X) 
 :- permutation(H, H1), 
    appendlist(L1, L2, H1), 
    appendlist(L1, [T], X1), 
    appendlist(X1, L2, X).
/*End Question 3.2*/

/*Begin Question 3.3*/
/* Checks that the sum of an array of numbers is equal to another number*/
check_sum(XS, E)
 :- sum(XS, X),
    (  X =:= E
       -> true ;  false ).

/* Adds an array of numbers together */
sum([], 0).
sum([H|T], S) 
 :- sum(T,X), 
    S is H + X.

acceptable( T0, T1, T2, T3, US, U, VS, V, WS, W, GRID)
  :- find_indices([0,1,3,4], GRID, X0),
     check_sum(X0, T0),
     find_indices([1,2,4,5], GRID, X1),
     check_sum(X1, T1),
     find_indices([3,4,6,7], GRID, X2),
     check_sum(X2, T2),
     find_indices([4,5,7,8], GRID, X3),
     check_sum(X3, T3),
     find_indices(US, GRID, U0),
     check_sum(U0, U),
     find_indices(VS, GRID, V0),
     check_sum(V0, V),
     find_indices(WS, GRID, W0),
     check_sum(W0, W).
     
suko( T0, T1, T2, T3, US, U, VS, V, WS, W, GRID)
  :- possible(GRID),
     acceptable( T0, T1, T2, T3, US, U, VS, V, WS, W, GRID).
/*End Question 3.3*/