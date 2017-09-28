$yellow = 0xff_ffff00
$orange = 0xff_ff8000

# class Dessert

#   def initialize(name, calories)
#     @name=name
#     @calories=calories
#   end

#   def healthy?
#     if(@calories<200)
#       return true
#     else
#       return false
#     end
#   end

#   def delicious?
#     return true
#   end

# end

# class JellyBean < Dessert

#   def initialize(name, calories, flavor)
#     @name=name
#     @calories=calories
#     @flavor=flavor
#   end

#   def delicious?
#     return true unless @flavor == "black licorice"
#   end

# end

require 'gosu'

class Sprite
  def initialize(name)
    @spriteform = Gosu::Image.new(name)
  end
  def draw( x, y, z)
    @spriteform.draw(x, y - (2 * (z - 1)), z, 1, 1)
  end
end

class Hitbox
  def initialize(x, y, zlist, width, length)
    @width = width
    @length = length
    @x = x
    @y = y
    @zlist = zlist
  end

  def x()
    @x
  end

  def x=(x)
    @x = x
  end

  def y()
    @y
  end

  def y=(y)
    @y = y
  end

  def zlist()
    @zlist
  end

  def width()
    @width
  end

  def length()
    @length
  end

  def check_hit(x_hit, y_hit, zlist_hit, width_hit, ln_hit)
    heightimp = false
    @zlist.each do |heightLevel|
      zlist_hit.each do
        |hitheight|
        if (heightLevel == hitheight)
          heightimp = true
        end
      end
    end
    if (((@x > x_hit + width_hit or x_hit > @x + @width) or (@y > y_hit + ln_hit or y_hit > @y + @length)) or (heightimp == false))
      return false
    else
      return true
    end
  end

end

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

  def hitbox()
    @hitbox
  end

  def execgl()
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
	      @hitbox.y = @hitbox.y + 1
	      @hitbox.x = @hitbox.x + 1
	      @movCoolDownTimerH = 2
	    end   
    end
  end

  def mov_left()
    if (@hitbox.x > 32)
    	3.times do 
	      @hitbox.y = @hitbox.y - 1
	      @hitbox.x = @hitbox.x - 1
	      @movCoolDownTimerH = 2
	    end  
    end
  end

  def execgl()			# Obs: nao faz sentigo execgl estar num obj do jogo ser responsavel pelo jogo. Tirar daqui
  						# Sugestao : update_falcon() E funcao externa paragame_loop
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

  def execgl()
    if @movCoolDownTimer > 0
      @movCoolDownTimer = @movCoolDownTimer - 1
    elsif(@movCoolDownTimer == 0)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimerH = 2
    end
  end

end

class DesertFalconGUI < Gosu::Window

  def initialize
    super 640, 480
    self.caption = "Desert Falcon"
    @font = Gosu::Font.new(self, "Arial", 32)
    @boopIterator = 0
    @sysTime = (Time.now.to_f * 1000)
    @FPScount = 0.0
    @objArray = []
    @objArray.insert(-1,Falcon.new("falcon", 32, 288, [25], 32, 32))
  end
  
  def make10tallObj(z1)
    return [z1,z1 + 1,z1 + 2,z1 + 3,z1 + 4,z1 + 5,z1 + 6,z1 + 7,z1 + 8,z1 + 9]
  end

  def update
    @objArray.each do |obj|
      obj.execgl
    end
    srand Random.new_seed
    if (rand(1000).to_i == 0)
      @objArray.insert(- 1,Hiero.new("hiero", 288 + (rand(320).to_i), 32, make10tallObj((rand(7).to_i + 1) * 5), 16, 16))
    end

    @objArray.each do |obj|
      if (obj.hit?(@objArray[0]) and obj.class  ==  Hiero.new("hiero",0,0,[0],0,0).class)
        @objArray.delete(obj)
      elsif (obj.hitbox.x < 32)
        @objArray.delete(obj)
      end
    end
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 46, :default)
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 46, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 46, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 46, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    
    # Desenha tela inicial
    title = "DESERT FALCON 2017 XD"
    pos = 32
    color = $yellow
    tam = title.length
    for i in 0..tam do
    	if title[i] == ' '
    		pos += 80
    	else
	    	@font.draw(title[i], pos, 0, 47, 1, 1, color, :default)
	    	pos += 20
	    	if color == $yellow
	    		color = $orange
	    	else
	    		color = $yellow
	    	end
	    end 
    end
    # Final da tela
    @font.draw("FPS := " + @FPScount.to_s, 32, 448, 47, 1, 1, 0xff_8000ff, :default)
    
    @boopIterator = @boopIterator + 1
    
    if (@boopIterator > 60)
      @font.draw("BOOP!", 513, 448, 47, 1, 1, 0xff_8000ff, :default)
    end

    if (@boopIterator  ==  120)
      @boopIterator = 0
      @FPScount = 120 / (((Time.now.to_f * 1000) - @sysTime) / 1000)
      @sysTime = (Time.now.to_f * 1000)
    end

    @objArray.each do |objecttorender|
      objecttorender.draw
    end
  end

end

DesertFalconGUI.new.show