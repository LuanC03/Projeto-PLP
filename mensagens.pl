:- module(mensagens,[selecione/0,acertou/0,errou/0,invalido/0,selecaoInvalida/0,misseis/1,ultimoMissel/0,misseisEsgotados/0,gameOver/0,vitoria/0]).

acertou :-
  write('ACERTOU!'), nl.

errou :-
  write('ERROU!'), nl.

invalido :-
  write('VOCÊ JA ATIROU AQUI!'), nl.

selecione :-
  write('SELECIONE AS COORDENADAS DO SEU TIRO.'), nl.

selecaoInvalida :-
  write('COORDENADAS INVÁLIDAS!'), nl.

misseis(Qtd) :-
  write('Você ainda tem '), write(Qtd), write(' mísseis.'), nl, nl.

ultimoMissel :-
  write('Resta apenas um míssel!'), nl, nl.

misseisEsgotados :-
  write('Seus mísseis acabaram!'), nl, nl.
gameOver :-
  write('---------------------------------------------------'), nl,
  write('O Mundo acabou'), nl,
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write(' VOCE CONSEGUIU DESTRUIR TODAS AS BASES INIMIGAS!
                    VOCE SALVOU O MUNDO <3 '), nl,
  write('---------------------------------------------------').
/* Impressões simples */
