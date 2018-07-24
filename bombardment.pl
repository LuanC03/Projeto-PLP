/* Regras para realizar tiros, manipulando o tabuleiro */

atirar(Tabuleiro, NovoTabuleiro) :-
  selecione,
  inserir_numero('Linha', Linha),
  inserir_numero('Coluna', ColunaLetra),
  converte(ColunaLetra, Coluna),
  (Linha >= 0, Linha =< 8, Coluna >= 0, Coluna =< 8 ->
    encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
    (
    (Simbolo == '0') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, x, NovoTabuleiro), errou, nl;
    (Simbolo == '1') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '@', NovoTabuleiro), acertou, nl;
    (Simbolo == '2') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '#', NovoTabuleiro), acertou, nl;
    (Simbolo == 'o') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '#', NovoTabuleiro), acertou, nl;
    (Simbolo == '4') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '*', NovoTabuleiro), acertou, nl;
    (Simbolo == '#') -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == '@') -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == 'o') -> invalido, atirar(Tabuleiro, NovoTabuleiro);
    (Simbolo == '*') -> invalido, atirar(Tabuleiro, NovoTabuleiro);
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


/* EXIBIÇÃO */

/* Impressão da visão que o jogador tem do tabuleiro, omitindo navios */

imprimeTabuleiroJogador(Tabuleiro) :-
  write('######################################'),nl,
  write('###### BOMBARDMENT OF THE VIRUS ######'),nl,
  write('######################################'),nl,
  write('   A   B   C   D   E   F   G   H   I'),nl,
  write('--------------------------------------'),nl,
  imprimeMatrizJogador(Tabuleiro, 0),
  writeln(''),
  writeln('
 X - Bomba  perdida    	      Base:   Tamanho:
 @ - CT                	      CT    	 1
 # - IAPA              	      IAPA       2
 o - BTM               	      BMT     	 3
 * - BPC                      BPC        4').

imprimeMatrizJogador([], _).
imprimeMatrizJogador([H|T], Index) :-
    write(Index), write(' '), imprimeLinhaJogador(H), nl,
    NewIndex is Index+1,
    imprimeMatrizJogador(T, NewIndex).

imprimeLinhaJogador([]).
imprimeLinhaJogador([H|T]) :-
  (H == '0', write('|.|');
  H == '1', write('|.|');
  H == '2', write('|.|');
  H == '3', write('|.|');
  H == '4', write('|.|');
  H == '#', write('|#|');
  H == 'o', write('|o|');
  H == '*', write('|*|');
  H == '@', write('|@|');
  H == x, write('|x|')), write(' '),
  imprimeLinhaJogador(T).

/* Impressão do tabuleiro exibindo os navios inimigos */

imprimeTabuleiroReal(Tabuleiro) :-
  write('######################################'),nl,
  write('###### BOMBARDMENT OF THE VIRUS ######'),nl,
  write('######################################'),nl,
  write('   A   B   C   D   E   F   G   H   I'),nl,
  write('--------------------------------------'),nl,
  imprimeLinhas(Tabuleiro, 0),
  writeln(''),
  writeln('
 X - Bomba  perdida    	      Base:   Tamanho:
 @ - CT                	      CT    	 1
 # - IAPA              	      IAPA       2
 o - BTM               	      BMT     	 3
 * - BPC                      BPC        4').

imprimeLinhas([], _).
imprimeLinhas([H|T], Index) :-
  write(Index), write(' '), imprimeLinha(H), nl,
  NewIndex is Index+1,
  imprimeLinhas(T, NewIndex).

imprimeLinha([]).
imprimeLinha([H|T]) :-write("|"),
  write(H), write('| '),
  imprimeLinha(T).

/* Impressões simples */

acertou :-
  write('ACERTOU UMA BASE INIMIGA!'), nl.

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
  write('O Mundo acabou'), nl,
  write('---------------------------------------------------').

vitoria :-
  write('---------------------------------------------------'), nl,
  write(' Voce conseguiu destruir todas as bases inimigas
                    VOCE SALVOU O MUNDO <3 '), nl,
  write('---------------------------------------------------').

/* Imprime uma mensagem na tela e lê um número da entrada */
inserir_numero(Prompt, Numero) :-
  write(Prompt),
  write(': '),
  read(Numero).
converte(Letra, Numero) :-
 Letra = a -> Numero = 0;
 Letra = b -> Numero = 1;
 Letra = c -> Numero = 2;
 Letra = d -> Numero = 3;
 Letra = e -> Numero = 4;
 Letra = f -> Numero = 5;
 Letra = g -> Numero = 6;
 Letra = h -> Numero = 7;
 Letra = i -> Numero = 8;
 Letra = j -> Numero = 9;
 Letra = l -> Numero = 10;
 Letra = k -> Numero = 11.

/* Funções que verificam a existência de elementos em listas e matriz */

contem([X|_], X).
contem([_|T], X) :-
  contem(T, X).

existeBase([H|_]) :- contem(H, '1').
existeBase([H|_]) :- contem(H, '2').
existeBase([H|_]) :- contem(H, '3').
existeBase([H|_]) :- contem(H, '4').
existeBase([_|T]) :- existeBase(T).

/* Funções de inserção de Navios no tabuleiro */

inserirBPC(Tabuleiro, NovoTabuleiro):-
 random(0,6,Linha),random(0,6,Coluna),random(0,2,Orientacao),
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, _),Coluna2 is Coluna+1,Coluna3 is Coluna+2,Coluna4 is Coluna+3,
 Linha2 is Linha+1,Linha3 is Linha+2,Linha4 is Linha+3, (
 (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '4',  Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha, Coluna2, '4', Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha, Coluna3, '4',  Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha, Coluna4, '4', NovoTabuleiro);
 (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '4', Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2, Linha2, Coluna, '4',  Tabuleiro3),alteraValorNoTabuleiro(Tabuleiro3, Linha3, Coluna, '4', Tabuleiro4),alteraValorNoTabuleiro(Tabuleiro4, Linha4, Coluna, '4', NovoTabuleiro)).

/*Alocação IAPA*/

inserirIAPA(Tabuleiro, NovoTabuleiro):-
 random(0,8,Linha),random(0,8,Coluna),random(0,2,Orientacao),
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1 , encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2,  Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),
 ((Simbolo == '0'), (Simbolo2 == '0'), (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '2', Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2,  Linha, Coluna2, '2', NovoTabuleiro);
 (Simbolo == '0'), (Simbolo3 == '0'), (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '2', Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2,  Linha2, Coluna, '2', NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '1');(Simbolo2 == '1'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '2');(Simbolo2 == '2'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '3');(Simbolo2 == '3'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '4');(Simbolo2 == '4'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '1');(Simbolo2 == '1'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '2');(Simbolo2 == '2'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '3');(Simbolo2 == '3'))-> inserirIAPA(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '4');(Simbolo2 == '4'))-> inserirIAPA(Tabuleiro, NovoTabuleiro)
 ).
