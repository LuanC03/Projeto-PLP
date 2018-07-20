:- initialization(main).

/* Impressões de avisos */

acertou :-
  write('ACERTOU!'), nl.

errou :-
  write('ERROU!'), nl.

ocupado :-
  write('Você já atirou aqui! Atire em outro lugar.'), nl.

invalido : -
 writeln('Você atirou em uma coordenada invalida! Atire em outro lugar.').

selecione :-
  write('Selecione as coordenadas de onde deseja atirar!'), nl.

selecaoInvalida :-
  write('Coordenadas inválidas. Tente novamente.'), nl.

/* Fim do jogo */

gameOver :-
  write('---------------------------------------------------'), nl,
  write('Voce nao foi capaz de destruir as bases inimigas a tempo.'), nl,
  write('---------------------------------------------------')
  sair().

vitoria :-
  write('---------------------------------------------------'), nl,
  write('Você destruiu todas as bases inimiga e conseguiu SALVAR O MUNDO!'), nl,
  write('---------------------------------------------------')
  sair().

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
	writeln('Ajude Irineu a Salvar o Mundo !!!'),nl,
	writeln('--------------------------------------------------------------------------'),nl.

/* Busca De Elemento */

encontraElementoNaMatriz(Matriz, Linha, Coluna, Simbolo) :-
  nth0(Linha, Matriz, ListaDaPos),
  nth0(Coluna, ListaDaPos, Simbolo).

/*Funções para verificar se existe base*/

contem([X|_], X).
contem([_|T], X) :-
  contem(T, X).

existemBase([H|_]) :- contem(H, n).
existemBase([_|T]) :- existemBase(T).

/* Criação do tabuleiro */

gerarTabuleiro([[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],
[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~],[~,~,~,~,~,~,~,~,~,~,~,~]]).

imprimeTabuleiroJogador(Tabuleiro) :-
  write('############ BOMBARDMENT OF THE VIRUS ###########'),nl,nl,
  write('    A   B   C   D   E   F   G   H   I   J   K   L'),nl,nl,
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

converte(Letra, Numero) :-
  Letra = a -> Numero = 1;
  Letra = b -> Numero = 2;
  Letra = c -> Numero = 3;
  Letra = d -> Numero = 4;
  Letra = e -> Numero = 5;
  Letra = f -> Numero = 6;
  Letra = g -> Numero = 7;
  Letra = h -> Numero = 8;
  Letra = i -> Numero = 9;
  Letra = j -> Numero = 10;
  Letra = k -> Numero = 11;
  Letra = l -> Numero = 12;
  Letra = v -> Numero = 13.
  
atirar(R, Tiros, Pontos, TabuleiroRamdomicoAux) :-
  writeln('atirou2'),
  imprimeTabuleiroJogador(TabuleiroRamdomicoAux),
  R =:= 1 -> Tiros is Tiros - 1, Pontos is Pontos + 1, jogar(Tiros, Pontos, TabuleiroRamdomicoAux);
  R =:= 2 -> Tiros is Tiros - 1, jogar(Tiros, Pontos, TabuleiroRamdomicoAux);
  R =:= 3 -> jogar(Tiros, Pontos, TabuleiroRamdomicoAux). 

atirar(Coluna, Linha, Tabuleiro, Tiros, Pontos) :-
  writeln('atirar'),
  Coluna < 1  ->  R is 3, atirar(R, Tiros, Pontos);
  Coluna > 12 ->  R is 3, atirar(R, Tiros, Pontos);
  Linha < 1 ->  R is 3, atirar(R, Tiros, Pontos);
  Linha > 12 ->  R is 3, atirar(R, Tiros, Pontos);
  Coluna > 0, Coluna < 13, Linha > 0, Linha < 13 -> percorrerMatriz(Coluna, Linha, Tabuleiro, Tiros, Pontos).   

percorrerMatriz(Coluna, Linha, Tabuleiro, Tiros, Pontos) :- 
  writeln('percorreu'),
  percorrer(Linha, Tabuleiro, L),
  percorrer(Coluna, L, C),
 /*atualizaMatrizJogador(Linha, Tabuleiro, LinhaMatriz),
  atualizaLinhaJogador(Coluna, LinhaMatriz, X, C),*/ 
  verificaElemento(C, Retorno),
  gerarTabuleiro(TabuleiroRamdomicoAux),
  atirar(Retorno, Tiros, Pontos, TabuleiroRamdomicoAux).

percorrer(0, [H|T], H):-!.
percorrer(Ind, [H|T], C):-Z is Ind-1, percorrer(Z, T, C).

verificaElemento(Elemento, Retorno) :-
  writeln('verificou'),
  Elemento == '~' -> Retorno is 1;
  Elemento \= '~' -> Retorno is 2.
 
validarCondicaoParada(Tiros, Pontos, Tabuleiro) :-
  Pontos =:= 18 -> vitoria();
  Tiros =:= 0 -> gameOver();
  Tiros > 0 -> receberCoodenadas(Tiros, Pontos,Tabuleiro).     
  
/*atualizaMatrizJogador(0, [H|T], H).
atualizaMatrizJogador(Linha, [H|T], RetornoLinha):-Z is Ind-1, percorrer(Z, T, C, Coluna).    

atualizaLinhaJogador(0, [H|T], H, Elemento) :- H is Elemento.
atualizaLinhaJogador(Ind, [H|T], C, Elemento):-Z is Ind-1, percorrer(Z, T, C, Elemento)*/


receberCoodenadas(Tiros, Pontos, Tabuleiro) :-    
  nl,write('Digite Numero da Linha: '),
   read_line_to_codes(user_input, LinhaNumero),
      string_to_atom(LinhaNumero,Numero),
         atom_number(Numero,Linha),
  write('Digite Letra da Coluna: '),  
   read_line_to_codes(user_input, ColunaLetra),
      string_to_atom(ColunaLetra, ColunaLetra2),
      converte(ColunaLetra2, Coluna), 
  atirar(Coluna, Linha, Tabuleiro,  Tiros, Pontos).

sair() :- halt(0).

jogar(Tiros, Pontos, Tabuleiro) :-
  writeln('jogar'),
  imprimeTabuleiroJogador(Tabuleiro),
  validarCondicaoParada(Tiros, Pontos, Tabuleiro).


main :-
  resumo(),
  gerarTabuleiro(TabuleiroRamdomicoAux),  
  jogar(45,0,TabuleiroRamdomicoAux).
