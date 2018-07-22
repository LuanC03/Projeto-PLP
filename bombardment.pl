use_module(util).
use_module(iteracao).
use_module(exibicao).

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
