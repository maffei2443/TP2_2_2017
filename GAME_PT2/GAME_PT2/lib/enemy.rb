require_relative './gameObject'
require_relative './bullet'

# Objeto que age disparando projeteis contra o jogador
class Enemy < GameObject
  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimerH = 0
    @name = name
    @sprites = []
    (1..5).each do |i|
      @sprites.push(Sprite.new('./img/' + name + '/' + name + i.to_s + '.png'))
    end
    @hitbox = Hitbox.new(x, y, zlist, width, length)
    @spriteState = 1
    @spriteStateCounter = 0
    @objMade = nil
    @weaponCoolDown = 0
    @@SHOTFIREDELAY = 15
  end

  def draw
    @sprites[@spriteState - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new('./img/' + @name + '/' + @name + @spriteState.to_s + '.png').draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame# Move e possivelmente atira
    @spriteStateCounter += 1
    if @spriteStateCounter == 6
      @spriteStateCounter = 0
      @spriteState += 1
      @spriteState = 1 if @spriteState == 6
    end

    @movCoolDownTimerH -= 1 if @movCoolDownTimerH > 0
    if @movCoolDownTimerH.zero?
      @hitbox.y += 2
      @hitbox.x -= 2
      @movCoolDownTimerH = 1
    end

    @weaponCoolDown -= 1 if @weaponCoolDown >= 1

    if rand(60).to_i.zero? && @weaponCoolDown.zero?
      @objMade = Bullet.new(@name, @hitbox.x - 8, @hitbox.y + 16, [@hitbox.zlist[0] - 1, @hitbox.zlist[0], @hitbox.zlist[0] + 1], false)
      @weaponCoolDown = @@SHOTFIREDELAY
    end
  end

  def object_made # Verifica se tem um objeto de retorno para o jogo
    unless @objMade.nil?
      buff = @objMade
      @objMade = nil
      return buff
    end
    nil
  end
end
