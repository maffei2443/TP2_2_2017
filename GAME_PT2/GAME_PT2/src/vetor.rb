# Funcoes para ler e escrever arquivos, servem de auxilio para o ranking em mainselectmanager e desertfalcongui
def le_rk(nome)
  nome.gsub!(/[\n\t]/, '')  # Retra caracteres teminais (\n por exemplo) e tabs

  ranking = File.open(nome, 'r')

  t = Array.new
  i = 0

  ranking.each_line.collect do |line|
    score = line.gsub(/[^0-9-]/, '').to_i
    nome = line.gsub(/[^A-Za-z]/, '')
    t[i] = [score, nome]
    i += 1
  end


  ranking.close
  t.sort! {|a,b| a <=> b}
  t.reverse!
=begin
  t.each{
    |x, y|
    puts "#{x} #{y}"
  }
=end
  return t
end

def write(nome, table)
  nome.gsub!(/[\n\t]/, '')	# Retira caracteres teminais (\n por exemplo) e tabs

  ranking = File.open(nome, 'w+')

  t = Array.new
  i = 0
  table.each do |score, nome2|
    t[i] = [score, nome2]
    i += 1
  end
  t.sort! {|a,b| a <=> b}
  t.reverse!
  t.each{
    |x, y|
    ranking.puts "#{x} #{y}"
  }
  ranking.close
  return t
end
