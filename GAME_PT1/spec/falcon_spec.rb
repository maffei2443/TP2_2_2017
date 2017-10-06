require 'spec_helper'


RSpec.describe "Testando metodos de Falcon" do 
	context "Testando metodo mov_up " do

		it "Executa mov_up" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_up
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(false)
		end

		it "Nao executa mov_up" do
			falcon = Falcon.new("arrow", 0 , 0, [35, 70], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_up
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)

		end

	end

	context "Testando metodo mov_down " do

		it "Executa mov_down" do
			falcon = Falcon.new("arrow", 0 , 0, [10, 20], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_down
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(false)
		end

		it "Nao executa mov_down" do
			falcon = Falcon.new("arrow", 0 , 0, [0, 10], 20, 20)
			zlist_0 = falcon.hitbox.zlist[0]
			falcon.mov_down
			expect(zlist_0 == falcon.hitbox.zlist[0]).to eq(true)

		end

	end

	context "Testando metodo mov_left " do

		it "Executa mov_left" do
			falcon = Falcon.new("arrow", 33 , 0, [10, 20], 20, 20)
			x = falcon.hitbox.x
			falcon.mov_left
			expect(x == falcon.hitbox.x).to eq(false)
		end

		it "Nao executa mov_left" do
			falcon = Falcon.new("arrow", 32 , 0, [0, 10], 20, 20)
			x = falcon.hitbox.x
			falcon.mov_left
			expect(x == falcon.hitbox.x).to eq(true)
		end

	end

	context "Testando metodo mov_right " do

		it "Executa mov_right" do
			falcon = Falcon.new("arrow", 33 , 0, [10, 20], 20, 20)
			x = falcon.hitbox.x
			falcon.mov_right
			expect(x == falcon.hitbox.x).to eq(false)
		end

		it "Nao executa mov_right" do
			falcon = Falcon.new("arrow", 32 , 0, [0, 10], 20, 500)
			x = falcon.hitbox.x
			falcon.mov_right
			expect(x == falcon.hitbox.x).to eq(true)
		end

	end

	context "Testando update_frame" do 	
	end

end
