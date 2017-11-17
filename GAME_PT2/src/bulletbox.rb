require './gameObject'

# Objeto que concede municao ao jogador quando coletado
class BulletBox < GameObject
  def initialize(name, x, y, ammount)
    @movCoolDownTimer = 0
    @name = name
    @sprite = Sprite.new('./programicons/' + name + '.png')
    @hitbox = Hitbox.new(x, y, [0, 1, 2, 3, 4, 5], 16, 16)
    @ammountContained = ammount
  end

  attr_reader :ammountContained

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
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
