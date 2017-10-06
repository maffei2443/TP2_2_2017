require 'sprite'

RSpec.describe 	"Testing sprite " do 
	it "Teste Sprite.new" do 
		sprite = Sprite.new("./lib/img/arrow/arrow1.png");
		expect(sprite.x).to eq(-1)
		expect(sprite.y).to eq(-2)
		expect(sprite.z).to eq(-3)
	end
 
	it "Teste Sprite.draw" do 
		sprite = Sprite.new("./lib/img/arrow/arrow1.png");
		sprite.draw(14, 15, 16)
		expect(sprite.x).to eq(14)
		expect(sprite.y).to eq(15)
		expect(sprite.z).to eq(16)
	end

end