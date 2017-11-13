require 'gosu'

# Representacao visual de um objeto.
class Sprite
  def initialize(name)
    @spriteform = Gosu::Image.new(name)
  end

  def draw(x, y, z)
    @spriteform.draw(x, y - (2 * (z - 1)), z, 1, 1)
  end
end
