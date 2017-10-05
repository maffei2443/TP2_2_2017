require 'gosu'
require './gameObject'

class DesertFalconGUI < Gosu::Window

  def initialize
    super 640, 480 # Tamanho da janela.
    self.caption = "Desert Falcon" # Titulo da janela.
    
    @font = Gosu::Font.new(self, "Arial", 32) # Font para formatação de texto.
    @objArray = [] # Coleção de objetos a ser usada no jogo, sempre deve conter um falcon em [0].
    @objArray.insert(-1,Falcon.new("jetpackturtle", 32, 288, [25], 32, 32))
    @hieros = 0 # Quantidade de hieros no jogo.
    
  end
  
  def make10tallObj(z1) # Faz objeto de altura 10 (zlist desse objeto apenas).
    return [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4, z1 + 5, z1 + 6, z1 + 7, z1 + 8, z1 + 9]
  end

  def update
      @objArray.each do |obj| # Todos os objetos fazem a sua jogada.
        obj.update_frame
      end
      srand Random.new_seed
      if (rand(300).to_i == 0 and @hieros < 2) # Probabilidade de 1 em 300 por frame de gerar um novo hieroglifo no canto superior direito da tela.
        @objArray.insert(- 1,Hiero.new("hiero", 288 + (rand(385).to_i), 32, make10tallObj(rand(26).to_i + 1), 16, 16))# Novo hiero é guardado na lista de objetos e sua posição inicial é aleatória dentro dos limites da parte da tela que o falcon consegue alcançar.
        @hieros += 1 # Contador para impedir excesso de hieros/ evita framerate drops.
      end
      @objArray.each do |obj| # Todo objeto deve checar colisões.
        if (obj.hit?(@objArray[0]) and obj.class  ==  Hiero.new("hiero",0,0,[0],0,0).class) # Todo hiero que colidir com o jogador é coletado.
          @objArray.delete(obj)
          @hieros -= 1
        elsif (obj.hitbox.x < 1) # Todo objeto que chegar no fim da dela é removido do jogo.
          if(obj.class == Hiero.new("hiero",0,0,[0],0,0).class)
          	@hieros -= 1

          end	
          @objArray.delete(obj)
        end
      end
    if (Gosu.button_down? Gosu::KB_ESCAPE)# Sair.
      exit();
    end
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default) # Linhas de margem da tela e background arenoso.
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    
    #  Desenha tela inicial.
    title = "DESERT FALCON 2017 XD" #  Printa titulo do jogo com cores intercaladas no topo.
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
      @objArray.each do |objecttorender|
        objecttorender.draw
      end
    end
end

DesertFalconGUI.new.show