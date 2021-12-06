#! ruby
require './latern_fish_breeder'

brood_initial_size = ARGV[0]

bood_list_file = File.open(brood_initial_size)
brood_list = bood_list_file.readline

brood = brood_list.scan(/\d/)

breeder = LaternFishBreeder.new(brood)

256.times { breeder.day_passes_by! }

puts '======================'
puts "Brood final size is #{breeder.brood_size}"
