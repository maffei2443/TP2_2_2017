require './gameObject'


class Rock < GameObject # Decoração para o fundo da tela.
  attr_reader :movCoolDownTimer, :movCoolDownTimerH
  def initialize(name, x, y)
    @movCoolDownTimer = 0 # Pedra se move com velocidade controlada.
    @name = name # Cada nome gera uma pedra diferente.
    @sprite = Sprite.new("./rocks/" + name + ".png") # Imagem da pedra de determinado nome.
    @hitbox = Hitbox.new(x,y,[0],0,0) # Pedra tem hitbox sempre no chão e sem largura, pois é só decorativa.
  end

  def update_frame() # Pedra se move para gerar impressão de movimento do jogador.
    if @movCoolDownTimer > 0
      @movCoolDownTimer -= 1
    elsif(@movCoolDownTimer == 0)
      @hitbox.y = @hitbox.y + 1
      @hitbox.x = @hitbox.x - 1
      @movCoolDownTimer = 1
    end
  end

end
