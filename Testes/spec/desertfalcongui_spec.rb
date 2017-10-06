require './lib/desertfalcongui'

RSpec.describe 	"Testando 'desertfalcongui'" do 

	context "Testando 'make10allobjects'" do

		it "Testando criacao das alturas (match)" do 
			obj =  DesertFalconGUI.new
			vet = []
			10.times do |i|
				vet[i] = i
			end
			vet2 = obj.make10tallObj(0)
			expect(vet).to eq(vet2)
		end
		
		it "Testando criacao das alturas (nao match)" do 
			obj =  DesertFalconGUI.new
			vet = []
			10.times do |i|
				vet[i] = i
			end
			vet2 = obj.make10tallObj(1)
			expect(vet == vet2).to eq(false)
		end


	end
end