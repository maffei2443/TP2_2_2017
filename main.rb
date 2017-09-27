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
    @playerSelect = false
    @selectopt = 1
    @font = Gosu::Font.new(self, "Arial", 32)
    @boopIterator = 0
    @sysTime = (Time.now.to_f * 1000)
    @FPScount = 0.0
    @objArray = []
    @rocks = 0
    @hieros = 0
    @playerOptionList = ["falcon", "milenium", "bat", "rocket", "arrow", "plane", "chopper", "desertwasp", "squirrel"]
    @maxplayeroptions = 9
    @kbSelectBuff = 0
  end
  
  def make10tallObj(z1)
    return [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4, z1 + 5, z1 + 6, z1 + 7, z1 + 8, z1 + 9]
  end

  def update
    if (@playerSelect == true)
      @objArray.each do |obj|
        obj.update_frame
      end
      srand Random.new_seed
      if (rand(300).to_i == 0 and @hieros < 2)
        @objArray.insert(- 1,Hiero.new("hiero", 288 + (rand(385).to_i), 32, make10tallObj(rand(26).to_i + 1), 16, 16))
        @hieros += 1
      end
      if (rand(60).to_i == 0 and @rocks <7)
        raux = rand(3).to_i
        if (raux == 0)
          @objArray.insert(- 1,Rock.new("slate", 288 + (rand(385).to_i), 32))
        elsif(raux == 1)
          @objArray.insert(- 1,Rock.new("granite", 288 + (rand(385).to_i), 32))
        else
          @objArray.insert(- 1,Rock.new("sandstone", 288 + (rand(385).to_i), 32))
        end
        @rocks += 1
      end
      @objArray.each do |obj|
        if (obj.hit?(@objArray[0]) and obj.class  ==  Hiero.new("hiero",0,0,[0],0,0).class)
          @objArray.delete(obj)
          @hieros -= 1
        elsif (obj.hitbox.x < 1)
          if(obj.class == Hiero.new("hiero",0,0,[0],0,0).class)
          	@hieros -= 1
          elsif(obj.class == Rock.new("slate",0,0).class)
    		    @rocks -= 1
          end	
          @objArray.delete(obj)
        end
      end
    else
      if (@kbSelectBuff > 0)
        @kbSelectBuff = @kbSelectBuff - 1
      end
      if (Gosu.button_down? Gosu::KB_UP)
        @objArray.insert(-1,Falcon.new(@playerOptionList[@selectopt-1], 32, 288, [25], 32, 32))
        @playerSelect = true
      end
      if (Gosu.button_down? Gosu::KB_RIGHT) and (@selectopt < @maxplayeroptions) and (@kbSelectBuff == 0)
        @selectopt = @selectopt + 1
        @kbSelectBuff = 5
      end
      if (Gosu.button_down? Gosu::KB_LEFT) and (@selectopt > 1) and (@kbSelectBuff == 0)
        @selectopt = @selectopt - 1
        @kbSelectBuff = 5
      end
    end
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 36, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    
    # Desenha tela inicial
    title = "DESERT FALCON 2017 XD"
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
    @font.draw("FPS := " + @FPScount.to_s, 32, 448, 37, 1, 1, 0xff_8000ff, :default)
    
    @boopIterator = @boopIterator + 1
    
    if (@boopIterator > 60)
	   @font.draw("BOOP!", 513, 448, 37, 1, 1, 0xff_8000ff, :default)
    end
    if (@boopIterator  ==  120)
      @boopIterator = 0
      @FPScount = 120 / (((Time.now.to_f * 1000) - @sysTime) / 1000)
      @sysTime = (Time.now.to_f * 1000)
    end
    if (@playerSelect == true)
      @objArray.each do |objecttorender|
        objecttorender.draw
      end
    else
      indexaux = 0
      @playerOptionList.each do
        |option|
        indexaux = indexaux + 1
        Gosu::Image.new("button.png").draw(((indexaux - 1) * 48) + 32, 32, 1, 1, 1)
        if (indexaux == @selectopt)
          Gosu::Image.new("selectorarrow.png").draw(((indexaux - 1) * 48) + 32, 80, 1, 1, 1)
        end
        Gosu::Image.new(option + "1.png").draw(((indexaux - 1) * 48) + 32 + 8, 32 + 8, 1, 1, 1)
      end
    end
  end
end

DesertFalconGUI.new.show