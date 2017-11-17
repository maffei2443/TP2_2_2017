require_relative '../spec/spec_helper'

RSpec.describe "Teste modulo 'rock'" do
	context "Testando 'update_frame'" do
		it "Atualiza frame" do
			rock = Rock.new("slate", 0, 0)
			x = (rock.hitbox.x - 1)
			y = (rock.hitbox.y + 1)
			rock.update_frame;
			x = (x === rock.hitbox.x)
			y = (y === rock.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)

		end

		it  "Nao atualiza frame" do
			rock = Rock.new("granite", 0, 0)
			rock.update_frame
			x = rock.hitbox.x
			y = rock.hitbox.y
			rock.update_frame
			x = (x === rock.hitbox.x)
			y = (y === rock.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

	end
end