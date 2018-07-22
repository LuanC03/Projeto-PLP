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

/* Regras para realizar tiros, manipulando o tabuleiro */

atirar(Tabuleiro, NovoTabuleiro) :-
  selecione,
  inserir_numero('Linha', Linha),
  inserir_numero('Coluna', Coluna),
  (Linha >= 0, Linha =< 12, Coluna >= 0, Coluna =< 12 ->
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
    (
    (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, @, NovoTabuleiro), errou, nl;
    (Simbolo == n) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, o, NovoTabuleiro), acertou, nl;
    (Simbolo == b) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, *, NovoTabuleiro), acertou, nl;
    (Simbolo == a) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, Q, NovoTabuleiro), acertou, nl;
    (Simbolo == @) -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == x) -> invalido, atirar(Tabuleiro, NovoTabuleiro)
    );
    selecaoInvalida, atirar(Tabuleiro, NovoTabuleiro)
  ).

alteraValorNoTabuleiro([H|T], 0, Coluna, NovoValor, [J|T]) :- substituir(H, Coluna, NovoValor, J).
alteraValorNoTabuleiro([H|T], Linha, Coluna, NovoValor, [H|U]) :-
   Linha1 is Linha - 1, alteraValorNoTabuleiro(T, Linha1, Coluna, NovoValor, U).

encontraSimboloNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth0(Linha, Matriz, ListaDaPos),
  nth0(Coluna, ListaDaPos, Simbolo).

substituir([_|T], 0, X, [X|T]).
substituir([H|T], Index, NewElement, [H|U]) :-
  Index1 is Index - 1, substituir(T, Index1, NewElement, U).

/* Funções que verificam a existência de elementos em listas e matriz */

contem([X|_], X).
contem([_|T], X) :-
  contem(T, X).

existemNavios([H|_]) :- contem(H, n).
existemNavios([_|T]) :- existemNavios(T).

/* Funções de inserção de Bases no tabuleiro */

inserirBPC(Tabuleiro, NovoTabuleiro):-
    random(0,6,Linha),random(0,6,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, _),Coluna2 is Coluna+1,Coluna3 is Coluna+2,Coluna4 is Coluna+3, Linha2 is Linha+1,Linha3 is Linha+2,Linha4 is Linha+3,
 (
 (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, b, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha, Coluna2, b, Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha, Coluna3, b, Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha, Coluna4, b, NovoTabuleiro);
 (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, b, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha2, Coluna, b, Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha3, Coluna, b, Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha4, Coluna, b, NovoTabuleiro)

 ).

/*Tamanho 2*/
inserirBTM(Tabuleiro, NovoTabuleiro):-
    random(0,10,Linha),random(0,10,Coluna),random(0,2,Orientacao),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1, encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2, Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),
 (
 (Simbolo == ~), (Simbolo2 == ~), (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha, Coluna2, n, NovoTabuleiro);
 (Simbolo == ~), (Simbolo3 == ~), (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, n, Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha2, Coluna, n, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == n);(Simbolo2 == n))-> inserirCruiser(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == n);(Simbolo3 == n))-> inserirCruiser(Tabuleiro, NovoTabuleiro)

 ).

/*Tamanho 1*/
inserirCT(Tabuleiro, NovoTabuleiro):-random(0,11,Linha),random(0,11,Coluna),
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 (
 (Simbolo == ~) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, a, NovoTabuleiro);
 (Simbolo == a) -> inserirCT(Tabuleiro, NovoTabuleiro)
 ).

inserirBase(Tabuleiro, NovoTabuleiro):-
    inserirBPC(Tabuleiro, Tabuleiro2),
	inserirBTM(Tabuleiro2, Tabuleiro3),
	inserirBTM(Tabuleiro3, Tabuleiro4),
	inserirCT(Tabuleiro4, Tabuleiro5),
	inserirCT(Tabuleiro5, Tabuleiro6),
	inserirCT(Tabuleiro6, Tabuleiro7),
	inserirCT(Tabuleiro7, NovoTabuleiro).

/* Execução da lógica sequencial do jogo */
jogar(Tabuleiro, Misseis) :-
  Misseis > 0,
  imprimeTabuleiroJogador(Tabuleiro),
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  (
  not( existemNavios(NovoTabuleiro) ) -> imprimeTabuleiroReal(NovoTabuleiro), vitoria;
  (NovosMisseis > 1 -> misseis(NovosMisseis), jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 1 -> ultimoMissel, jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 0 -> misseisEsgotados, imprimeTabuleiroReal(NovoTabuleiro), gameOver)
  ).

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

gerarTabuleiro([[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~]]).


/* Execução do programa */
:- initialization(main).
main :-
  gerarTabuleiro(TabuleiroRamdomicoAux),
  inserirBase(TabuleiroRamdomicoAux, TabuleiroRamdomico),
  jogar(TabuleiroRamdomico, 40).
