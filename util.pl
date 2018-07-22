:- module(util, [acertou /0,errou /0,invalido /0,selecione /0,selecaoInvalida /0,misseis /1,ultimoMissel /0,misseisEsgotados/0,gameOver /0,vitoria /0]).

/* Impressões simples */

acertou :-
  write('ACERTOU!'), nl.

errou :-
  write('ERROU!'), nl.

invalido :-
  write('Você já atirou aqui! Atire em outro lugar.'), nl.

selecione :-
  write('Selecione as coordenadas de onde deseja atirar!'), nl.

selecaoInvalida :-
  write('Coordenadas inválidas. Tente novamente.'), nl.

misseis(Qtd) :-
  write('Você ainda tem '), write(Qtd), write(' mísseis.'), nl, nl.

ultimoMissel :-
  write('Resta apenas um míssel!'), nl, nl.

misseisEsgotados :-
  write('Seus mísseis acabaram!'), nl, nl.

gameOver :-
  write('---------------------------------------------------'), nl,
  write(' Game Over!'), nl,
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write('Você destruiu toda as Bases inimigas !! Parabéns, estrategista!'), nl,
  write('---------------------------------------------------').