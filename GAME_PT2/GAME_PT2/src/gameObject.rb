require 'gosu'
require './box'
require './sprite'

# Atributos e metodos comuns a todos os objetos do jogo
class GameObject
  def initialize(name, x, y, zlist, width, length)
    @name = name
    @sprite = Sprite.new(name + '.png')
    @hitbox = Hitbox.new(x, y, zlist, width, length)
  end

  def draw
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
  end

  def hit?(obj)
    @hitbox.check_hit(obj.hitbox)
  end

  attr_reader :hitbox

  def update_frame; end

  def object_made
    nil
  end
end
