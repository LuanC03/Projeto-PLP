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
  Letra = l -> Numero = 11;
  Letra = m -> Numero = 12.
  
atirar(Retorno, Tiros, Pontos) :-
  Retorno =:= 1 -> Tiros = Tiros - 1, Pontos = Pontos + 1, jogar(Tiros, Pontos);
  Retorno =:= 2 -> Tiros = Tiros - 1, jogar(Tiros, Pontos);
  Retorno =:= 3 -> jogar(Tiros, Pontos). 

atirar(Coluna, Linha, Tabuleiro, Tiros, Pontos) :-
  write('atirar'),
  percorrerMatriz(Coluna, Linha, Tabuleiro, Tiros, Pontos).
   

percorrerMatriz(Coluna, Linha, Tabuleiro, Tiros, Pontos) :-  
  percorrerLinha(Linha, Tabuleiro, T),
  percorrerColuna(Coluna, T, Retorno),
  atirar(Retorno, Tiros, Pontos).

percorrerLinha(Linha, X, [T|_]) :- 
  Linha =:= X -> T;
  Linha =\= X -> Y is X+1, J is [H|Z], percorrerLinha(Coluna, Y, J).

percorrerLinha(Linha, Tabuleiro, T) :- 
 percorrerLinha(Linha, 0, R),
 T = R.
  
percorrerColuna(Coluna, X, [T|_]) :- 
  Coluna =:= X -> T;
  Coluna =\= X -> Y is X+1, J is [H|Z], percorrerColuna(Coluna, Y, J).

percorrerColuna(Coluna, Linha, T) :- 
 percorrerColuna(Coluna, 0, Linha, Retorno),
 T = Retorno.


validarCondicaoParada(Tiros, Pontos, Tabuleiro) :-
  Pontos =:= 18 -> vitoria();
  Tiros =:= 0 -> gameOver();
  Tiros > 0 -> receberCoodenadas(Tiros, Pontos,Tabuleiro).     
  

receberCoodenadas(Tiros, Pontos, Tabuleiro) :-    
  write('Digite as Coordenadas!'),  
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
  imprimeTabuleiroJogador(Tabuleiro),
  validarCondicaoParada(Tiros, Pontos, Tabuleiro).


main :-
  resumo(),
  gerarTabuleiro(TabuleiroRamdomicoAux),  
  jogar(45,0,TabuleiroRamdomicoAux).
