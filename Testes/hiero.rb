require './gameObject'


class Hiero < GameObject # Objeto objetivo do jogador; pode ser coletado pelo falcon e se move em direção ao canto inferior esquerdo.

  def initialize(name, x, y, zlist, width, length)
    @movCoolDownTimer = 0 # Temporizador do movimento dos hieros.
    @name = name
    @sprite = Sprite.new("./hieros/" + name + ".png") # Imagem do hiero encapsulada em um sprite.
    @hitbox = Hitbox.new(x,y,zlist,width,length) # Hitbox do hiero.
  end

  def draw() # Objeto renderiza seu sprite e uma sombra do seu sprite.
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new("./hieros/" + @name + ".png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0] - 1, 1, 1, 0xff_464678, :default)
  end

  def update_frame() # A cada frame, caso o temporizador esteja zerado, o hiero deve se mover na diagonal para gerar impressão de movimento do personagem. O temporizador impede que ele se movimente rápido demais.
    if @movCoolDownTimer > 0
      @movCoolDownTimer -= 1
    
    elsif(@movCoolDownTimer == 0)
      @hitbox.y += 1
      @hitbox.x -= 1
      @movCoolDownTimer = 1

    end
  end

end
