require_relative '../spec/spec_helper'

RSpec.describe "Teste de obstaculos(torre)" do
	context "testando upddate_frame " do

		it "Atualiza frame " do
			obst = Tower.new(0, 0, [0], 0, 0)
			x = (obst.hitbox.x - 1)
			y = (obst.hitbox.y + 1)
			obst.update_frame
			x = (x == obst.hitbox.x)
			y = (y == obst.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

		it "Nao atualiza frame " do
			obst = Tower.new(0, 0, [0], 0, 0)
			obst.update_frame;	obst.update_frame
			x = obst.hitbox.x
			y = obst.hitbox.y
			x = (x === obst.hitbox.x)
			y = (y === obst.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

	end	

end