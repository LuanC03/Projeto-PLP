:- module(exibicao, [imprimeTabuleiroJogador /1, imprimeMatrizJogador /2, imprimeLinhaJogador /1, imprimeTabuleiroReal /1, imprimeLinhas /2, imprimeLinha /1, inserir_numero /2]).

/* EXIBIÇÃO */

/* Impressão da visão que o jogador tem doh tabuleiro, omitindo navios */

imprimeTabuleiroJogador(Tabuleiro) :-
  write('############ BOMBARDMENT OF THE VIRUS ###########'),nl,nl,
  write('    A   B   C   D   E   F   G   H   I   J   L   M'),nl,nl,
  imprimeMatrizJogador(Tabuleiro, 0),
  writeln('~ = Terreno | n = Area | X = TIRO PERDIDO').

imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index), write('  '), imprimeLinhaJogador(H), nl,nl,
    NewIndex is Index+1,
    imprimeMatrizJogador(T, NewIndex).

imprimeLinhaJogador([]).
imprimeLinhaJogador([H|T]) :-
  (H == '~', write('|_|');
  H == n, write('|_|');
  H == b, write('|_|');
  H == a, write('|_|');
  H == @, write('|_|');
  H == &, write('')), write(' '),
  imprimeLinhaJogador(T).

imprimeTabuleiroReal(Tabuleiro) :-
  write('############ BOMBARDMENT OF THE VIRUS ###########'),nl,nl,
  write('    A   B   C   D   E   F   G   H   I   J   L   M'),nl,nl,
  imprimeLinhas(Tabuleiro, 0),
  writeln('~ = Terreno | n = Area | X = TIRO PERDIDO').

imprimeLinhas([],_).
imprimeLinhas([H|T],Index) :-
	write(Index), write('  '), imprimeLinha(H), nl,nl,
	NewIndex is Index+1,
	imprimeLinhas(T,NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-
	write(H), write('  '),
	imprimeLinha(T).

/* Imprime uma mensagem na tela e lê um número da entrada */
inserir_numero(Prompt, Numero) :-
  write(Prompt),
  write(': '),
  read(Numero).