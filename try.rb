class Dessert
  def initialize(name, calories)
    @name=name
    @calories=calories
  end
  def healthy?
    if(@calories<200)
      return true
    else
      return false
    end
  end
  def delicious?
    return true
  end
end

class JellyBean < Dessert
  def initialize(name, calories, flavor)
    @name=name
    @calories=calories
    @flavor=flavor
  end
  def delicious?
    return true unless @flavor=="black licorice"
  end
end

require 'gosu'

class Sprite
  def initialize(name)
    @spriteform = Gosu::Image.new(name)
  end
  def draw( x, y, z)
    @spriteform.draw(x, y-(5*(z-1)), z, 1, 1)
  end
end

class Hitbox
  def initialize(x, y, zlist, fat, length)
    @fat=fat
    @length=length
    @x=x
    @y=y
    @zlist=zlist
  end
  def x()
    @x
  end
  def x=(x)
    @x=x
  end
  def y()
    @y
  end
  def y=(y)
    @y=y
  end
  def zlist()
    @zlist
  end
  def width()
    @fat
  end
  def length()
    @length
  end
  def check_hit(x_hit, y_hit, zlist_hit, fat_hit, ln_hit)
    heightimp = false
    @zlist.each do
      |heightlevel|
      zlist_hit each do
        |hitheight|
        if (heightlevel==hitheight)
          heightimp = true
        end
      end
    end
    if (((@x<x_hit+fat_hit or x_hit<@x+@fat)and(@y<y_hit+ln_hit or y_hit<@y+@length))or(heightimp==false))
      return false
    else
      return true
    end
  end
end

class GameObject
  def initialize(name, x, y, zlist, fat, length)
    @name=name
    @sprite = Sprite.new(name+".png")
    @hitbox=Hitbox.new(x,y,zlist,fat,length)
  end
  def draw()
    @sprite.draw(@x, @y, @z)
  end
  def hit?(obj)
    return @hitbox.checkhit(obj.hitbox.x, obj.hitbox.y, obj.hitbox.zlist, obj.hitbox.width, obj.hitbox.length)
  end
  def hitbox()
    @hitbox
  end
  def frame_turn()
  end
end

class Falcon < GameObject
  def initialize(name, x, y, zlist, fat, length)
    @movcooldowntimer=0
    @name=name
    @sprite = Sprite.new(name+".png")
    @hitbox=Hitbox.new(x,y,zlist,fat,length)
  end
  def mov_up()
    if (@hitbox.zlist[0]<=8)
      @hitbox.zlist[0]=@hitbox.zlist[0]+1
      @movcooldowntimer=10
    end
  end
  def draw()
    @sprite.draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0])
    Gosu::Image.new("shadow.png").draw(@hitbox.x, @hitbox.y, @hitbox.zlist[0]-1, 1, 1, 0xff_464678, :default)
  end
  def mov_down()
    if (@hitbox.zlist[0]>1)
      @hitbox.zlist[0]=@hitbox.zlist[0]-1
      @movcooldowntimer=10
    end
  end
  def mov_right()
    if (@hitbox.y+@hitbox.length<479-32)
      @hitbox.y=@hitbox.y+1
      @hitbox.x=@hitbox.x+1
      @movcooldowntimer=3
    end
  end
  def mov_left()
    if (@hitbox.x>32)
      @hitbox.y=@hitbox.y-1
      @hitbox.x=@hitbox.x-1
      @movcooldowntimer=3
    end
  end
  def execgl()
    if @movcooldowntimer>0
      @movcooldowntimer = @movcooldowntimer-1
    end
    if ((Gosu.button_down? Gosu::KB_UP) && (@movcooldowntimer==0))
      self.mov_up
    end
    if ((Gosu.button_down? Gosu::KB_DOWN) && (@movcooldowntimer==0))
      self.mov_down
    end
    if ((Gosu.button_down? Gosu::KB_RIGHT) && (@movcooldowntimer==0))
      self.mov_right
    end
    if ((Gosu.button_down? Gosu::KB_LEFT) && (@movcooldowntimer==0))
      self.mov_left
    end
  end
end

class DesertFalconGUI < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Desert Falcon"
    @font = Gosu::Font.new(self, "Arial", 32)
    @boopiterator = 0
    @systime = (Time.now.to_f * 1000)
    @FPScount=0.0
    @objarray=[]
    @objarray.insert(-1,Falcon.new("falcon", 0, 100, [9], 0, 0))
  end
  
  def update
    @objarray.each do
      |obj|
      obj.execgl
    end
  end
  
  def draw
    Gosu.draw_rect(0, 0, 640, 32, Gosu::Color.argb(0xff_a00000), 10, :default)
    Gosu.draw_rect(0, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 10, :default)
    Gosu.draw_rect(608, 0, 32, 480, Gosu::Color.argb(0xff_a00000), 10, :default)
    Gosu.draw_rect(0, 448, 640, 32, Gosu::Color.argb(0xff_a00000), 10, :default)
    Gosu.draw_rect(32, 32, 576, 416, Gosu::Color.argb(0xff_F0C88C), 0, :default)
    @font.draw("D", 32, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("E", 52, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("S", 72, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("E", 92, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("R", 112, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("T", 132, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("F", 212, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("A", 232, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("L", 252, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("C", 272, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("O", 292, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("N", 312, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("2", 392, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("0", 412, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("1", 432, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("7", 452, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw(":", 582, 0, 11, 1, 1, 0xff_ffff00, :default)
    @font.draw("3", 592, 0, 11, 1, 1, 0xff_ff8000, :default)
    @font.draw("FPS := "+@FPScount.to_s, 32, 448, 11, 1, 1, 0xff_8000ff, :default)
    @boopiterator = @boopiterator + 1
    if (@boopiterator >60)
      @font.draw("BOOP!", 513, 448, 11, 1, 1, 0xff_8000ff, :default)
    end
    if (@boopiterator == 120)
      @boopiterator=0
      @FPScount=120/(((Time.now.to_f * 1000)-@systime)/1000)
      @systime = (Time.now.to_f * 1000)
    end
    @objarray.each do
      |objecttorender|
      objecttorender.draw
    end
  end
end

DesertFalconGUI.new.show