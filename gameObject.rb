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

  def draw()
    @sprites[@spritestate - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + @spritestate.to_s + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0]-1, 1, 1, 0xff_464678, :default)
  end

  def mov_up()
    if (@hitbox.zlist[0] < 35)
  	  @hitbox.zlist[0] = @hitbox.zlist[0] + 1
      @movCoolDownTimerV = 1
    end
  end
  
  def mov_down()
    if (@hitbox.zlist[0] > 1)
    	@hitbox.zlist[0] = @hitbox.zlist[0] - 1
	    @movCoolDownTimerV = 1
    end
  end

  def mov_right()
    if (@hitbox.y + @hitbox.length < 480 - 32)
	    @hitbox.y = @hitbox.y + 1
	    @hitbox.x = @hitbox.x + 2
      @movCoolDownTimerH = 2         
    end
  end

  def mov_left()
    if (@hitbox.x > 32)
	    @hitbox.y = @hitbox.y - 1
	    @hitbox.x = @hitbox.x - 2
      @movCoolDownTimerH = 2
    end
  end

  def update_frame()
    @spriteStateCounter = @spriteStateCounter + 1
    if(@spriteStateCounter  ==  6)
      @spriteStateCounter = 0
      @spritestate = @spritestate + 1
      if(@spritestate  ==  6)
        @spritestate = 1
      end
    end

    if @movCoolDownTimerV > 0
      @movCoolDownTimerV = @movCoolDownTimerV - 1
    end

    if @movCoolDownTimerH > 0
      @movCoolDownTimerH = @movCoolDownTimerH - 1
    end
    if ((Gosu.button_down? Gosu::KB_UP) and (@movCoolDownTimerV == 0))
      self.mov_up
    end

    if ((Gosu.button_down? Gosu::KB_DOWN) and (@movCoolDownTimerV == 0))
      self.mov_down
    end

    if ((Gosu.button_down? Gosu::KB_RIGHT) and (@movCoolDownTimerH == 0))
      self.mov_right
    end

    if ((Gosu.button_down? Gosu::KB_LEFT) and (@movCoolDownTimerH  ==  0))
      self.mov_left
    end

  end

end

class Hiero < GameObject

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimer = 0
    @name = name
    @sprite = Sprite.new(name + ".png")
    @hitbox = Hitbox.new(x,y,zlist,width,length)
  end

  def draw()
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame()
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
    @movCoolDownTimer = 0
    @name = name
    @sprite = Sprite.new(name + ".png")
    @hitbox = Hitbox.new(x,y,[0],0,0)
  end

  def draw()
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame()
    if @movCoolDownTimer > 0
      @movCoolDownTimer = @movCoolDownTimer - 1
    elsif(@movCoolDownTimer == 0)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimerH = 2
    end
  end

end
