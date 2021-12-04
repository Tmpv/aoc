#! ruby
require './power_scanner'

measurment_file = ARGV[0]
data = []
scanner = PowerScanner.new([], [])

File.read(measurment_file).each_line(chomp: true) do |measurment|
  data << measurment
end

puts 'Scan data...'
scanner.process(data)

puts 'Scan completed'

puts "Gamma reading #{scanner.readings.first}"
puts "Epsilon reading #{scanner.readings.last}"

puts "Product of the readings #{scanner.product}"
