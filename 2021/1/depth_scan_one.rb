#! ruby
file_name = ARGV[0]

depth_increases = -1
last_measurment = 0

File.read(file_name).each_line do |measurment|
  depth_increases += 1 if measurment.to_i > last_measurment
  last_measurment = measurment.to_i
end

puts "We had #{depth_increases} during the last scan!!!"
