% var 2

% “ри миссионера и три каннибала хот€т переправитьс€ с левого берега реки на правый.
%  ак это сделать за минимальное число шагов, если в их распор€жении имеетс€ трехместна€ лодка
% и ни при каких обсто€тельствах (в лодке или на берегу) миссионеры не должны оставатьс€ в меньшинстве.

% –ешение
% [K, K, K, M, M, M], []
% 1) KM ->
% [K, K, M, M], [K, M]
% 2) M <-
% [K, K, M, M, M], [K]
% 3) KMM ->
% [K, M], [K, K, M, M]
% 4) KM <-
% [K, K, M, M], [K, M]
% 5) KMM ->
% [K], [K, K, M, M, M]
% 6) M <-
% [K, M], [K, K, M, M]
% 7) KM ->
% [], [K, K, K, M, M, M]

count_k(L, N):-
	delete(L, 'm', L1),
	length(L1, M), N is M.

count_m(L, N):-
	delete(L, 'k', L1),
	length(L1, M), N is M.

balance(L):-
	count_m(L, X),
	count_k(L, Y),
	(X >= Y; X == 0).

sort_items(A, B):-
	append(Begin, ['m', 'k' | Tail], A),
	append(Begin, ['k', 'm' | Tail], C),
	sort_items(C, B);
	append(A, [], B).

move([H|_],Res):-
    move(H,Res).

% KM ->
move(st(A), st(B)):-
	append(Left, ['>' | Right], A),
	append(Begin, ['k', 'm' | Tail], Left),
	append(Right, ['k', 'm'], Right2),
	balance(Right2),
	sort_items(Right2, RightSorted),
	append(Begin, Tail, L),
	balance(L),
	append(L, ['<'], L1),
	append(L1, RightSorted, B).

% KMM ->
move(st(A), st(B)):-
	append(Left, ['>' | Right], A),
	append(Begin, ['k', 'm', 'm' | Tail], Left),
	append(Right, ['k', 'm', 'm'], Right2),
	balance(Right2),
	sort_items(Right2, RightSorted),
	append(Begin, Tail, L),
	balance(L),
	append(L, ['<'], L1),
	append(L1, RightSorted, B).

% M <-
move(st(A), st(B)):-
	append(Left, ['<' | Right], A),
	append(Begin, ['m' | Tail], Right),
	append(['m'], Left, Left2),
	balance(Left2),
	sort_items(Left2, LeftSorted),
	append(Begin, Tail, R),
	balance(R),
	append(['>'], R, R1),
	append(LeftSorted, R1, B).

% KM <-
move(st(A), st(B)):-
	append(Left, ['<' | Right], A),
	append(Begin, ['k', 'm' | Tail], Right),
	append(['k', 'm'], Left, Left2),
	balance(Left2),
	sort_items(Left2, LeftSorted),
	append(Begin, Tail, R),
	balance(R),
	append(['>'], R, R1),
	append(LeftSorted, R1, B).

% ѕечать решени€

inv_print([]).
inv_print([A|T]):-inv_print(T), write(A), nl.

% ѕродление путей графа

prolong([X|T],[Y,X|T]):-
    move(X,Y),
    \+ member(Y,[X|T]).

% ѕоиск в глубину
search_dpth(A,B):-
    write('DFS START'), nl,
    get_time(DFS),
    dpth([A],B,L),
    inv_print(L),
    get_time(DFS1),
    write('DFS END'), nl, nl,
    T1 is DFS1 - DFS,
    write('TIME IS '), write(T1), nl, nl,!.


dpth([X|T],X,[X|T]).
dpth(P,F,L):-
    prolong(P,P1),
    dpth(P1,F,L).

% ѕоиск в ширину
search_bdth(X,Y):-
    write('BFS START'), nl,
    get_time(BFS),
    bdth([[X]],Y,L),
    inv_print(L),
    get_time(BFS1),
    write('BFS END'), nl, nl,
    T1 is BFS1 - BFS,
    write('TIME IS '), write(T1), nl, nl,!.

bdth([[X|T]|_],X,[X|T]).
bdth([P|QI],X,R):-
    findall(Z,prolong(P,Z),T),
    append(QI,T,Q0),
    bdth(Q0,X,R).

bdth([_|T],Y,L):-
    bdth(T,Y,L).

% ѕоиск с итерационным заглублением
int(1).
int(N):- int(M), N is M + 1.

iter_search(Start, Finish):-
	write('ITER START'), nl,
	get_time(ITER),
	int(Level),
	(
		Level > 100, !;
		id([Start], Finish, Way, Level), inv_print(Way)
	),
	 get_time(ITER1),
	 write('ITER END'), nl, nl,
	 T1 is ITER1 - ITER,
	 write('TIME IS '), write(T1), nl, nl,!.

id([Finish | Tail], Finish, [Finish | Tail], 0).
id(TempWay, Finish, Way, N):-
	N > 0,
	prolong(TempWay, NewWay),
	N1 is N - 1,
	id(NewWay, Finish, Way, N1).
