require 'gosu'
require_relative './gameObject'
require_relative './box'
require_relative './falcon'
require_relative './hiero'
require_relative './tower'
require_relative './rock'
require_relative './enemy'
require_relative './bulletbox'
require_relative './bullet'
require_relative './charselectmanager'
require_relative './mainselectmanager'
require_relative './timecontrolmanager'
require_relative './vetor'
require_relative './readnamemanager'

# Janela do jogo, controla fluxo do loop principal do jogo
class DesertFalconGUI < Gosu::Window
  def initialize # Seta todos os atributos para executar a tela em estado inicial. Variaveis estaticas podem ser alteradas pra mudar caracteristicas da tela ou do jogo
    @@WINDOW_SIZE_X = 640
    @@WINDOW_SIZE_Y = 480
    super @@WINDOW_SIZE_X, @@WINDOW_SIZE_Y
    self.caption = 'Desert Falcon'
    @font = Gosu::Font.new(self, 'Arial', 32)
    @boopIterator = 0 # Itera boop para auxiliar a visualizar a passagem dos frames em periodos de latencia
    @sysTime = (Time.now.to_f * 1000) # Tempo em milisegundos medido de tempos em tempos para calcular framerate
    @FPScount = 0.0
    @objArray = []
    @rocks = 0
    @hieros = 0
    @towers = 0
    @enemys = 0
    @boxesOfAmmo = 0
    @falconHealth = 10
    @score = 0
    @nameholder = nil # Buffer para nome do jogador pro ranking, nil enquanto nenhuma letra for lida
    @readingname = false # True se estiver sendo lido um nome, fecha fluxo de menu e jogo quando true

    @@FALCON_RANGE_BEGIN = 288
    @@FALCON_RANGE_SIZE = 385
    @@HIERO_HEIGHT_RANGE = 26
    @@ENEMY_HEIGHT_RANGE = 31
    @@HIERO_WIDTH = 16
    @@MINIMUM_HEIGHT = 1
    @@MARGIN_OFFSET = 32
    @@ROCK_MAX_AMOUNT = 7
    @@HIERO_MAX_AMOUNT = 2
    @@TOWER_MAX_AMOUNT = 2
    @@ENEMY_MAX_AMOUNT = 2
    @@AMMOBOX_MAX_AMOUNT = 3
    @@FALCON_POSITION = 0
    @@FALCON_START_HEIGHT = 25
    @@FALCON_BOX_SIZE = 32
    @@HEADS_UP_DISPLAY_LAYER = 36

    @readingmanager = ReadNameManager.new
    @timingManager = TimeControlManager.new(@font, @@WINDOW_SIZE_Y, @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER)
    @selectionManager = CharSelectManager.new(%w[falcon milenium bat rocket arrow plane chopper desertwasp squirrel omniscientredorb jetpackturtle paperplane], @@MINIMUM_HEIGHT, @@MARGIN_OFFSET)
    @menuSelectionManager = MainSelectManager.new(%w[play ranking exit], @@MINIMUM_HEIGHT, @@MARGIN_OFFSET, @font)
  end

  def exitsoft # Sai para o menu, resetando o que for necessario
    if @menuSelectionManager.menuSelect == true && @selectionManager.playerSelect == true
      @readingname = true
    end
    @objArray.each do |obj|
      @objArray.delete(obj)
    end
    @objArray = []
    @rocks = 0
    @hieros = 0
    @towers = 0
    @enemys = 0
    @boxesOfAmmo = 0
    @falconHealth = 10
    @selectionManager.reset_selection
    @menuSelectionManager.reset_selection
  end

  def nameholder_draw
    stringaux = nil
    stringaux = if @nameholder.nil?
                  '___'
                elsif @nameholder.size == 1
                  @nameholder + '__'
                elsif @nameholder.size == 2
                  @nameholder + '_'
                else
                  @nameholder
                end
    stringaux
  end

  def make_10_tall_obj(z1) # Cria lista de alturas pra um objeto de altura 10
    [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4, z1 + 5, z1 + 6, z1 + 7, z1 + 8, z1 + 9]
  end

  def make_16_tower_obj # Altura base de qualquer tower
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
  end

  def make_5_tall_obj(z1) # Altura base de um enemy
    [z1, z1 + 1, z1 + 2, z1 + 3, z1 + 4]
  end

  def update
    if @menuSelectionManager.menuSelect == true && @selectionManager.playerSelect == true && @timingManager.paused == false && @timingManager.slowmo == false
      @objArray.each do |obj| # Permite que cada objeto execute suas acoes e crie outros objetos pro jogo
        obj.update_frame
        newobj = obj.object_made
        @objArray.insert(- 1, newobj) unless newobj.nil?
      end
      srand Random.new_seed
      # Criacao de novos objetos com rand
      if rand(300).to_i.zero? && @hieros < @@HIERO_MAX_AMOUNT
        raux = rand(3).to_i
        if raux.zero?
          @objArray.insert(- 1, Hiero.new('hieroruby', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, make_10_tall_obj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))
        elsif raux == 1
          @objArray.insert(- 1, Hiero.new('hieroreeds', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, make_10_tall_obj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))
        else
          @objArray.insert(- 1, Hiero.new('ankh', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, make_10_tall_obj(rand(@@HIERO_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), @@HIERO_WIDTH, @@HIERO_WIDTH))
        end
        @hieros += 1
      end

      if rand(300).to_i.zero? && @towers < @@TOWER_MAX_AMOUNT
        @objArray.insert(- 1, Tower.new(@@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, make_16_tower_obj, @@HIERO_WIDTH, @@HIERO_WIDTH))
        @towers += 1
      end

      if rand(300).to_i.zero? && @boxesOfAmmo < @@AMMOBOX_MAX_AMOUNT
        raux = rand(3).to_i
        @objArray.insert(- 1, BulletBox.new('ammobox', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, (raux + 1) * @objArray[0].clipsize))
        @boxesOfAmmo += 1
      end

      if rand(300).to_i.zero? && @enemys < @@ENEMY_MAX_AMOUNT
        @objArray.insert(- 1, Enemy.new('enemybird', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET, make_5_tall_obj(rand(@@ENEMY_HEIGHT_RANGE).to_i + @@MINIMUM_HEIGHT), 16, 16))
        @enemys += 1
      end

      if rand(60).to_i.zero? && @rocks < @@ROCK_MAX_AMOUNT
        raux = rand(3).to_i
        if raux.zero?
          @objArray.insert(- 1, Rock.new('slate', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET))
        elsif raux == 1
          @objArray.insert(- 1, Rock.new('granite', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET))
        else
          @objArray.insert(- 1, Rock.new('sandstone', @@FALCON_RANGE_BEGIN + rand(@@FALCON_RANGE_SIZE).to_i, @@MARGIN_OFFSET))
        end
        @rocks += 1
      end

      @objArray.each do |obj| # Trata todas as colisoes nesse bloco e executa as consequencias dessas colisoes
        if obj.instance_of?(Enemy) && obj.hitbox.x > 1
          @objArray.each do |objonenemy|
            next unless objonenemy.hit?(obj) && objonenemy.instance_of?(Bullet)
            @objArray.delete(obj)
            @objArray.delete(objonenemy)
            @enemys -= 1
            @score += 20
          end
        elsif obj.hit?(@objArray[@@FALCON_POSITION]) && obj.instance_of?(Hiero)
          @objArray.delete(obj)
          @hieros -= 1
          @score += 1
        elsif obj.hit?(@objArray[@@FALCON_POSITION]) && obj.instance_of?(BulletBox)
          @objArray[@@FALCON_POSITION].add_ammo(obj.ammountContained)
          @objArray.delete(obj)
          @boxesOfAmmo -= 1
        elsif obj.hit?(@objArray[@@FALCON_POSITION]) && obj.instance_of?(Bullet)
          @falconHealth -= 1
          @objArray.delete(obj)
        elsif obj.hit?(@objArray[@@FALCON_POSITION]) && obj.instance_of?(Tower)
          @falconHealth -= 1
        elsif obj.hitbox.x < 1 || obj.hitbox.y < 1
          if obj.instance_of?(Hiero)
            @hieros -= 1
          elsif obj.instance_of?(Rock)
            @rocks -= 1
          elsif obj.instance_of?(BulletBox)
            @boxesOfAmmo -= 1
          elsif obj.instance_of?(Enemy)
            @enemys -= 1
          elsif obj.instance_of?(Tower)
            @towers -= 1
          end
          @objArray.delete(obj)
        end
      end
    elsif @menuSelectionManager.menuSelect == true && @selectionManager.playerSelect == false
      opt = @selectionManager.update_option
      unless opt.nil?
        @objArray.insert(-1, Falcon.new(opt, @@MARGIN_OFFSET, @@FALCON_RANGE_BEGIN, [@@FALCON_START_HEIGHT], @@FALCON_BOX_SIZE, @@FALCON_BOX_SIZE))
      end
    elsif @readingname == true
      if !@nameholder.nil? && (@nameholder.size == 3)
        ranks = le_rk('r')
        ranks.insert(-1, [@score, @nameholder])
        write('r', ranks)
        @score = 0
        @nameholder = nil
        @readingname = false
      else
        letter = @readingmanager.read
        if @nameholder.nil?
          @nameholder = letter
        elsif !letter.nil?
          @nameholder += letter
        end
      end
    elsif @menuSelectionManager.menuSelect == false
      @menuSelectionManager.update_option
      if @menuSelectionManager.menuSelect == true
        @selectionManager.deliberate_delay(100)
      end
    end
    @timingManager.update_timing
    exitsoft if Gosu.button_down?(Gosu::KB_ESCAPE)
    exitsoft if @falconHealth.zero?
  end

  def draw
    Gosu.draw_rect(0, 0, @@WINDOW_SIZE_X, @@MARGIN_OFFSET, Gosu::Color.argb(0xff_000000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(0, 0, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(@@WINDOW_SIZE_X - @@MARGIN_OFFSET, 0, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y, Gosu::Color.argb(0xff_a00000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(0, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@WINDOW_SIZE_X, @@MARGIN_OFFSET, Gosu::Color.argb(0xff_000000), @@HEADS_UP_DISPLAY_LAYER, :default)
    Gosu.draw_rect(0, @@MARGIN_OFFSET, @@WINDOW_SIZE_X, @@WINDOW_SIZE_Y - (2 * @@MARGIN_OFFSET), Gosu::Color.argb(0xff_F0C88C), 0, :default)

    title = 'DESERT FALCON 2017 XD'
    pos = @@MARGIN_OFFSET
    yellow = 0xff_ffff00
    orange = 0xff_ff8000
    color = yellow
    tam = title.length
    for i in 0...tam
      if title[i] == ' '
        pos += 70
      else
        @font.draw(title[i], pos, 0, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, color, :default)
        pos += 20
        color = if color == yellow
                  orange
                else
                  yellow
                end
      end
    end

    @timingManager.draw

    if @menuSelectionManager.menuSelect == true && @selectionManager.playerSelect == true
      @objArray.each(&:draw)
      @font.draw('SCORE: ' + @score.to_s, 450, (480 - 96) - 64, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_ff00ff, :default)
      @font.draw('HP: ' + @falconHealth.to_s, 450, (480 - 96) - 32, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_ff00ff, :default)
      @font.draw('AMMO: ' + @objArray[@@FALCON_POSITION].ammo.to_s, 450, 480 - 64, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_ff00ff, :default)
      @font.draw('GUN: ' + @objArray[@@FALCON_POSITION].loadedAmmo.to_s + '/' + @objArray[@@FALCON_POSITION].clipsize.to_s, 450, 480 - 96, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_ff00ff, :default)
    elsif @menuSelectionManager.menuSelect == true && @selectionManager.playerSelect == false
      @selectionManager.draw
    elsif @readingname == true
      @font.draw(nameholder_draw, @@MARGIN_OFFSET, @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_ff00ff, :default)
    elsif @menuSelectionManager.menuSelect == false
      @menuSelectionManager.draw
    end
  end
end
