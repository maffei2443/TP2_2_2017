require 'gosu'
require './box'
require './sprite'

class GameObject # Qualquer objeto que irá existir precisa desses elementos de classe.

  def initialize(name, x, y, zlist, width, length)
    @name = name
    @sprite = Sprite.new(name + ".png")
    @hitbox = Hitbox.new(x,y,zlist,width,length)
  end

  def draw() # Objeto base só mostra o sprite.
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
  end

  def hit?(obj) # Pergunta ao objeto se ele colide com determinada área tridimensional.
    return @hitbox.check_hit(obj.hitbox)
  end

  attr_reader :hitbox

  def update_frame() # Lista de instruções que cada objeto deve fazer (a ser definida dentro da classe de cada objeto).
  end
  
end