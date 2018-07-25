:- module(mensagens,[selecione/0,acertou/0,errou/0,invalido/0,selecaoInvalida/0,misseis/1,ultimoMissel/0,misseisEsgotados/0,gameOver/0,vitoria/0]).

acertou :-
  write('ACERTOU!'), nl.
/* Predicado para informar ao usuário que ele acertou uma estrutura */

errou :-
  write('ERROU!'), nl.
/* Predicado para informar ao usuário que ele não acertou nenhuma estrutura */

invalido :-
  write('VOCÊ JA ATIROU AQUI!'), nl.
/* Predicado para quando o usuário atirar em um local já selecionado anteriormente */

selecione :-
  write('SELECIONE AS COORDENADAS DO SEU TIRO.'), nl.

selecaoInvalida :-
  write('COORDENADAS INVÁLIDAS!'), nl.

misseis(Qtd) :-
  write('VOCÊ AINDA TEM '), write(Qtd), write(' MÍSSEIS.'), nl, nl.
/* Predicado para informar a quantidade de mísseis disponíveis */

ultimoMissel :-
  write('RESTA APENAS UM MÍSSEL!'), nl, nl.

misseisEsgotados :-
  write('SEUS MÍSSEIS ACABARAM!'), nl, nl.

gameOver :-
  write('---------------------------------------------------'), nl,
  write('O MUNDO ACABOU!'), nl,
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write(' VOCE CONSEGUIU DESTRUIR TODAS AS BASES INIMIGAS!
                    VOCE SALVOU O MUNDO <3 '), nl,
  write('---------------------------------------------------').
