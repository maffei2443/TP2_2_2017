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
require './gameObject'

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
    @rocks = 0
    @hieros = 0
  end
  
  def make10tallObj(z1)
    return [z1 - 5, z1, z1 + 5]
  end

def update

    @objArray.each do |obj|
      obj.update_frame
    end

    srand Random.new_seed
    if (rand(300).to_i == 0 and @hieros < 6)
      @objArray.insert(- 1,Hiero.new("hiero", 288 + (rand(400).to_i), 32, make10tallObj((rand(7).to_i + 1) * 5), 16, 16))
      @hieros += 1
    end

    if (rand(75).to_i == 0 and @rocks < 4)
      @objArray.insert(- 1,Rock.new("rock_smallll", 288 + (rand(400).to_i), 32))
      @rocks += 1
    end

    @objArray.each do |obj|
      if (obj.hit?(@objArray[0]) and obj.class  ==  Hiero.new("hiero",0,0,[0],0,0).class)
        @objArray.delete(obj)
        @hieros -= 1
      elsif (obj.hitbox.x < 32)
      	if(obj.class == Hiero.new("hiero",0,0,[0],0,0).class)
        	@hieros -= 1
        elsif(obj.class == Rock.new("rock_smallll",0,0).class)
			@rocks -= 1
        end	
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