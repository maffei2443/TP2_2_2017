require 'gosu'

# Gerenciador de selecao de personagem
class CharSelectManager
  def initialize(listofoptions, minheight, marginoffset)
    @playerSelect = false
    @selectOpt = 1
    @playerOptionList = listofoptions
    @maxPlayerOptions = @playerOptionList.size
    @kbSelectBuff = 0
    @kbBuff2 = 0

    @@MINIMUM_HEIGHT = minheight
    @@MARGIN_OFFSET = marginoffset
    @@KEYBOARD_SELECTION_DELAY = 10
    @@BUTTON_SIZE = 48
  end

  attr_reader :playerSelect

  def select_char # Maneja selecao de personagem atraves da input
    @kbSelectBuff -= 1 if @kbSelectBuff > 0
    @kbBuff2 -= 1 if @kbBuff2 > 0
    if Gosu.button_down?(Gosu::KB_RETURN) && @kbBuff2.zero?
      @playerSelect = true
      return @playerOptionList[@selectOpt - 1]
    else
      return nil
    end
  end

  def deliberate_delay(amount) # Impede selecao de um menu de se propagar no outro devido a velocidade de processamento vs velocidade de tirar o dedo da input
    @kbBuff2 = amount
  end

  def move_selection
    if Gosu.button_down?(Gosu::KB_RIGHT) && (@selectOpt < @maxPlayerOptions) && @kbSelectBuff.zero?
      @selectOpt += 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end

    if Gosu.button_down?(Gosu::KB_LEFT) && (@selectOpt > 1) && @kbSelectBuff.zero?
      @selectOpt -= 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
    if Gosu.button_down?(Gosu::KB_DOWN) && (@selectOpt + 11 < @maxPlayerOptions) && @kbSelectBuff.zero?
      @selectOpt += 12
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
    if Gosu.button_down?(Gosu::KB_UP) && (@selectOpt - 11 > 1) && @kbSelectBuff.zero?
      @selectOpt -= 12
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
  end

  def update_option
    move_selection
    select_char
  end

  def reset_selection # Alteracao necessaria e suficiente para que o estado volte a tela de selecao inicial
    @playerSelect = false
    @selectOpt = 1
  end

  def draw
    indexaux = 0
    @playerOptionList.each do |option|
      indexaux += 1
      if indexaux == @selectOpt
        Gosu::Image.new('./programicons/' + 'selectorarrow.png').draw((((indexaux - 1) * @@BUTTON_SIZE) + @@MARGIN_OFFSET) - (((indexaux - 1) / 12) * (@@BUTTON_SIZE * 12)), @@MARGIN_OFFSET + (@@BUTTON_SIZE * ((indexaux - 1) / 12)), @@MINIMUM_HEIGHT + 1, 1, 1)
      end
      Gosu::Image.new('./img/' + option + '/' + option + 'button.png').draw(((indexaux - 1) * @@BUTTON_SIZE) + @@MARGIN_OFFSET - (((indexaux - 1) / 12) * (@@BUTTON_SIZE * 12)), @@MARGIN_OFFSET + (@@BUTTON_SIZE * ((indexaux - 1) / 12)), @@MINIMUM_HEIGHT, 1, 1)
    end
  end
end
