/*javafree.uol.com.br/topic-852645-Prolog-jogo-da-velha.html
*/
:- initialization (main).

main :-
	nl, write('      ###########      bombardment of the virus      ###########'),nl,
	writeln('      -----------------------------------------------------------'),
	resumo(),
	iniciar().	
	
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


iniciar	 :-
	nl,writeln('------------------------------------------------------------------------------'),nl,
	writeln('    Bem Vindo ao ano começo do fim , a gasolina está acabando e o mundo também'),
	writeln('só você poderá salva-lo e deter o virus mortal! Baseado em uma historia real.'),
	writeln('Se voce nao lembra foi por que o mundo ja foi salvo e sua linha do tempo mudou'),
	write('[1] Pronto para a simulação : '),
	executar().

executar :-
    repeat,
    read_line_to_codes(user_input, X3),
    string_to_atom(X3,X2),
    atom_number(X2,X),
    validarEntrada(X).
    
derrota :-
	nl, writeln('--------------- ######  Derrota ###### -------------------'),
	writeln('Voce nao foi capaz de destruir as bases inimigas a tempo.'),nl,
	writeln('                    FIM DO MUNDO !!'),
	writeln('----------------------------------------------------------').

validarEntrada(X) :-    
    X =:= 1 -> jogar();
    X < 1 -> exception();
    X > 1 -> exception().

jogar :- 
	criaTabuleiro(Tabuleiro),
	desenhaTabuleiro(Tabuleiro),
	operar(),
	sair().

criaTabuleiro([[#,a,b,c,d,e,f,g,h,i,j,k,l], [1,0,0,0,0,0,0,0,0,0,0,0,0], [2,0,0,0,0,0,0,0,0,0,0,0,0], [3,0,0,0,0,0,0,0,0,0,0,0,0],[4,0,0,0,0,0,0,0,0,0,0,0,0], [5,0,0,0,0,0,0,0,0,0,0,0,0], [6,0,0,0,0,0,0,0,0,0,0,0,0], [7,0,0,0,0,0,0,0,0,0,0,0,0], [8,0,0,0,0,0,0,0,0,0,0,0,0], [9,0,0,0,0,0,0,0,0,0,0,0,0], [10,0,0,0,0,0,0,0,0,0,0,0,0], [11,0,0,0,0,0,0,0,0,0,0,0,0], [12,0,0,0,0,0,0,0,0,0,0,0,0]]).

desenhaTabuleiro([Z,A,B,C,D,E,F,G,H,I,J,K,L]) :-  
    nl,  
    desenhaLinha(Z),
    desenhaLinha(A),    
    desenhaLinha(B),
    desenhaLinha(C),
    desenhaLinha(D),
    desenhaLinha(E),
    desenhaLinha(F),
    desenhaLinha(G),
    desenhaLinha(H),
    desenhaLinha(I),
    desenhaLinha(J),
    desenhaLinha(K),
    desenhaLinha(L),
    nl.  

desenhaLinha([Z,A,B,C,D,E,F,G,H,I,J,K,L]) :-  
    print(Z),
    print('   '),
    print(A),  
    print('   '),
    print(B),  
    print('   '),
    print(C),  
    print('   '),
    print(D),  
    print('   '),
    print(E),  
    print('   '),
    print(F),  
    print('   '),
    print(G),  
    print('   '),
    print(H),  
    print('   '),
    print(I),  
    print('   '),
    print(J),  
    print('   '),
    print(K),  
    print('   '),
    print(L),nl.

operar() :-    
    read_line_to_codes(user_input, Y3),
	string_to_atom(Y3, Y), 
    read_line_to_codes(user_input, Z3),
	string_to_atom(Z3,Z2),
	atom_number(Z2,Z).    
	
exception :-
	derrota(),
	sair().

sair() :- halt(0).
