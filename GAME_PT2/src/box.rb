# Define uma area tridimensional de colisao de um objeto.
class Hitbox
  def initialize(x, y, zlist, width, length)
    @width = width
    @length = length
    @x = x
    @y = y
    @zlist = zlist
  end

  attr_reader :width, :length, :zlist
  attr_accessor :x, :y

  # Checa se a hitbox tem intercessao com outra hitbox.
  def check_hit(box)
    heightimp = false
    @zlist.each do |heightLevel|
      box.zlist.each do |hitheight|
        heightimp = true if heightLevel == hitheight
      end
    end
    if ((@x > box.x + box.width || box.x > @x + @width) || (@y > box.y + box.length || box.y > @y + @length)) || (heightimp == false)
      return false
    else
      return true
    end
  end
end
