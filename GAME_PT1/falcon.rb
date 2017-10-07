require './gameObject'


class Falcon < GameObject # Objeto controlado pelo player. não necessariamente um passaro

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimerV = 0 # Evita aceleração descontrolada na vertical
    @movCoolDownTimerH = 0 # Evita aceleração descontrolada na horizontal
    @name = name # Nome define qual a imagem a ser carregada, preset falcon para passaro
    @sprites = [Sprite.new("./img/" + name + "/" + name + "1.png"), Sprite.new("./img/" + name + "/" + name + "2.png"),Sprite.new("./img/" + name + "/" + name + "3.png"),Sprite.new("./img/" + name + "/" + name + "4.png"),Sprite.new("./img/" + name + "/" + name + "5.png")] # Todos os frames de animação são um sprite separado
    @hitbox = Hitbox.new(x,y,zlist,width,length) # Area ocupada pelo player
    @spritestate = 1 # Estado de frame de animação
    @spriteStateCounter = 0 # Contador para mudança de estado de frame de animação
  end

  def draw() # Objeto renderiza seu sprite e uma sombra do seu sprite, usando o sprite do frame de animação atual
    @sprites[@spritestate - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new("./img/" + @name + "/" + @name + @spritestate.to_s + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0]-1, 1, 1, 0xff_464678, :default)
  end

  def mov_up() # Aumenta altura do objeto
    if (@hitbox.zlist[0] < 35)
      @hitbox.zlist[0] = @hitbox.zlist[0] + 1
      @movCoolDownTimerV = 1
    end
  end
  
  def mov_down() # Abaixa altura do objeto
    if (@hitbox.zlist[0] > 1)
      @hitbox.zlist[0] = @hitbox.zlist[0] - 1
      @movCoolDownTimerV = 1
    end
  end

  def mov_right() # Movimento diagonal direita-baixo
    if (@hitbox.y + @hitbox.length < 480 - 32)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x + 2
      @movCoolDownTimerH = 2         
    end
  end

  def mov_left() # Movimento diagonal esquerda-cima
    if (@hitbox.x > 32)
      @hitbox.y = @hitbox.y - 1
      @hitbox.x = @hitbox.x - 2
      @movCoolDownTimerH = 2
    end
  end

  def update_frame() # Instruções a serem executadas a cada frame do jogo, atualiza o estado de animação e recebe entrada do teclado
    @spriteStateCounter = @spriteStateCounter + 1 # Conta mais um frame no mesmo estado
    if(@spriteStateCounter  ==  6) # Se for o sexto frame
      @spriteStateCounter = 0 # Reseta o contador
      @spritestate = @spritestate + 1 # E atualiza o estado
      if(@spritestate  ==  6) # Se o estado não existir
        @spritestate = 1 # Rebobine a animação
      end
    end

    if @movCoolDownTimerV > 0 # Contagem regressiva para movimento vertical
      @movCoolDownTimerV = @movCoolDownTimerV - 1
    end

    if @movCoolDownTimerH > 0 # Contagem regressiva para movimento horizontal
      @movCoolDownTimerH = @movCoolDownTimerH - 1
    end
    if ((Gosu.button_down? Gosu::KB_UP) and (@movCoolDownTimerV == 0)) # Se jogador manda subir e não está em turno de espera
      self.mov_up
    end

    if ((Gosu.button_down? Gosu::KB_DOWN) and (@movCoolDownTimerV == 0)) # Se jogador manda descer e não está em turno de espera
      self.mov_down
    end

    if ((Gosu.button_down? Gosu::KB_RIGHT) and (@movCoolDownTimerH == 0))# Se jogador manda ir para a direita e não está em turno de espera
      self.mov_right
    end

    if ((Gosu.button_down? Gosu::KB_LEFT) and (@movCoolDownTimerH  ==  0))# Se jogador manda ir para a esquerda e não está em turno de espera
      self.mov_left
    end

  end

end