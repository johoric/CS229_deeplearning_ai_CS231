/**************************************************
Note:This part is taken from
	Prolog: Programming for Artificial Intelligence
	by Ivan Bratko
**************************************************/
sum( [], [], [], C, C, Digits, Digits).
sum( [D1|N1], [D2|N2], [D|N], C1, C, Digs1, Digs) :-
	sum( N1, N2, N, C1, C2, Digs1, Digs2),
	digitsum( D1, D2, C2, D, C, Digs2, Digs).

digitsum( D1, D2, C1, D, C, Digs1, Digs) :-
	del_var( D1, Digs1, Digs2),
	del_var( D2, Digs2, Digs3),
	del_var( D, Digs3, Digs),
	S  is  D1 + D2 + C1,
	D  is  S mod 10,
	C  is  S // 10.


del_var( A, L, L) :- nonvar(A), !.
del_var( A, [A|L], L).
del_var( A, [B|L], [B|L1]) :-
	del_var(A, L, L1).


/***************************************************
Find the max in a list.



***************************************************/
slow_max(L, Max) :-
	select(Max, L, Rest), \+ (member(E, Rest), E > Max).


/***************************************************
Give a X,bulid a List with n X.
***************************************************/
build(X, N, List) :-
	findall(X, between(1, N, _), List).


/***************************************************
Solve the symbolic addition puzzle
Example:
    solve([[E,A,T],[M,O,R,E],[E,G,G,S]]).
    solve([[S,E,N,D],[M,O,R,E],[M,O,N,E,Y]]).
    solve([[T,R,Y],[T,O],[F,L,Y]]).
    solve([[E,A,T],[M,O,R,E],[F,I,S,H]]).
    solve([[W,A,S,H],[D,R,Y],[I,R,O,N]]).
    solve([[E,A,T],[N,O],[F,A,T]]).
    solve([[B,R,I,N,G],[H,O,M,E],[B,A,C,O,N]]).
    solve([[W,E,A,R],[O,L,D],[S,H,O,E,S]]).
    solve([[S,E,M,P,E,R],[U,B,I],[S,U,B,U,B,I]]).
    solve([[E,A,T],[M,O,R,E],[F,R,U,I,T]]).
***************************************************/
solve([N1, N2, N3]) :-
	length(N1, Len1),
	length(N2, Len2),
	length(N3, Len3),
	slow_max([Len1, Len2, Len3], Max),
	X1 is Max - Len1,
	build(0, X1, Zero_list1),
	append(Zero_list1, N1, N4),%append zero
	X2 is Max - Len2,
	build(0, X2, Zero_list2),
	append(Zero_list2, N2, N5),
	X3 is Max - Len3,
	build(0, X3, Zero_list3),
	append(Zero_list3, N3, N6),
	sum( N4, N5, N6, 0, 0, [0,1,2,3,4,5,6,7,8,9], _).
