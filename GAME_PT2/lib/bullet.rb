require_relative './gameObject'

# Objeto assassino, mata inimigos e personagem
class Bullet < GameObject
  def initialize(nameAuthor, x, y, zlist, falcOrNot)
    @movCoolDownTimer = 0
    @name = nameAuthor
    @sprite = Sprite.new('./img/' + nameAuthor + '/' + nameAuthor + 'projectile.png')
    @hitbox = Hitbox.new(x, y, zlist, 8, 8)
    @shooterFlag = falcOrNot # Flag diz quem atirou essa bala, serve para dizer a direcao e velocidade do projetil
  end

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new('./img/' + @name + '/' + @name + 'projectile.png').draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame
    @movCoolDownTimer -= 1 if @movCoolDownTimer > 0

    if @movCoolDownTimer.zero? # Velocidade absoluta diferente para igualar a velocidade relativa ao solo, velocidade de 2 em relacao ao solo em ambos os casos
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
