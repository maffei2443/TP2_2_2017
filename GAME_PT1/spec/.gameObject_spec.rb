require_relative '../gameObject'
require_relative '../falcon'



RSpec.describe "Testando metodos de GameObject" do 

	context	"Teste do metodo 'hit?' ' " do 
		
		it "Re-Teste do metodo 'hit' (esperado colisao)" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			falcon2 = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			expect(falcon.hit?(falcon2)).to eq(true)
			expect(falcon2.hit?(falcon)).to eq(true)
		end

		it "Re-Teste do metodo 'hit' (esperado nao-colisao)" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			falcon2 = Falcon.new("arrow", 100 , 100, [10, 20], 20, 20)
			expect(falcon.hit?(falcon2)).to eq(false)
			expect(falcon2.hit?(falcon)).to eq(false)
		end
	 
	end


	context "Teste do metodo de movimento" do 

		it "Up" do 
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			before = falcon.hitbox.zlist[0]
			falcon.mov_up
			after = falcon.hitbox.zlist[0]
			if(before >= 35)
				expect(before).to eq(after)
			else
				expect(before == after).to eq(false)
			end
		end

		it "Down" do 
		end

		it "Left" do 
		end

		it "Right" do
		end
	end
end
