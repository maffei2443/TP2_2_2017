require 'gosu'

# Controla o tempo de jogo e modo slow motion
class TimeControlManager
  def initialize(font, windowy, marginoff, hudlayer)
    @@WINDOW_SIZE_Y = windowy
    @font = font
    @boopIterator = 0
    @sysTime = (Time.now.to_f * 1000)
    @FPScount = 0.0
    @paused = false
    @pausewait = 0
    @slowmoset = false
    @slowmo = false
    @slowsetwait = 0

    @@MARGIN_OFFSET = marginoff
    @@PAUSE_SLOWMO_TOGGLE_DELAY = 20
    @@HEADS_UP_DISPLAY_LAYER = hudlayer
    @@FPS_COUNTER_PERIOD = 30
  end

  attr_reader :paused, :slowmo

  def update_timing
    if Gosu.button_down?(Gosu::KB_P) && @pausewait.zero?
      @paused = @paused == false
      @pausewait = @@PAUSE_SLOWMO_TOGGLE_DELAY
    end
    if Gosu.button_down?(Gosu::KB_O) && @slowsetwait.zero?
      if @slowmoset == false
        @slowmoset = true
      else
        @slowmoset = false
        @slowmo = false
      end
      @slowsetwait = @@PAUSE_SLOWMO_TOGGLE_DELAY
    end
    @slowmo = @slowmo == false if @slowmoset == true
    @pausewait -= 1 if @pausewait > 0
    @slowsetwait -= 1 if @slowsetwait > 0
  end

  def draw
    @font.draw('FPS := ' + @FPScount.to_s, @@MARGIN_OFFSET, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_8000ff, :default)

    @boopIterator += 1

    if @boopIterator > @@FPS_COUNTER_PERIOD / 2
      @font.draw('BOOP!', 513, @@WINDOW_SIZE_Y - @@MARGIN_OFFSET, @@HEADS_UP_DISPLAY_LAYER + 1, 1, 1, 0xff_8000ff, :default)
    end
    if @boopIterator == @@FPS_COUNTER_PERIOD
      @boopIterator = 0
      @FPScount = @@FPS_COUNTER_PERIOD / (((Time.now.to_f * 1000) - @sysTime) / 1000)
      @sysTime = (Time.now.to_f * 1000)
    end
  end
end
