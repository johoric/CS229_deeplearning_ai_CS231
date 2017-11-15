/*******************************************************************
Running the predicate "sudoku" solves the puzzle specified by the
predicate "puzzle". The solution is a list of triples of the form

[X,Y,N] where:
    X = row number
    Y = column number
    C = cell content, an integer
                                                                   */
sudoku :-
	puzzle(P),
	solve(P,S),
	writeout(1,S).

/******************************************************************
"solve" finds a solution to a solveable sudoku puzzle. If the
puzzle contains just one cell with a signal assignable value, then
the solution is found. Otherwise, one of the assignable values for
the first cell of the puzzle is assigned to that cell, and a
solution found for a reduced puzzle.
                                                                   */
solve([[1,[C],X,Y,_]],[[X,Y,C]]).
solve([[_,C,X,Y,Z]|Rest],[[X,Y,Pick]|Solved]) :-
	member(Pick,C,_),
	reduce([Pick,X,Y,Z],Rest,Reduced),
	solve(Reduced,Solved).

/******************************************************************
"reduce" reduces a puzzle by deleting a value from the lists of
assignable values of all cells in a particular row, column and
3x3 region.
                                                                   */
reduce(Pivot,[Cell],[NewCell]) :-
	eliminate(Pivot,Cell,NewCell).
reduce(Pivot,[Cell|Rest],[P,F|Rem]) :-
	eliminate(Pivot,Cell,[N1|R1]), !,
	reduce(Pivot,Rest,[[N2|R2]|Rem]),
	( N1<N2, P=[N1|R1], F=[N2|R2]      /* Note the syntax here for  */
	; P=[N2|R2], F=[N1|R1] ),          /* an embedded "or", which   */
	!.                                 /* makes it unnecessary to   */
                                           /* introduce a predicate     */
                                           /* that would be used only   */
                                           /* once.                     */

/******************************************************************
"eliminate" deletes a value from the list of assignable values of a
cell in a particular row, column or 3x3 region.
                                                                   */
eliminate([C|P],[N1,C1|P1],[N2,C2|P1]) :-
	comparable(P,P1),
	member(C,C1,C2),
	N2 is N1-1.
eliminate(_,Cell,Cell).

/******************************************************************
"comparable" tests whether two cell locations are in the same row (X),
column (Y) or 3x3 region (Z).
                                                                   */
comparable([X,_,_],[X,_,_]) :- !.
comparable([_,Y,_],[_,Y,_]) :- !.
comparable([_,_,Z],[_,_,Z]).

/******************************************************************
"member" is the standard list membership predicate.
"writeout" writes out a Sudoku solution.
                                                                   */
member(X,[X|R],R).
member(X,[Y|R1],[Y|R2]) :-
	member(X,R1,R2).

writeout(10,_).
writeout(R,S) :-
	row(R,1,S,S1),
	R1 is R+1,
	writeout(R1,S1).

row(_,10,S,S) :- nl.row(R,C,S,S2) :-
	member([R,C,N],S,S1),
	write(' '), write(N),
	C1 is C+1,
	row(R,C1,S1,S2).

/**********************************************************************
The predicate "puzzle" specifies a Sudoku puzzle as a list of 5-tuples
of the form [N,C,X,Y,Z], each corresponding to an empty cell in
the Sudoku grid, where:
    N = the number of digits that could be assigned to this cell
    C = list of digits that could be assigned to this cell
    X = row number
    Y = column number
    Z = the 3x3 square in which the cell lies (an integer from 0 to 8)
                                                                      */

