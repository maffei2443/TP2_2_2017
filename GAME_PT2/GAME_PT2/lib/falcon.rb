require_relative './gameObject'
require_relative './bullet'

# Objeto controlado pelo player, não necessariamente um pásssaro.
class Falcon < GameObject
  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimerV = 0
    @movCoolDownTimerH = 0
    @name = name
    @sprites = [Sprite.new('./img/' + name + '/' + name + '1.png'), Sprite.new('./img/' + name + '/' + name + '2.png'), Sprite.new('./img/' + name + '/' + name + '3.png'), Sprite.new('./img/' + name + '/' + name + '4.png'), Sprite.new('./img/' + name + '/' + name + '5.png')]
    @hitbox = Hitbox.new(x, y, zlist, width, length)
    @spriteState = 1
    @spriteStateCounter = 0
    @objMade = nil
    @ammo = 0
    @loadedAmmo = 10
    @weaponCoolDown = 0
    @@CLIPSIZE = 10
    @@SHOTFIREDELAY = 15
    @@RELOADDELAY = 120
  end

  attr_reader :loadedAmmo, :CLIPSIZE, :ammo

  def clipsize
    @@CLIPSIZE
  end

  def draw
    @sprites[@spriteState - 1].draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new('./img/' + @name + '/' + @name + @spriteState.to_s + '.png').draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def mov_up
    if @hitbox.zlist[0] < 35
      @hitbox.zlist[0] = @hitbox.zlist[0] + 1
      @movCoolDownTimerV = 1
    end
  end

  def mov_down
    if @hitbox.zlist[0] > 1
      @hitbox.zlist[0] = @hitbox.zlist[0] - 1
      @movCoolDownTimerV = 1
    end
  end

  def mov_right
    if @hitbox.y + @hitbox.length < 480 - 32
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x + 2
      @movCoolDownTimerH = 1
    end
  end

  def mov_left
    if @hitbox.x > 32
      @hitbox.y -= 1
      @hitbox.x -= 2
      @movCoolDownTimerH = 1
    end
  end

  def update_frame
    @spriteStateCounter += 1
    if @spriteStateCounter == 6
      @spriteStateCounter = 0
      @spriteState += 1
      @spriteState = 1 if @spriteState == 6
    end

    @movCoolDownTimerV -= 1 if @movCoolDownTimerV > 0

    @movCoolDownTimerH -= 1 if @movCoolDownTimerH > 0
    mov_up if Gosu.button_down?(Gosu::KB_UP) && @movCoolDownTimerV.zero?

    mov_down if Gosu.button_down?(Gosu::KB_DOWN) && @movCoolDownTimerV.zero?

    @angling = 0
    mov_right if Gosu.button_down?(Gosu::KB_RIGHT) && @movCoolDownTimerH.zero?

    mov_left if Gosu.button_down?(Gosu::KB_LEFT) && @movCoolDownTimerH.zero?

    @weaponCoolDown -= 1 if @weaponCoolDown >= 1

    if Gosu.button_down?(Gosu::KB_X) && @weaponCoolDown.zero? && (@loadedAmmo >= 1)
      @objMade = Bullet.new(@name, @hitbox.x + 32, @hitbox.y - 8, [@hitbox.zlist[0] - 1, @hitbox.zlist[0], @hitbox.zlist[0] + 1], true)
      @weaponCoolDown = @@SHOTFIREDELAY
      @loadedAmmo -= 1
    end

    reload if Gosu.button_down?(Gosu::KB_R) && @weaponCoolDown.zero?
  end

  def reload # Logica de recarregar o falcon
    if @@CLIPSIZE > @loadedAmmo
      if @ammo >= @@CLIPSIZE - @loadedAmmo
        @ammo -= (@@CLIPSIZE - @loadedAmmo)
        @loadedAmmo = @@CLIPSIZE
      else
        @loadedAmmo += @ammo
        @ammo = 0
      end
      @weaponCoolDown = 5 * @@SHOTFIREDELAY
    end
  end

  def add_ammo(ammount)
    @ammo += ammount
  end

  def object_made # Verifica e retorna objetos criados pelo falcon (tiro)
    unless @objMade.nil?
      buff = @objMade
      @objMade = nil
      return buff
    end
    nil
  end
end
