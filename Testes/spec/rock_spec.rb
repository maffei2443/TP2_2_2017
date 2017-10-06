
require './lib/rock'

RSpec.describe "Teste modulo 'rock'" do
	context "Testando 'update_frame'" do
		it "Atualiza frame" do
			rock = Rock.new("sandstone", 0, 0)
			rock.update_frame
			expect(rock.movCoolDownTimer ).to eq(0)
		end

		it  "Nao atualiza frame" do

		end

	end
end