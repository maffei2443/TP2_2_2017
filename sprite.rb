require 'gosu'

class Sprite #manifestação vizual de um objeto
  def initialize(name)
    @spriteform = Gosu::Image.new(name)
  end
  def draw( x, y, z) #printa o sprite com desvio vizual de altura
    @spriteform.draw(x, y - (2 * (z - 1)), z, 1, 1)
  end
end