/*Alocação BMT*/

inserirBMT(Tabuleiro, NovoTabuleiro):-
 random(0,7,Linha),random(0,7,Coluna),random(0,2,Orientacao),
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),Coluna2 is Coluna+1, Linha2 is Linha+1 ,Coluna3 is Coluna+2,Linha3 is Linha+2,encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna2,  Simbolo2),encontraSimboloNaMatriz(Tabuleiro, Linha2, Coluna, Simbolo3),encontraSimboloNaMatriz(Tabuleiro, Linha3, Coluna3, Simbolo3),
 ((Simbolo == '0'), (Simbolo2 == '0'), (Orientacao == 0) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '3', Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2,  Linha, Coluna2, '3', Tabuleiro3),
alteraValorNoTabuleiro(Tabuleiro3,  Linha, Coluna3, '3', NovoTabuleiro);
 (Simbolo == '0'), (Simbolo3 == '0'), (Orientacao == 1) -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '3', Tabuleiro2),alteraValorNoTabuleiro(Tabuleiro2,  Linha2, Coluna, '3', Tabuleiro3),
alteraValorNoTabuleiro(Tabuleiro3,  Linha3, Coluna, '3', NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '1');(Simbolo2 == '1');(Simbolo3 == '1'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '2');(Simbolo2 == '2');(Simbolo3 == '2'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '3');(Simbolo2 == '3');(Simbolo3 == '3'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 0),((Simbolo == '4');(Simbolo2 == '4');(Simbolo3 == '4'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '1');(Simbolo2 == '1');(Simbolo3 == '1'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '2');(Simbolo2 == '2');(Simbolo3 == '2'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '3');(Simbolo2 == '3');(Simbolo3 == '3'))-> inserirBMT(Tabuleiro, NovoTabuleiro);
 (Orientacao == 1),((Simbolo == '4');(Simbolo3 == '4');(Simbolo3 == '4'))-> inserirBMT(Tabuleiro, NovoTabuleiro)).

inserirCT(Tabuleiro, NovoTabuleiro):-random(0,9,Linha),random(0,9,Coluna),
 encontraSimboloNaMatriz(Tabuleiro, Linha, Coluna, Simbolo),
 ((Simbolo == '0') -> alteraValorNoTabuleiro(Tabuleiro, Linha, Coluna, '1', NovoTabuleiro);
 (Simbolo == '1') -> inserirCT(Tabuleiro, NovoTabuleiro);
 (Simbolo == '2') -> inserirCT(Tabuleiro, NovoTabuleiro);
 (Simbolo == '3') -> inserirCT(Tabuleiro, NovoTabuleiro);
 (Simbolo == '4') -> inserirCT(Tabuleiro, NovoTabuleiro)
).

gerarTabuleiro([['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0'],['0','0','0','0','0','0','0','0','0']]).

inserirBases(Tabuleiro, NovoTabuleiro):-
   inserirBPC(Tabuleiro, Tabuleiro2),
    inserirIAPA(Tabuleiro2, Tabuleiro3),
    inserirBMT(Tabuleiro3, Tabuleiro4),
    inserirCT(Tabuleiro4, Tabuleiro5),
    inserirCT(Tabuleiro5, NovoTabuleiro).


/* Execução da lógica sequencial do jogo */
jogar(Tabuleiro, Misseis) :-
  Misseis > 0,
  imprimeTabuleiroJogador(Tabuleiro),
  write(' Misseis restantes: '),
  writeln(Misseis),nl,
  atirar(Tabuleiro, NovoTabuleiro), NovosMisseis is Misseis-1,
  (
  not( existeBase(NovoTabuleiro) ) -> imprimeTabuleiroReal(NovoTabuleiro), vitoria;
  (NovosMisseis > 1 -> misseis(NovosMisseis), jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 1 -> ultimoMissel, jogar(NovoTabuleiro, NovosMisseis);
  NovosMisseis =:= 0 -> misseisEsgotados, imprimeTabuleiroReal(NovoTabuleiro), gameOver)
  ).

/* Execução do programa */
:- initialization(main).
main :-
  gerarTabuleiro(TabuleiroRamdomicoAux),
  inserirBases(TabuleiroRamdomicoAux, TabuleiroRamdomico),
  jogar(TabuleiroRamdomico, 45).
