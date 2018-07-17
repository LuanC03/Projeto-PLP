/* Impressões de avisos */

acertou :-
  write('ACERTOU!'), nl.

errou :-
  write('ERROU!'), nl.

invalido :-
  write('Você já atirou aqui! Atire em outro lugar.'), nl.

/* Fim do jogo */

gameOver :-
  write('---------------------------------------------------'), nl,
  write('Voce nao foi capaz de destruir as bases inimigas a tempo.'), nl,
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write('Você destruiu todas as bases inimiga e conseguiu SALVAR O MUNDO!'), nl,
  write('---------------------------------------------------').

/* Criação do tabuleiro */

gerarTabuleiro([[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~]]).

imprimeTabuleiroJogador(Tabuleiro) :-
  write(' ###   bombardment of the virus  ###'),nl,nl,
  write('    A   B   C   D   E   F   G   H   I'),nl,nl,
  imprimeMatrizJogador(Tabuleiro, 0),
  write('_ = Terreno | X = TIRO PERDIDO'), nl, nl.

imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index), write('  '), imprimeLinhaJogador(H), nl,nl,
    NewIndex is Index+1,
    imprimeMatrizJogador(T, NewIndex).

imprimeLinhaJogador([]).
imprimeLinhaJogador([H|T]) :-
  (H == '~', write('|_|');
  H == n, write('~');
  H == x, write('x')), write(' '),
  imprimeLinhaJogador(T).

:- initialization(main).
main :-
  gerarTabuleiro(TabuleiroRamdomicoAux),
   imprimeTabuleiroJogador(TabuleiroRamdomicoAux).
