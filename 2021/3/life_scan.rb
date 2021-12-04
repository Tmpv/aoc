#! ruby
require './life_scanner'

measurment_file = ARGV[0]
data = []
scanner = LifeScanner.new([], [])

File.read(measurment_file).each_line(chomp: true) do |measurment|
  data << measurment
end

puts 'Scan data...'
scanner.process(data)

puts 'Scan completed'

puts "Oxygen reading #{scanner.readings.first}"
puts "CO2 reading #{scanner.readings.last}"

puts "Product of the readings #{scanner.product}"
