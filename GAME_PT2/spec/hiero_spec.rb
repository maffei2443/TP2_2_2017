require 'spec_helper'

RSpec.describe "Teste de hieros" do
	context "testando upddate_frame " do

		it "Atualiza frame " do
			hiero = Hiero.new("hieroruby", 0, 0, [0], 0, 0)
			x = (hiero.hitbox.x - 1)
			y = (hiero.hitbox.y + 1)
			hiero.update_frame
			x = (x == hiero.hitbox.x)
			y = (y == hiero.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

		it "Nao atualiza frame " do
			hiero = Hiero.new("hieroruby", 0, 0, [0], 0, 0)
			hiero.update_frame;	hiero.update_frame
			x = hiero.hitbox.x
			y = hiero.hitbox.y
			x = (x === hiero.hitbox.x)
			y = (y === hiero.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

	end	

end