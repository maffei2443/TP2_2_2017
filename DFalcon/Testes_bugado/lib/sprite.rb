require 'gosu'

class Sprite 			# Manifestação visual de um objeto.

  def initialize(name)
  	@x = -1
  	@y = -2
  	@z = -3
    @spriteform = Gosu::Image.new(name)
  end

  attr_reader   :x, :y, :z
  
  def draw( x, y, z) 	# Printa o sprite com desvio visual de altura.
    @spriteform.draw(x, y - (2 * (z - 1)), z, 1, 1)
    @x = x
    @y = y
    @z = z
  end
end