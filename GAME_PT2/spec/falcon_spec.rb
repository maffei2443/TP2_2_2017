require 'spec_helper'


RSpec.describe "Testando métodos de Falcon" do 
	context "Testando método mov_up " do

		it "Executa mov_up" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_up
			zlist_0 += 1
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)
		end

		it "Nao executa mov_up" do
			falcon = Falcon.new("arrow", 0 , 0, [35, 70], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_up
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)

		end

	end

	context "Testando método mov_down " do

		it "Executa mov_down" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_down
			zlist_0 -= 1
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)
		end

		it "Nao executa mov_down" do
			falcon = Falcon.new("arrow", 0 , 0, [0, 10], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_down
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)
		end

	end

	context "Testando método mov_left " do

		it "Executa mov_left" do
			falcon = Falcon.new("arrow", 33 , 0, [10, 20], 20, 20)
			x = falcon.hitbox.x
			y = falcon.hitbox.y
			falcon.mov_left
			x -= 2
			y -= 1
			xx = ((x == falcon.hitbox.x) and (y == falcon.hitbox.y))
			expect(xx).to eq(true)
		end

		it "Nao executa mov_left" do
			falcon = Falcon.new("arrow", 32 , 0, [0, 10], 20, 20)
			x = falcon.hitbox.x
			y = falcon.hitbox.y
			falcon.mov_left
			xx = ((x == falcon.hitbox.x) and (y == falcon.hitbox.y))
			expect(xx).to eq(true)			
		end

	end

	context "Testando método mov_right " do

		it "Executa mov_right" do
			falcon = Falcon.new("arrow", 33 , 0, [10, 20], 20, 20)
			x = falcon.hitbox.x
			y = falcon.hitbox.y
			falcon.mov_right
			x += 2
			y += 1			
			xx = ((x == falcon.hitbox.x) and (y == falcon.hitbox.y))
			expect(xx).to eq(true)
		end

		it "Nao executa mov_right" do
			falcon = Falcon.new("arrow", 32 , 0, [0, 10], 20, 500)
			x = falcon.hitbox.x
			y = falcon.hitbox.y
			falcon.mov_right
			xx = ((x == falcon.hitbox.x) and (y == falcon.hitbox.y))
			expect(xx).to eq(true)
		end

	end

end
