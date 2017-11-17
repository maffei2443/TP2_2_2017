require_relative '../spec/spec_helper'

RSpec.describe "Teste de inimigos" do
	context "testando upddate_frame " do

		it "Atualiza frame " do
			enemy = Enemy.new("enemybird", 0, 0, [0], 0, 0)
			x = (enemy.hitbox.x - 2)
			y = (enemy.hitbox.y + 2)
			enemy.update_frame
			x = (x == enemy.hitbox.x)
			y = (y == enemy.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

		it "Nao atualiza frame " do
			enemy = Enemy.new("enemybird", 0, 0, [0], 0, 0)
			enemy.update_frame;	enemy.update_frame
			x = enemy.hitbox.x
			y = enemy.hitbox.y
			x = (x === enemy.hitbox.x)
			y = (y === enemy.hitbox.y)
			xx = (x and y)
			expect(xx).to eq(true)
		end

	end	

end