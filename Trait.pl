/*Begin Question 4.1*/
divisible(X,Y)
 :- N is Y*Y,
    N =< X,
    X mod Y =:= 0.
divisible(X,Y)
 :- Y < X,
    Y1 is Y+1,
    divisible(X,Y1).

prime(X)
 :- Y is 2, X > 1, 
    \+ divisible(X,Y).

/*End Question 4.1*/

/*Begin Question 4.2*/
/* Filters each permutation, by checking if X, Y, Z exist within the correct
 * bounds*/
possible( X, Y, Z )
  :- permutation([1,2,3,4,5,6,7,8,9], GRID),
     combine(GRID, A, B, C),
     A > 123,
     A < 180,
     B > 181,
     B < 270,
     C > 270,
     C < 360,
     X is A,
     Y is B,
     Z is C.
    
    
/* Turn array into three numbers */
combine([A, B, C, D, E, F, G, H, I], X, Y, Z)
  :- X is (A * 100) + (B * 10) + C,
     Y is (D * 100) + (E * 10) + F,
     Z is (G * 100) + (H * 10) + I.
    
/* Bounds
 * 
 *  X - 123 - 179
 *  Y - 182 - 269
 *  Z - 271 - 359
 *  */
    
/* Reuses permutation function from last question, but filters the 
 * results generated*/  
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


    
/* Generate permutations, for each permutation, turn into three numbers */
    
/*End Question 4.2*/

/*Begin Question 4.3*/
acceptable( X, Y, Z ) 
  :- /* Checks all the values are not prime */
     not(prime(X)),
     not(prime(Y)),
     not(prime(Z)),
     /* Checks all the numbers are unique */
     unique_digits(X, Y, Z).
  
/* Converts numbers into a list, and then checks all numbers are unique*/
unique_digits( X, Y, Z)
 :- numberToList(X, X1),
    numberToList(Y, Y1),
    numberToList(Z, Z1),
    append(X1, Y1, V),
    append(V, Z1, V1),
    check_unique(V1).
    
/* Turns a number into a list, does reverse the list,
 * but doesn't really matter for the predicates purpose*/
numberToList(X,[L|[]]):-
   X < 10,
   L is X,
   !.
numberToList(X,L):-
   P is X // 10,
   numberToList(P,L1),
   E is (X mod 10), 
   append(L1,[E] ,L).

/* Checks every element of the list is unique */
check_unique([]).
check_unique([H|T])
 :- not(member(H, T)),
    check_unique(T).

/* Generates a possible, checks its acceptable if it is output it
 * NOTE - FOR TRAIT PREDICATE YOU MUST PRESS THE NEXT BUTTON 
 * TO SEE ALL THE OUTPUTS*/
trait( X, Y, Z )
  :- possible(A, B, C),
     acceptable(A, B, C),
     X is A,
     Y is B,
     Z is C.

/*End Question 4.3*/

/* Test Functions */
/* Used to format the output of trait */
create_list(X, Y, Z, [X,Y,Z]).
