Integrantes do grupo:
	    Leonardo Maffei da Silva	      16/0033811
        Luis Felipe Braga Gebrim Silva	  16/0071569
        Arthur da Silveira Couto	      16/0002575

Link para o projeto::
https://github.com/maffei2443/TP2_2_2017/tree/arthur

[Projeto](https://github.com/maffei2443/TP2_2_2017/tree/arthur)

[Instalacao do ruby](https://www.ruby-lang.org/pt/documentation/installation/)

[Instalacao do gosu](https://github.com/gosu/gosu/wiki/ruby-tutorial)

#### Instruções para execução do programa:
    0. Certifique-se de ter instalado
        1. A última versão do Ruby (2.3.x ou superior+)
        2. Ter instalada a gema 'gosu'
    1. Navegue até a pasta 'src’
    2. Digite "ruby main.rb"

#### Comandos do jogo:
    ESC	- Sai do jogo/back no menu
    p	- Pausa/despausa o jogo 
    o 	- Ativa/desativa slowmotion
    x	- Atira
    r 	- Recarrega munição
    Setas - Movimentam o personagem escolhido
    ENTER - Seleciona o personagem a ser usado durante o jogo na tela de    seleção de personagens

#### Para gerar a documentação : 
    - Na pasta 'src', digite : 
        $ yardoc *.rb
#### Para gerar o grafo do programa : 
    - Na pasta 'src', digite:
        $ yard graph --dependencies --empty-mixins --full | dot -T pdf -o Grafo.pdf
#### Para gerar o resultado dos testes em html
    - Na pasta 'GAME_PT2', digite:
        $ rspec --format h > ResultadoTestes.html
    - O resultado estará no arquivo 'ResultadoTestes.html' neste mesmo diretório.