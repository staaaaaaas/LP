%var 1
%�������, ������, �������� � ������� ������ ����������� �������
% ��������. ���� �� ��� ������, ������ ��������, ������ �����, ���������
% ��������. ������� � �������� ������ � ���� ������������� � ��� �����,
% ����� ����� ����������� � ������� ��������. ������ � �������� ������
% ���������� ���������. �������� ������� �������������� ������� �
% �������� � ���������� �������� � ��������. ������� ������� �� ������ �
% ��������. ��� ��� ����������?

solution(Persons) :-
    Persons = ['�������'-�������, '������'-������, '��������'-��������, '�������'-�������],
    permutation([_-������, _-��������, _-�����, _-��������], Persons), %������������ ��� ���� ���
    \+ ������� = �����, \+ �������� = �����, %������� � �������� �� �����
    \+ ������ = ��������, \+ ������ = ��������, %������ �� �������� � �� ��������
    \+ ������� = ��������, \+ ������� = ��������, %������� �  ������� �� ��������
    %������ �� ��������, ������� �� ��������, ������� �� �������� -> �������� ��������
    \+ member(�������, [������, ��������, ��������]).%������� �� ����� ���� ������ �������� ������, ��������, ��������, �.�. �������� ��������
%�������� �������������� ������; ������� �����; �������� ��������
