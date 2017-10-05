# @var == variavel de instancia (do objeto)
class Bowling
	attr_reader :pins, :score
	@rodada

	
	def initialize
		@pins = Array.new(10, true)
		@score = 0
		@rodada = 0
	end

	def play(pins_fallen)

	end
end