require 'gosu'
require './gameObject'

class DesertFalconGUI < Gosu::Window

  def initialize
    super 640, 480 #tamanho da janela
    self.caption = "Desert Falcon" #titulo da janela
    @playerSelect = false #se o personagem foi selecionado
    @selectopt = 1 #opção de personagem
    @font = Gosu::Font.new(self, "Arial", 32) #font para formatação de texto
    @boopIterator = 0 #iterador de boop, boop verifica se os frames estão passando ou não, uma alteração em boop indica que sim
    @sysTime = (Time.now.to_f * 1000) #primeira amostra de tempo usada no contador de fps
    @FPScount = 0.0 #inicia sem saber quantos frames tem
    @objArray = [] #coleção de objetos a ser usada no jogo, sempre deve conter um falcon em [0]
    @rocks = 0 #quantidade de pedras no jogo
    @hieros = 0 #quantidade de hieros no jogo
    @playerOptionList = ["falcon", "milenium", "bat", "rocket", "arrow", "plane", "chopper", "desertwasp", "squirrel"] #opçoes de personagem pro jogador
    @maxplayeroptions = 9 #quantidade de opções de personagem
    @kbSelectBuff = 0 #para impedir o teclado de atualizar a seleção de personagem mais rápido do que o usuário é capaz de notar
  end
  
  def make10tallObj(z1) #faz objeto de altura 10 (zlist desse objeto apenas)
    return [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4, z1 + 5, z1 + 6, z1 + 7, z1 + 8, z1 + 9]
  end

  def update
    if (@playerSelect == true) #caso não tenha selecionado personagem, rodar script de seleção, senão, rode script do jogo
      @objArray.each do |obj| #todos os objetos fazem a sua jogada
        obj.update_frame
      end
      srand Random.new_seed
      if (rand(300).to_i == 0 and @hieros < 2) #probabilidade de 1 em 300 por frame de gerar um novo hieroglifo no canto superior direito da tela
        @objArray.insert(- 1,Hiero.new("hiero", 288 + (rand(385).to_i), 32, make10tallObj(rand(26).to_i + 1), 16, 16))#novo hiero é guardado na lista de objetos e sua posição inicial é aleatória dentro dos limites da parte da tela que o falcon consegue alcançar
        @hieros += 1 #contador para impedir excesso de hieros/ evita framerate drops
      end
      if (rand(60).to_i == 0 and @rocks <7) #probabilidade de 1 em 60 de gerar nova pedra por frame
        raux = rand(3).to_i
        if (raux == 0) #pedras podem ser granito, arenito ou cascalho, com igual probabilidade
          @objArray.insert(- 1,Rock.new("slate", 288 + (rand(385).to_i), 32))
        elsif(raux == 1)
          @objArray.insert(- 1,Rock.new("granite", 288 + (rand(385).to_i), 32))
        else
          @objArray.insert(- 1,Rock.new("sandstone", 288 + (rand(385).to_i), 32))
        end
        @rocks += 1 #contador para evitar excesso de pedras na tela
      end
      @objArray.each do |obj| #todo objeto deve checar colisões
        if (obj.hit?(@objArray[0]) and obj.class  ==  Hiero.new("hiero",0,0,[0],0,0).class) #todo hiero que colidir com o jogador é coletado
          @objArray.delete(obj)
          @hieros -= 1
        elsif (obj.hitbox.x < 1) #todo objeto que chegar no fim da dela é removido do jogo
          if(obj.class == Hiero.new("hiero",0,0,[0],0,0).class)
          	@hieros -= 1
          elsif(obj.class == Rock.new("slate",0,0).class)
    		    @rocks -= 1
          end	
          @objArray.delete(obj)
        end
      end
    else #seleção de personagem script
      if (@kbSelectBuff > 0) #reduz contador de espera do teclado, para aumentar o delay de resposta e o usuário conseguir reagir
        @kbSelectBuff = @kbSelectBuff - 1
      end
      if (Gosu.button_down? Gosu::KB_UP) #keyboard arrowkey up é a seleção, pode ser substituida por enter no futuro
        @objArray.insert(-1,Falcon.new(@playerOptionList[@selectopt-1], 32, 288, [25], 32, 32)) #cria um objeto de jogador respeitando a seleção do usuário e põe como primeiro objeto do jogo
        @playerSelect = true
      end
      if (Gosu.button_down? Gosu::KB_RIGHT) and (@selectopt < @maxplayeroptions) and (@kbSelectBuff == 0) #muda seleção para a direita
        @selectopt = @selectopt + 1
        @kbSelectBuff = 5
      end
      if (Gosu.button_down? Gosu::KB_LEFT) and (@selectopt > 1) and (@kbSelectBuff == 0) #muda seleção para a esquerda
        @selectopt = @selectopt - 1
        @kbSelectBuff = 5
      end
    end
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default) #linhas de margem da tela e background arenoso
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    
    # Desenha tela inicial
    title = "DESERT FALCON 2017 XD" #printa titulo do jogo com cores intercaladas no topo
    pos = 32
    $yellow = 0xff_ffff00
    $orange = 0xff_ff8000
    color = $yellow
    tam = title.length
    for i in 0..tam do
      if (title[i] == ' ')
    		pos += 70
    	else
	    	@font.draw(title[i], pos, 0, 37, 1, 1, color, :default)
	    	pos += 20
	    	if color == $yellow
	    		color = $orange
	    	else
	    		color = $yellow
	    	end
      end
    end
    # Final da tela
    @font.draw("FPS := " + @FPScount.to_s, 32, 448, 37, 1, 1, 0xff_8000ff, :default) #contador de fps convertido para string e disposto no fundo da tela
    
    @boopIterator = @boopIterator + 1
    
    if (@boopIterator > 60)
	   @font.draw("BOOP!", 513, 448, 37, 1, 1, 0xff_8000ff, :default) #boop disposto na tela durante intervalo de 60 frames
    end
    if (@boopIterator  ==  120)
      @boopIterator = 0
      @FPScount = 120 / (((Time.now.to_f * 1000) - @sysTime) / 1000) #quando boop terminar seu intervalo, é calculado uma nova média de fps durante esse tempo
      @sysTime = (Time.now.to_f * 1000)
    end
    if (@playerSelect == true) #se já foi escolhido um personagem, renderizar objetos do jogo
      @objArray.each do |objecttorender|
        objecttorender.draw
      end
    else #caso contrário, renderizar tela de seleção de personagem
      indexaux = 0
      @playerOptionList.each do #para cada opção
        |option|
        indexaux = indexaux + 1
        Gosu::Image.new("button.png").draw(((indexaux - 1) * 48) + 32, 32, 1, 1, 1) #desenhe um botão
        if (indexaux == @selectopt)
          Gosu::Image.new("selectorarrow.png").draw(((indexaux - 1) * 48) + 32, 80, 1, 1, 1) #caso seja a opção selecionada atualmente, mostre uma seta para deixar explicito para o usuário
        end
        Gosu::Image.new(option + "1.png").draw(((indexaux - 1) * 48) + 32 + 8, 32 + 8, 1, 1, 1) #dentro do botão, coloque uma imagem ilustrativa da opção correspondente
      end
    end
  end
end

DesertFalconGUI.new.show