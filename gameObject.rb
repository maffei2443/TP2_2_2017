require 'gosu'
require './sprite'
require './box'

class GameObject #qualquer objeto que irá existir precisa desses elementos de classe

  def initialize(name, x, y, zlist, width, length)
    @name = name
    @sprite = Sprite.new(name + ".png")
    @hitbox = Hitbox.new(x,y,zlist,width,length)
  end

  def draw()
    @sprite.draw(@x, @y, @z)
  end

  def hit?(obj) #pergunta ao objeto se ele colide com determinada área tridimensional
    return @hitbox.check_hit(obj.hitbox.x, obj.hitbox.y, obj.hitbox.zlist, obj.hitbox.width, obj.hitbox.length)
  end

  attr_reader :hitbox

  def update_frame()
  end

end

class Falcon < GameObject #objeto controlado pelo player. não necessariamente um passaro

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimerV = 0 #evita aceleração descontrolada na vertical
    @movCoolDownTimerH = 0 #evita aceleração descontrolada na horizontal
    @name = name #nome define qual a imagem a ser carregada, preset falcon para passaro
    @sprites = [Sprite.new(name + "1.png"), Sprite.new(name + "2.png"),Sprite.new(name + "3.png"),Sprite.new(name + "4.png"),Sprite.new(name + "5.png")] #todos os frames de animação são um sprite separado
    @hitbox = Hitbox.new(x,y,zlist,width,length) #area ocupada pelo player
    @spritestate = 1 #estado de frame de animação
    @spriteStateCounter = 0 #contador para mudança de estado de frame de animação
  end

  def draw() #objeto renderiza seu sprite e uma sombra do seu sprite, usando o sprite do frame de animação atual
    @sprites[@spritestate - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + @spritestate.to_s + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0]-1, 1, 1, 0xff_464678, :default)
  end

  def mov_up() #aumenta altura do objeto
    if (@hitbox.zlist[0] < 35)
  	  @hitbox.zlist[0] = @hitbox.zlist[0] + 1
      @movCoolDownTimerV = 1
    end
  end
  
  def mov_down() #abaixa altura do objeto
    if (@hitbox.zlist[0] > 1)
    	@hitbox.zlist[0] = @hitbox.zlist[0] - 1
	    @movCoolDownTimerV = 1
    end
  end

  def mov_right() #movimento diagonal direita-baixo
    if (@hitbox.y + @hitbox.length < 480 - 32)
	    @hitbox.y = @hitbox.y + 1
	    @hitbox.x = @hitbox.x + 2
      @movCoolDownTimerH = 2         
    end
  end

  def mov_left() #movimento diagonal esquerda-cima
    if (@hitbox.x > 32)
	    @hitbox.y = @hitbox.y - 1
	    @hitbox.x = @hitbox.x - 2
      @movCoolDownTimerH = 2
    end
  end

  def update_frame() #instruções a serem executadas a cada frame do jogo, atualiza o estado de animação e recebe entrada do teclado
    @spriteStateCounter = @spriteStateCounter + 1 #conta mais um frame no mesmo estado
    if(@spriteStateCounter  ==  6) #se for o sexto frame
      @spriteStateCounter = 0 #reseta o contador
      @spritestate = @spritestate + 1 #e atualiza o estado
      if(@spritestate  ==  6) #se o estado não existir
        @spritestate = 1 #rebobine a animação
      end
    end

    if @movCoolDownTimerV > 0 #contagem regressiva para movimento vertical
      @movCoolDownTimerV = @movCoolDownTimerV - 1
    end

    if @movCoolDownTimerH > 0 #contagem regressiva para movimento horizontal
      @movCoolDownTimerH = @movCoolDownTimerH - 1
    end
    if ((Gosu.button_down? Gosu::KB_UP) and (@movCoolDownTimerV == 0)) #se jogador manda subir e não está em turno de espera
      self.mov_up
    end

    if ((Gosu.button_down? Gosu::KB_DOWN) and (@movCoolDownTimerV == 0)) #se jogador manda descer e não está em turno de espera
      self.mov_down
    end

    if ((Gosu.button_down? Gosu::KB_RIGHT) and (@movCoolDownTimerH == 0))#se jogador manda ir para a direita e não está em turno de espera
      self.mov_right
    end

    if ((Gosu.button_down? Gosu::KB_LEFT) and (@movCoolDownTimerH  ==  0))#se jogador manda ir para a esquerda e não está em turno de espera
      self.mov_left
    end

  end

end

class Hiero < GameObject

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimer = 0 #temporizador do movimento dos hieros
    @name = name
    @sprite = Sprite.new(name + ".png") #imagem do hiero encapsulada em um sprite
    @hitbox = Hitbox.new(x,y,zlist,width,length) #hitbox do hiero
  end

  def draw() #objeto renderiza seu sprite e uma sombra do seu sprite
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame() #a cada frame, caso o temporizador esteja zerado, o hiero deve mover na diagonal para gerar impressão de movimento do personagem. o temporizador impede que ele se movimente rápido demais 
    if @movCoolDownTimer > 0
      @movCoolDownTimer = @movCoolDownTimer - 1
    elsif(@movCoolDownTimer == 0)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimerH = 2
    end
  end

end

class Rock < GameObject

  def initialize(name, x, y)
    @movCoolDownTimer = 0 #pedra se move com velocidade controlada
    @name = name #cada nome gera uma pedra diferente
    @sprite = Sprite.new(name + ".png") #imagem da pedra de determinado nome
    @hitbox = Hitbox.new(x,y,[0],0,0) #pedra tem hitbox sempre no chão e sem largura, é só decorativa
  end

  def draw() #pedra sempre no chão, não precisa de sombra
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
  end

  def update_frame() #pedra se move para gerar impressão de movimento do jogador
    if @movCoolDownTimer > 0
      @movCoolDownTimer = @movCoolDownTimer - 1
    elsif(@movCoolDownTimer == 0)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimerH = 2
    end
  end

end
