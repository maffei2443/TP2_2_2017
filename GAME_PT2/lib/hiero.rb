require_relative './gameObject'

# Objeto objetivo do jogador, pode ser coletado pelo jogador
class Hiero < GameObject
  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimer = 0
    @name = name
    @sprite = Sprite.new('./hieros/' + name + '.png')
    @hitbox = Hitbox.new(x, y, zlist, width, length)
  end

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new('./hieros/' + @name + '.png').draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame
    if @movCoolDownTimer > 0
      @movCoolDownTimer -= 1

    elsif @movCoolDownTimer.zero?
      @hitbox.y += 1
      @hitbox.x -= 1
      @movCoolDownTimer = 1

    end
  end
end
