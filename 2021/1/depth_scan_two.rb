#! ruby

file_name = ARGV[0]

data = []
File.read(file_name).each_line { |measurment|  data << measurment.to_i }

measurment_increases = -1

groups_of_three = data.each_with_index.each_with_object([]) do |(measurment, index), accut|
  group = data[index..index+2]
  break accut if group.count != 3
  measurment_increases += 1 if group&.sum.to_i > accut.last&.sum.to_i
  accut << group
end

puts 'We have the following measurment groups'
pp groups_of_three

puts "We have #{measurment_increases} for them."
