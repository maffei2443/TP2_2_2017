require 'gosu'
require_relative './vetor'

# Menu inicial.
class MainSelectManager
  def initialize(listofoptions, minheight, marginoffset, font)
    @menuSelect = false
    @selectOpt = 1
    @playerOptionList = listofoptions
    @maxPlayerOptions = @playerOptionList.size
    @kbSelectBuff = 0
    @font = font
    @selection = nil
    @@MINIMUM_HEIGHT = minheight
    @@MARGIN_OFFSET = marginoffset
    @@KEYBOARD_SELECTION_DELAY = 10
    @@BUTTON_SIZE = 48
  end

  attr_reader :menuSelect

  def select_opt
    @kbSelectBuff -= 1 if @kbSelectBuff > 0
    if (Gosu.button_down? Gosu::KB_RETURN) && (@selection != 'ranking')
      @selection = @playerOptionList[@selectOpt - 1]
      @selectOpt = 1
    else
      return nil
    end
  end

  def move_selection
    sizerank = le_rk('r').size
    if Gosu.button_down?(Gosu::KB_DOWN) && (((@selectOpt < @maxPlayerOptions) && (@selection != 'ranking')) || ((@selectOpt < sizerank) && (@selection == 'ranking'))) && @kbSelectBuff.zero?
      @selectOpt += 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end

    if Gosu.button_down?(Gosu::KB_UP) && (@selectOpt > 1) && @kbSelectBuff.zero?
      @selectOpt -= 1
      @kbSelectBuff = @@KEYBOARD_SELECTION_DELAY
    end
  end

  def update_option
    move_selection
    select_opt
    if @selection == 'exit'
      exit
    elsif @selection == 'play'
      @menuSelect = true
    end
  end

  def reset_selection
    @menuSelect = false
    @selectOpt = 1
    @selection = nil
  end

  def draw
    indexaux = 0
    indrank = 0
    if @selection != 'ranking'
      @playerOptionList.each do |option|
        indexaux += 1
        if indexaux == @selectOpt
          Gosu::Image.new('./programicons/' + 'selectorarrow.png').draw(@@MARGIN_OFFSET, @@MARGIN_OFFSET + (@@BUTTON_SIZE * (indexaux - 1)), @@MINIMUM_HEIGHT + 1, 1, 1)
        end
        @font.draw(option, @@MARGIN_OFFSET + @@BUTTON_SIZE, @@MARGIN_OFFSET + (@@BUTTON_SIZE * (indexaux - 1)), @@MINIMUM_HEIGHT + 1, 1, 1, 0xff_ff00ff, :default)
      end
    else
      ranks = le_rk('r')
      ranks.each do |option|
        indexaux += 1
        indrank += 1 if indexaux >= @selectOpt
        if indexaux == @selectOpt
          Gosu::Image.new('./programicons/' + 'selectorarrow.png').draw(@@MARGIN_OFFSET, @@MARGIN_OFFSET + (@@BUTTON_SIZE * (indrank - 1)), @@MINIMUM_HEIGHT + 1, 1, 1)
        end
        if indrank <= 8
          @font.draw(option[1].to_s + ' : ' + option[0].to_s, @@MARGIN_OFFSET + @@BUTTON_SIZE, @@MARGIN_OFFSET + (@@BUTTON_SIZE * (indrank - 1)), @@MINIMUM_HEIGHT + 1, 1, 1, 0xff_ff00ff, :default)
        elsif indrank == 9
          @font.draw('...', @@MARGIN_OFFSET + @@BUTTON_SIZE, @@MARGIN_OFFSET + (@@BUTTON_SIZE * (indrank - 1)), @@MINIMUM_HEIGHT + 1, 1, 1, 0xff_ff00ff, :default)
        end
      end
    end
  end
end
