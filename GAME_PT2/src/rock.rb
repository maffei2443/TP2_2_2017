require './gameObject'

# Decoração para o cenario.
class Rock < GameObject
  attr_reader :movCoolDownTimer, :movCoolDownTimerH
  def initialize(name, x, y)
    @movCoolDownTimer = 0
    @name = name
    @sprite = Sprite.new('./rocks/' + name + '.png')
    @hitbox = Hitbox.new(x, y, [0], 0, 0)
  end

  def update_frame
    if @movCoolDownTimer > 0
      @movCoolDownTimer -= 1
    elsif @movCoolDownTimer.zero?
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimer = 1
    end
  end
end
