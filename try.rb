class Dessert	
  def initialize(name, calories)
    @name=name
    @calories=calories
  end
  def healthy?
    if(@calories<200)
      return true
    else
      return false
    end
  end
  def delicious?
    return true
  end
end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    @name=name
    @calories=calories
    @flavor=flavor
  end
  def delicious?
    return true unless @flavor=="black licorice"
  end
end

require 'gosu'

class DesertFalconGUI < Gosu::Window
  def initialize
    super 640, 480 
    self.caption = "Desert Falcon"
    @font = Gosu::Font.new(self, "Arial", 32)
  end
  
  def update
    # ...
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 0, :default)
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 0, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 0, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 0, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    @font.draw("D", 32, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("E", 52, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("S", 72, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("E", 92, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("R", 112, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("T", 132, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("F", 212, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("A", 232, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("L", 252, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("C", 272, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("O", 292, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("N", 312, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("2", 392, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("0", 412, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw("1", 432, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("7", 452, 0, 10, 1, 1, 0xff_ff8000, :default)
    @font.draw(":", 582, 0, 10, 1, 1, 0xff_ffff00, :default)
    @font.draw("3", 592, 0, 10, 1, 1, 0xff_ff8000, :default)
  end
end

DesertFalconGUI.new.show