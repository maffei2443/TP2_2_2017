require 'gosu'


class DesertFalconGUI < Gosu::Window # Janela do jogo, com script de seleção de personagem e script de operação do jogo, tanto visual quando lógico.

  def initialize
    @@WINDOW_SIZE_X = 640
    @@WINDOW_SIZE_Y = 480
    super @@WINDOW_SIZE_X, @@WINDOW_SIZE_Y # Tamanho da janela.
    self.caption = "Desert Falcon" # Título da janela.
    @playerSelect = false # Se o personagem foi selecionado.
    @selectopt = 1 # Opção de personagem.
    @font = Gosu::Font.new(self, "Arial", 32) # Font para formatação de texto.
    @boopIterator = 0 # Iterador de boop, boop verifica se os frames estão passando ou não, uma alteração em boop indica que sim.
    @sysTime = (Time.now.to_f * 1000) # Primeira amostra de tempo usada no contador de fps.
    @FPScount = 0.0 # Inicia sem saber quantos frames tem.
    @objArray = [] # Coleção de objetos a ser usada no jogo, sempre deve conter um falcon em [0].
    @rocks = 0 # Quantidade de pedras no jogo.
    @hieros = 0 # Quantidade de hieros no jogo.
    @playerOptionList = ["falcon", "milenium", "bat", "rocket", "arrow", "plane", "chopper", "desertwasp", "squirrel", "omniscientredorb", "jetpackturtle", "paperplane"] # Opçoes de personagem para o jogador.
    @maxplayeroptions = 12 # Quantidade de opções de personagem.
    @kbSelectBuff = 0 # Para impedir o teclado de atualizar, a seleção de personagem mais rápido do que o usuário é capaz de notar.
    @paused = false
    @pausewait = 0
    @slowmoset = false
    @slowmo = false
    @slowsetwait = 0

    @@FALCON_RANGE_BEGIN = 288
    @@FALCON_RANGE_SIZE = 385
    @@HIERO_HEIGHT_RANGE = 26
    @@HIERO_WIDTH = 16
    @@MINIMUM_HEIGHT = 1
    @@MARGIN_OFFSET = 32
    @@ROCK_MAX_AMOUNT = 7
    @@HIERO_MAX_AMOUNT = 2
    @@FALCON_POSITION = 0
    @@FALCON_START_HEIGHT = 25
    @@FALCON_BOX_SIZE = 32
    @@KEYBOARD_SELECTION_DELAY = 10
    @@PAUSE_SLOWMO_TOGGLE_DELAY = 20
    @@HEADS_UP_DISPLAY_LAYER = 36
    @@FPS_COUNTER_PERIOD = 60
    @@BUTTON_SIZE = 48
  end
  
  def make10tallObj(z1) # Faz objeto de altura 10 (zlist desse objeto apenas).
    return [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4, z1 + 5, z1 + 6, z1 + 7, z1 + 8, z1 + 9]
  end

  def select_char()
    if (@kbSelectBuff > 0) # Reduz contador de espera do teclado, para aumentar o delay de resposta e o usuário conseguir reagir.
      @kbSelectBuff = @kbSelectBuff - 1
    end
    if (Gosu.button_down? Gosu::KB_RETURN) # Keyboard return(enter) é a seleção.
      @objArray.insert(-1,Falcon.new(@playerOptionList[@selectopt-1], @@MARGIN_OFFSET, @@FALCON_RANGE_BEGIN, [@@FALCON_START_HEIGHT], @@FALCON_BOX_SIZE, @@FALCON_BOX_SIZE)) # Cria um objeto de jogador respeitando a seleção do usuário e põe como primeiro objeto do jogo.
      @playerSelect = true
    end
  end

  def mov_selection()
    if (Gosu.button_down? Gosu::KB_RIGHT) and (@selectopt < @maxplayeroptions) and (@kbSelectBuff == 0) # Muda seleção para a direita.
      @selectopt = @selectopt + 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end

    if (Gosu.button_down? Gosu::KB_LEFT) and (@selectopt > 1) and (@kbSelectBuff == 0) # Muda seleção para a esquerda.
      @selectopt = @selectopt - 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
    if (Gosu.button_down? Gosu::KB_DOWN) and (@selectopt+11 < @maxplayeroptions) and (@kbSelectBuff == 0) # Muda seleção para baixo.
      @selectopt = @selectopt + 12
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
    if (Gosu.button_down? Gosu::KB_UP) and (@selectopt-11 > 1) and (@kbSelectBuff == 0) # Muda seleção para cima.
      @selectopt = @selectopt - 12
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
  end

  def update # Enquanto não for selecionado um personagem, rodar a tela de seleção de personagems. Após escolher um personagem, colocar esse personagem no jogo e rodar os frames do jogo.
    if (@playerSelect == true and @paused == false and @slowmo == false) # Caso não tenha selecionado personagem, rodar script de seleção; senão, rodar script do jogo.
      @objArray.each do |obj| # Todos os objetos fazem a sua jogada.
        obj.update_frame
      end
      srand Random.new_seed
      
      if (rand(300).to_i == 0 and @hieros < @@HIERO_MAX_AMOUNT) # Probabilidade de 1 em 300 por frame de gerar um novo hieroglifo no canto superior direito da tela.
        raux = rand(3).to_i
        if(raux == 0) # Pedras podem ser granito, arenito ou cascalho, com igual probabilidade.
          @objArray.insert(- 1,Hiero.new("hieroruby", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET, make10tallObj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))# Novo hiero é guardado na lista de objetos e sua posição inicial é aleatória dentro dos limites da parte da tela que o falcon consegue alcançar.
        elsif(raux == 1)
          @objArray.insert(- 1,Hiero.new("hieroreeds", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET, make10tallObj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))# Novo hiero é guardado na lista de objetos e sua posição inicial é aleatória dentro dos limites da parte da tela que o falcon consegue alcançar
        else
          @objArray.insert(- 1,Hiero.new("ankh", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET, make10tallObj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))# Novo hiero é guardado na lista de objetos e sua posição inicial é aleatória dentro dos limites da parte da tela que o falcon consegue alcançar
        end
        @hieros += 1 # Contador para impedir excesso de hieros/ evita framerate drops
      end
      
      if (rand(60).to_i == 0 and @rocks < @@ROCK_MAX_AMOUNT) # Probabilidade de 1 em 60 de gerar nova pedra por frame.
        raux = rand(3).to_i
        if (raux == 0) # Pedras podem ser granito, arenito ou cascalho, com igual probabilidade.
          @objArray.insert(- 1,Rock.new("slate", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET))
        elsif(raux == 1)
          @objArray.insert(- 1,Rock.new("granite", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET))
        else
          @objArray.insert(- 1,Rock.new("sandstone", @@FALCON_RANGE_BEGIN + (rand(@@FALCON_RANGE_SIZE).to_i), @@MARGIN_OFFSET))
        end
        @rocks += 1 # Contador para evitar excesso de pedras na tela.
      end
      
      @objArray.each do |obj| # Todo objeto deve checar colisões.
        if (obj.hit?(@objArray[@@FALCON_POSITION]) and obj.class  ==  Hiero.new("ankh",0,0,[0],0,0).class) # Todo hiero que colidir com o jogador é coletado.
          @objArray.delete(obj)
          @hieros -= 1
        elsif (obj.hitbox.x < 1) # Todo objeto que chegar no fim da dela é removido do jogo.
          if(obj.class == Hiero.new("ankh",0,0,[0],0,0).class)
          	@hieros -= 1
          elsif(obj.class == Rock.new("slate",0,0).class)
    		    @rocks -= 1
          end	
          @objArray.delete(obj)
        end
      end
    elsif(@playerSelect == false) # Rodar script de seleção de personagem.
      self.select_char
      self.mov_selection
    end
    if ((Gosu.button_down? Gosu::KB_P) and (@pausewait == 0))# Pause.
      if (@paused == false)
        @paused = true
        @pausewait = @@PAUSE_SLOWMO_TOGGLE_DELAY
      else
        @paused = false
        @pausewait = @@PAUSE_SLOWMO_TOGGLE_DELAY
      end
    end
    if ((Gosu.button_down? Gosu::KB_O) and (@slowsetwait == 0))# Toggles slow motion.
      if (@slowmoset == false)
        @slowmoset = true
        @slowsetwait = @@PAUSE_SLOWMO_TOGGLE_DELAY
      else
        @slowmoset = false
        @slowmo = false
        @slowsetwait = @@PAUSE_SLOWMO_TOGGLE_DELAY
      end
    end
    if (@slowmoset == true)# Slowmotion frame controller.
      if (@slowmo == false)
        @slowmo = true
      else
        @slowmo = false
      end
    end
    if (@pausewait > 0)
      @pausewait -= 1
    end
    if (@slowsetwait > 0)
      @slowsetwait -= 1
    end
    if (Gosu.button_down? Gosu::KB_ESCAPE)# Sair da janela.
      exit();
    end
  end
  
  def draw # Caso não tenha sido selecionado um personagem, mostrar tela de seleção com botões para cada opção. Caso tenha sido selecionado um personagem, printar objetos do jogo nas suas respectivas posições.
    Gosu.draw_rect(0, 0, @@WINDOW_SIZE_X, @@MARGIN_OFFSET, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default) # Linhas de margem da tela e background arenoso.
    Gosu.draw_rect(0, 0, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(@@WINDOW_SIZE_X - @@MARGIN_OFFSET, 0, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(0, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@WINDOW_SIZE_X, @@MARGIN_OFFSET, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(@@MARGIN_OFFSET, @@MARGIN_OFFSET, @@WINDOW_SIZE_X - (2*(@@MARGIN_OFFSET)), @@WINDOW_SIZE_Y - (2*(@@MARGIN_OFFSET)), Gosu::Color.argb(0xff_F0C88C), 0, :default)
    
    # Desenha tela inicial.
    title = "DESERT FALCON 2017 XD" # Printa título do jogo com cores intercaladas no topo.
    pos = @@MARGIN_OFFSET
    $yellow = 0xff_ffff00
    $orange = 0xff_ff8000
    color = $yellow
    tam = title.length
    for i in 0..tam do
      if (title[i] == ' ')
    		pos += 70
    	else
	    	@font.draw(title[i], pos, 0, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, color, :default)
	    	pos += 20
	    	if color == $yellow
	    		color = $orange
	    	else
	    		color = $yellow
	    	end
      end
    end
    # Final da tela.
    @font.draw("FPS := " + @FPScount.to_s, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_8000ff, :default) # Contador de fps convertido para string e disposto no fundo da tela
    
    @boopIterator = @boopIterator + 1
    
    if (@boopIterator > @@FPS_COUNTER_PERIOD/2)
	   @font.draw("BOOP!", 513, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_8000ff, :default) # Boop disposto na tela durante intervalo de 60 frames
    end
    if (@boopIterator  ==  @@FPS_COUNTER_PERIOD)
      @boopIterator = 0
      @FPScount = @@FPS_COUNTER_PERIOD / (((Time.now.to_f * 1000) - @sysTime) / 1000) # Quando boop terminar seu intervalo, é calculado a média de fps desse intervalo tempo que passou.
      @sysTime = (Time.now.to_f * 1000)
    end
    if (@playerSelect == true) # Se já foi escolhido um personagem, renderizar objetos do jogo.
      @objArray.each do |objecttorender|
        objecttorender.draw
      end
    else # Caso contrário, renderizar tela de seleção de personagem.
      indexaux = 0
      @playerOptionList.each do # Para cada opção, verificar se ela foi escolhida pelo jogador.
        |option|
        indexaux = indexaux + 1
        if (indexaux == @selectopt)
          Gosu::Image.new("./programicons/" + "selectorarrow.png").draw((((indexaux - 1) * @@BUTTON_SIZE) + @@MARGIN_OFFSET) - (((indexaux - 1) / 12) * (@@BUTTON_SIZE * 12)), @@MARGIN_OFFSET + ((@@BUTTON_SIZE) * ((indexaux - 1) / 12)), 2, 1, 1) # Caso seja a opção selecionada atualmente, mostre uma seta para deixar explícito para o usuário.
        end
        Gosu::Image.new("./img/" + option + "/" + option + "button.png").draw(((indexaux - 1) * @@BUTTON_SIZE) + @@MARGIN_OFFSET - (((indexaux-1)/12)*(@@BUTTON_SIZE * 12)), @@MARGIN_OFFSET + ((@@BUTTON_SIZE) * ((indexaux - 1) / 12)), 1, 1, 1) # Dentro do botão, coloque uma imagem ilustrativa da opção correspondente.
      end
    end
  end
end
