
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

resumo :-
	writeln('   No ano de 2046, um grupo de cientista conseguem terminar o maior feito'),
 	writeln('da humanidade “um botão de reiniciar” uma máquina do tempo. Motivo para'),
	writeln('ser comemorado pois a única salvação da terra é voltar no tempo e destruir'),
	writeln('todas as bases que contém o vírus que acabou com quase toda a população do'), 
	writeln('planeta. Irineu foi o soldado qualificado para essa missão , voltando para'),
	writeln('o ano de 2014, após 5 anos preso nas instalações secretas da CIA conseguiu'),
	writeln('convencer o diretor da CIA alertando de diversos desastres antes mesmo de ter'), 
	writeln('acontecido. Só que a arma biológica irá ser usada no ano de 2019 no dia 5 de'),
	writeln('março e faltando apenas um dia para impedir esses ataques, vão bombardear pontos'),
	writeln('exatos para a destruição dessas instalações e assim salvando a humanidade.'),
	writeln('Ajude Irineu a Salvar o Mundo !!!').

/* Criação do tabuleiro */

gerarTabuleiro([[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~]]).

imprimeTabuleiroJogador(Tabuleiro) :-
  write('############ BOMBARDMENT OF THE VIRUS ###########'),nl,nl,
  write('    A   B   C   D   E   F   G   H   I   J   L   M'),nl,nl,
  imprimeMatrizJogador(Tabuleiro, 0),
  write('_ = Terreno | X = TIRO PERDIDO'), nl, nl.
	
imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index),
    write('  '), 
    imprimeLinhaJogador(H), nl,nl,
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
