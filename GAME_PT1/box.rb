class Hitbox # Define uma área tridimensional (limitada em 'x' e 'y' a retângulos e sem limitaçẽes em 'z' (onde está presente um objeto do jogo).
  def initialize(x, y, zlist, width, length)
    @width = width
    @length = length
    @x = x # Ponto inicial x > 32.
    @y = y # Ponto inicial y > 480 - 32.
    @zlist = zlist # Alturas ocupadas pelo objeto.
  end

  attr_reader   :width, :length, :zlist # Zlist não é atribute acessor por que é um array e não precisa ser acessor pra alterar os elementos dentro do array.
  attr_accessor :x, :y # Precisa ser acessado para movimentar a hitbox.

  def check_hit(box) # Checa se a hitbox tem overlap com outra hitbox.
    heightimp = false
    @zlist.each do |heightLevel| # Checa impacto de altura; se não tem impacto de altura, um objeto no máximo passa por cima do outro sem colidir.
      box.zlist.each do |hitheight|
        if (heightLevel == hitheight) # Qualquer nível de altura ser igual a qualquer nivel de altura da outra hitbox é o bastante pra ter impacto de altura.
          heightimp = true
        end
      end
    end
    if (((@x > box.x + box.width or box.x > @x + @width) or (@y > box.y + box.length or box.y > @y + @length)) or (heightimp == false)) # Se não tem overlap bidimensional ou não há impacto de altura ou não tem colisão.
      return false
    else
      return true
    end
  end

end