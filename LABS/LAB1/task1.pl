% ���������� ����������� ���������� ��������� �������

% ����� ������
% (������, �����)
my_length([], 0).
my_length([_|L], N):-my_length(L, M), N is M + 1.

% �������������� �������� ������
% (�������, ������)
my_member(X, [X|_]).
my_member(X, [_|T]):-my_member(X, T).

% ������e����� �������
% (������1, ������2, ������1+2)
my_append([], L, L).
my_append([X|L1], L2, [X|L3]):-my_append(L1, L2, L3).

% �������� �������� �� ������
% (�������, ������, ������ ��� ��������)
my_remove(X, [X|T], T).
my_remove(X, [Y|T], [Y|Z]):-my_remove(X, T, Z).

% ������������ ��������� � ������
% (������, ������������)
my_permute([], []).
my_permute(L, [X|T]):-my_remove(X, L, Y), my_permute(Y, T).

% ��������� ������
% (���������, ������)
my_sublist(S, L):-my_append(_, L1, L), my_append(S, _, L1).

%var2
%�������� ���������� �������� � �������������� ����������� ����������
remove_last_std(L1, L2):-append(L2, [_], L1).

%�������� ���������� �������� ��� ������������� ����������� ����������
remove_last([_],[]):-!.
remove_last([X|Y],[X|Z]):-remove_last(Y,Z).%��������

%var7
%�������� ��������������� ��������� �� �����������

is_grow_ordered([_]).
is_grow_ordered([L1,L2|R]) :- L2>=L1, is_grow_ordered([L2|R]).

%������ ����������� ������������� ����������
% �������� ���������� �������� � �������� �� ��������������� ��
% ����������� (�������, ������)
is_new_grow_ordered(L1):- remove_last(L1,L2), is_grow_ordered(L2).



