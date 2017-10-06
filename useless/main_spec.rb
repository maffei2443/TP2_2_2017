require 'all'

RSpec.describe 	"Bowling game" do 
	it "test the number of pins" do 
		game = Bowling.new
		vet = game.pins
		expect(vet.length).to eq(10)
	end
 
	it "test initial state" do 
		game = Bowling.new
		expect(game.pins).to eq(Array.new(10, true))
	end

	it "test the points" do 
		
	end

end