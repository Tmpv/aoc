#! ruby
require 'set'
require './vent_line'
require './vent_location'

vents_map_file = ARGV[0]

vent_map = File.open(vents_map_file)

vent_lines = vent_map.each_line.reduce([]) do |accut, line_data|
  vent_line = VentLine.new(line_data)
  accut << vent_line
  accut
end

overlapping_points = vent_lines.reduce(Set.new) do |accut, line|
  vent_lines.each do |compared_line|
    next accut if line === compared_line

    line.overlapping_points(compared_line).each do |overlaps|
      accut.add(overlaps)
    end
  end

  accut
end

puts "Overlapping points count is #{overlapping_points.count}"
