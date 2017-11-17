require 'gosu'

# Controla leitura de letras do teclado
class ReadNameManager
  def initialize
    @inputBuffer = 0
  end

  def read # Printa imagem deslocada pela altura
  	if (@inputBuffer > 0)
  	  @inputBuffer -= 1
  	end
    if (@inputBuffer == 0)
      if (Gosu.button_down?(Gosu::KB_A))
      	@inputBuffer = 30
      	return 'A'
      elsif (Gosu.button_down?(Gosu::KB_B))
      	@inputBuffer = 30
      	return 'B'
      elsif (Gosu.button_down?(Gosu::KB_C))
      	@inputBuffer = 30
      	return 'C'
      elsif (Gosu.button_down?(Gosu::KB_D))
      	@inputBuffer = 30
      	return 'D'
      elsif (Gosu.button_down?(Gosu::KB_E))
      	@inputBuffer = 30
      	return 'E'
      elsif (Gosu.button_down?(Gosu::KB_F))
      	@inputBuffer = 30
      	return 'F'
      elsif (Gosu.button_down?(Gosu::KB_G))
      	@inputBuffer = 30
      	return 'G'
      elsif (Gosu.button_down?(Gosu::KB_H))
      	@inputBuffer = 30
      	return 'H'
      elsif (Gosu.button_down?(Gosu::KB_I))
      	@inputBuffer = 30
      	return 'I'
      elsif (Gosu.button_down?(Gosu::KB_J))
      	@inputBuffer = 30
      	return 'J'
      elsif (Gosu.button_down?(Gosu::KB_K))
      	@inputBuffer = 30
      	return 'K'
      elsif (Gosu.button_down?(Gosu::KB_L))
      	@inputBuffer = 30
      	return 'L'
      elsif (Gosu.button_down?(Gosu::KB_M))
      	@inputBuffer = 30
      	return 'M'
      elsif (Gosu.button_down?(Gosu::KB_N))
      	@inputBuffer = 30
      	return 'N'
      elsif (Gosu.button_down?(Gosu::KB_O))
      	@inputBuffer = 30
      	return 'O'
      elsif (Gosu.button_down?(Gosu::KB_P))
      	@inputBuffer = 30
      	return 'P'
      elsif (Gosu.button_down?(Gosu::KB_Q))
      	@inputBuffer = 30
      	return 'Q'
      elsif (Gosu.button_down?(Gosu::KB_R))
      	@inputBuffer = 30
      	return 'R'
      elsif (Gosu.button_down?(Gosu::KB_S))
      	@inputBuffer = 30
      	return 'S'
      elsif (Gosu.button_down?(Gosu::KB_T))
      	@inputBuffer = 30
      	return 'T'
      elsif (Gosu.button_down?(Gosu::KB_U))
      	@inputBuffer = 30
      	return 'U'
      elsif (Gosu.button_down?(Gosu::KB_V))
      	@inputBuffer = 30
      	return 'V'
      elsif (Gosu.button_down?(Gosu::KB_W))
      	@inputBuffer = 30
      	return 'W'
      elsif (Gosu.button_down?(Gosu::KB_X))
      	@inputBuffer = 30
      	return 'X'
      elsif (Gosu.button_down?(Gosu::KB_Y))
      	@inputBuffer = 30
      	return 'Y'
      elsif (Gosu.button_down?(Gosu::KB_Z))
      	@inputBuffer = 30
      	return 'Z'
      end
    end
    return nil
  end
end
