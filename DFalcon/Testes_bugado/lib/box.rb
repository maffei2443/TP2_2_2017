class Hitbox
  def initialize(x, y, zlist, width, length)
    @width = width
    @length = length
    @x = x # Ponto inicial x.
    @y = y # Ponto inicial y.
    @zlist = zlist # Alturas ocupadas pelo objeto.
  end

  attr_reader   :width, :length, :zlist # zlist não é atribute acessor por que é um array; não precisa ser acessor pra alterar os elementos dentro do array.
  attr_accessor :x, :y # Precisa ser acessado para movimentar a hitbox.

  def check_hit(x_hit, y_hit, zlist_hit, width_hit, ln_hit) # Checa se a hitbox tem overlap com outra hitbox, a partir dos elementos internos da outra.
    heightimp = false
    @zlist.each do |heightLevel| # Checa impacto de altura, se não tem impacto de altura, um objeto no maximo passa por cima do outro sem colidir.
      zlist_hit.each do |hitheight|
        if (heightLevel == hitheight) # Qualquer nivel de altura ser igual a qualquer nivel de altura da outra hitbox é o bastante pra ter impacto de altura.
          heightimp = true
        end
      end
    end
    if (((@x > x_hit + width_hit or x_hit > @x + @width) or (@y > y_hit + ln_hit or y_hit > @y + @length)) or (heightimp == false))
       # Se não tem sobreposição bidimensional ou não há impacto de altura, não tem colisão.
      return false
    else
      return true
    end
  end

end