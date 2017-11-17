require_relative '../spec/spec_helper'
RSpec.describe 	"Testing colision (check_hit)" do 

	context "Colisoes de mesma altura" do

		it "Hitboxes coincidem " do 
			b = Hitbox.new(48, 48, [10], 10, 10)
			a = Hitbox.new(48, 48, [10], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Hitboxes englobam uma à outra" do 
			b = Hitbox.new(48, 48, [10], 10, 10)
			a = Hitbox.new(50, 50, [10], 5, 5)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao pontual " do 
			b = Hitbox.new(0, 0, [10], 10, 10)
			a = Hitbox.new(10, 10, [10], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao de aresta " do 
			b = Hitbox.new(0, 0, [10], 10, 10)
			a = Hitbox.new(10, 0, [10], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao de dois pontos" do 
			b = Hitbox.new(0, 0, [10], 10, 10)
			a = Hitbox.new(5, 5, [10], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	end

	context "Colisoes de mesmas alturas" do

		it "Hitboxes coincidem " do 
			b = Hitbox.new(48, 48, [10, 2, 3], 10, 10)
			a = Hitbox.new(48, 48, [10, 20, 30], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Hitboxes englobam uma à outra" do 
			b = Hitbox.new(48, 48, [10, 2, 3], 10, 10)
			a = Hitbox.new(50, 50, [10, 20, 30], 5, 5)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao pontual " do 
			b = Hitbox.new(0, 0, [10, 2, 3], 10, 10)
			a = Hitbox.new(10, 10, [10, 20, 30], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao de aresta " do 
			b = Hitbox.new(0, 0, [10, 2, 3], 10, 10)
			a = Hitbox.new(10, 0, [10, 20, 30], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	 
		it "Colisao de dois pontos" do 
			b = Hitbox.new(0, 0, [10, 2, 3], 10, 10)
			a = Hitbox.new(5, 5, [10, 20, 30], 10, 10)
			expect(a.check_hit(b)).to eq(true)
			expect(b.check_hit(a)).to eq(true)
		end
	end


	context "Nao-Colisoes de mesma altura" do

		it "Nao colisao no mesmo intervalo 'x'" do 
			b = Hitbox.new(48, 48, [10], 10, 10)
			a = Hitbox.new(48, 0, [10], 10, 10)
			expect(a.check_hit(b)).to eq(false)
			expect(b.check_hit(a)).to eq(false)
		end
	 
		it "Nao colisao no mesmo intervalo 'y'" do 
			b = Hitbox.new(0, 10, [10], 10, 10)
			a = Hitbox.new(20, 10, [10], 5, 5)
			expect(a.check_hit(b)).to eq(false)
			expect(b.check_hit(a)).to eq(false)
		end
	 
		it "Nao colisao em intervalos 'x' 'y' diferentes" do 
			b = Hitbox.new(0, 20, [10], 10, 10)
			a = Hitbox.new(20, 0, [10], 10, 10)
			expect(a.check_hit(b)).to eq(false)
			expect(b.check_hit(a)).to eq(false)
		end
	end


end