puzzle([[1,[9],1,1,0],
	[1,[7],1,9,6],
	[1,[3],2,4,3],
	[1,[4],2,8,6],
	[1,[5],2,9,6],
	[1,[4],3,2,0],
	[1,[8],3,4,3],
	[1,[3],3,7,6],
	[1,[9],3,8,6],
	[1,[8],4,1,1],
	[1,[3],4,6,4],
	[1,[4],4,7,7],
	[1,[7],5,2,1],
	[1,[5],5,5,4],
	[1,[2],5,8,7],
	[1,[4],6,3,1],
	[1,[2],6,4,4],
	[1,[1],6,9,7],
	[1,[1],7,2,2],
	[1,[2],7,3,2],
	[1,[9],7,6,5],
	[1,[6],7,8,8],
	[1,[6],8,1,2],
	[1,[8],8,2,2],
	[1,[1],8,6,5],
	[1,[5],9,3,2],
	[1,[4],9,9,8],
	[9,[1,2,3,4,5,6,7,8,9],1,2,0],
	[9,[1,2,3,4,5,6,7,8,9],1,3,0],
	[9,[1,2,3,4,5,6,7,8,9],1,4,3],
	[9,[1,2,3,4,5,6,7,8,9],1,5,3],
	[9,[1,2,3,4,5,6,7,8,9],1,6,3],
	[9,[1,2,3,4,5,6,7,8,9],1,7,6],
	[9,[1,2,3,4,5,6,7,8,9],1,8,6],
	[9,[1,2,3,4,5,6,7,8,9],2,1,0],
	[9,[1,2,3,4,5,6,7,8,9],2,2,0],
	[9,[1,2,3,4,5,6,7,8,9],2,3,0],
	[9,[1,2,3,4,5,6,7,8,9],2,5,3],
	[9,[1,2,3,4,5,6,7,8,9],2,6,3],
	[9,[1,2,3,4,5,6,7,8,9],2,7,6],
	[9,[1,2,3,4,5,6,7,8,9],3,1,0],
	[9,[1,2,3,4,5,6,7,8,9],3,3,0],
	[9,[1,2,3,4,5,6,7,8,9],3,5,3],
	[9,[1,2,3,4,5,6,7,8,9],3,6,3],
	[9,[1,2,3,4,5,6,7,8,9],3,9,6],
	[9,[1,2,3,4,5,6,7,8,9],4,2,1],
	[9,[1,2,3,4,5,6,7,8,9],4,3,1],
	[9,[1,2,3,4,5,6,7,8,9],4,4,4],
	[9,[1,2,3,4,5,6,7,8,9],4,5,4],
	[9,[1,2,3,4,5,6,7,8,9],4,8,7],
	[9,[1,2,3,4,5,6,7,8,9],4,9,7],
	[9,[1,2,3,4,5,6,7,8,9],5,1,1],
	[9,[1,2,3,4,5,6,7,8,9],5,3,1],
	[9,[1,2,3,4,5,6,7,8,9],5,4,4],
	[9,[1,2,3,4,5,6,7,8,9],5,6,4],
	[9,[1,2,3,4,5,6,7,8,9],5,7,7],
	[9,[1,2,3,4,5,6,7,8,9],5,9,7],
	[9,[1,2,3,4,5,6,7,8,9],6,1,1],
	[9,[1,2,3,4,5,6,7,8,9],6,2,1],
	[9,[1,2,3,4,5,6,7,8,9],6,5,4],
	[9,[1,2,3,4,5,6,7,8,9],6,6,4],
	[9,[1,2,3,4,5,6,7,8,9],6,7,7],
	[9,[1,2,3,4,5,6,7,8,9],6,8,7],
	[9,[1,2,3,4,5,6,7,8,9],7,1,2],
	[9,[1,2,3,4,5,6,7,8,9],7,4,5],
	[9,[1,2,3,4,5,6,7,8,9],7,5,5],
	[9,[1,2,3,4,5,6,7,8,9],7,7,8],
	[9,[1,2,3,4,5,6,7,8,9],7,9,8],
	[9,[1,2,3,4,5,6,7,8,9],8,3,2],
	[9,[1,2,3,4,5,6,7,8,9],8,4,5],
	[9,[1,2,3,4,5,6,7,8,9],8,5,5],
	[9,[1,2,3,4,5,6,7,8,9],8,7,8],
	[9,[1,2,3,4,5,6,7,8,9],8,8,8],
	[9,[1,2,3,4,5,6,7,8,9],8,9,8],
	[9,[1,2,3,4,5,6,7,8,9],9,1,2],
	[9,[1,2,3,4,5,6,7,8,9],9,2,2],
	[9,[1,2,3,4,5,6,7,8,9],9,4,5],
	[9,[1,2,3,4,5,6,7,8,9],9,5,5],
	[9,[1,2,3,4,5,6,7,8,9],9,6,5],
	[9,[1,2,3,4,5,6,7,8,9],9,7,8],
	[9,[1,2,3,4,5,6,7,8,9],9,8,8]]).