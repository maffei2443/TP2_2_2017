require 'gosu'

class Sprite
  def initialize(name)
    @spriteform = Gosu::Image.new(name)
  end
  def draw( x, y, z, px = 1, py = 1)
    @spriteform.draw(x, y - (2 * (z - 1)), z, px, py)
  end
end
