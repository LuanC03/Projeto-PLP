: - module(iteracao,[contem /2,existemNavios /1,inserirBPC /2,inserirBTM /2, inserirCT /2, inserirBase /2]).

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