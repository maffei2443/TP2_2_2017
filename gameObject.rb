require 'gosu'
require './sprite'
require './box'

class GameObject

  def initialize(name, x, y, zlist, width, length)
    @name = name
    @sprite = Sprite.new(name + ".png")
    @hitbox = Hitbox.new(x,y,zlist,width,length)
  end

  def draw()
    @sprite.draw(@x, @y, @z)
  end

  def hit?(obj)
    return @hitbox.check_hit(obj.hitbox.x, obj.hitbox.y, obj.hitbox.zlist, obj.hitbox.width, obj.hitbox.length)
  end

  attr_reader :hitbox

  def update_frame()
  end

end

class Falcon < GameObject

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimerV = 0
    @movCoolDownTimerH = 0
    @name = name
    @sprites = [Sprite.new(name + "1.png"), Sprite.new(name + "2.png"),Sprite.new(name + "3.png"),Sprite.new(name + "4.png"),Sprite.new(name + "5.png")]
    @hitbox = Hitbox.new(x,y,zlist,width,length)
    @spritestate = 1
    @spriteStateCounter = 0
  end

  def draw()
    @sprites[@spritestate - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new(@name + @spritestate.to_s + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0]-1, 1, 1, 0xff_464678, :default)
  end

  def mov_up()
    if (@hitbox.zlist[0] < 35)
      5.times do 
  	    @hitbox.zlist[0] = @hitbox.zlist[0] + 1
  	  end
      @movCoolDownTimerV = 2
    end
  end
  
  def mov_down()
    if (@hitbox.zlist[0] > 9)
    	5.times do
    	  @hitbox.zlist[0] = @hitbox.zlist[0] - 1
    	end
	    @movCoolDownTimerV = 2
    end
  end

  def mov_right()
    if (@hitbox.y + @hitbox.length < 480 - 32)
	    3.times  do
	      @hitbox.y = @hitbox.y + 0.60
	      @hitbox.x = @hitbox.x + 2
      end   
      @movCoolDownTimerH = 2         
    end
  end

  def mov_left()
    if (@hitbox.x > 32)
    	3.times do 
	      @hitbox.y = @hitbox.y - 0.60
	      @hitbox.x = @hitbox.x - 2
      end  
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
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0], 2, 2)
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
