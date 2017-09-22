class Hitbox
  def initialize(x, y, zlist, width, length)
    @width = width
    @length = length
    @x = x
    @y = y
    @zlist = zlist
  end

  attr_reader   :width, :length, :zlist
  attr_accessor :x, :y

  def check_hit(x_hit, y_hit, zlist_hit, width_hit, ln_hit)
    heightimp = false
    @zlist.each do |heightLevel|
      zlist_hit.each do |hitheight|
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