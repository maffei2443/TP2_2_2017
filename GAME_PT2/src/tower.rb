require './gameObject'

# Objeto que impede o progresso do jogador
class Tower < GameObject
  def initialize(x, y, zlist, width, length)
    @movCoolDownTimer = 0
    @name = 'tower'
    @sprite = Sprite.new('./programicons/' + @name + '.png')
    @hitbox = Hitbox.new(x, y, zlist, width, length)
  end

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y - 32, @hitbox.zlist[0])
    Gosu::Image.new('./programicons/' + @name + '.png').draw(@hitbox.x, @hitbox.y - 32, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
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
