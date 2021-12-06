#! ruby
require './latern_fish'

vents_map_file = ARGV[0]

bood_list_file = File.open(vents_map_file)
brood_list = bood_list_file.readline

# brood = brood_list.scan(/\d/).map do |gestetion_time|
#   LaternFish.new(gestetion_time.to_i)
# end

brood = brood_list.scan(/\d/).map do |gestetion_time|
  LaternFish.new(gestetion_time.to_i)
end

80.times do |number|
  brood = brood.reduce([]) do |new_brood, fish|
    fish.live_for
    fish.split.each do |offspring|
      new_brood << offspring
    end

    new_brood
  end
end

puts "Final brood size #{brood.count}"
