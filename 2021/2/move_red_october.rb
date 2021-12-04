#! ruby
require './submarine.rb'
map_file = ARGV[0]
submarine = Submarine.new(0, 0, 0)
File.read(map_file).each_line { |movement| submarine.move(movement) }

puts "Submarine is currently on coordinates: #{submarine.coordinates}"
puts "Submarine coordinates product is: #{submarine.coordinates.reduce(&:*)}"
