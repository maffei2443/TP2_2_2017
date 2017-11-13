require './gameObject'

# Objeto assassino, mata inimigos e personagem
class Bullet < GameObject
  def initialize(nameAuthor, x, y, zlist, falcOrNot)
    @movCoolDownTimer = 0
    @name = nameAuthor
    @sprite = Sprite.new('./img/' + nameAuthor + '/' + nameAuthor + 'projectile.png')
    @hitbox = Hitbox.new(x, y, zlist, 8, 8)
    @shooterFlag = falcOrNot
  end

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new('./img/' + @name + '/' + @name + 'projectile.png').draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame
    @movCoolDownTimer -= 1 if @movCoolDownTimer > 0

    if @movCoolDownTimer.zero?
      if @shooterFlag == false
        @hitbox.y += 3
        @hitbox.x -= 3
      else
        @hitbox.y -= 1
        @hitbox.x += 1
      end
      @movCoolDownTimer = 1

    end
  end
end
