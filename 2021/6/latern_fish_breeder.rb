class LaternFishBreeder
  attr_accessor :gestation_groups, :breeding_cycle

  def initialize(initial_breed)
    self.gestation_groups = initial_breed
      .group_by(&:itself)
      .reduce(Array.new(9, 0)) do |accut, (group_name, fishes)|
        accut[group_name.to_i] = fishes.count
        accut
      end

    self.breeding_cycle = 0
  end

  def print_brood_status
    puts "==== Brood status at #{breeding_cycle} day ===="

    self.gestation_groups.each_with_index do |count, index|
      puts "Group #{index} has #{count} fishes."
    end
  end

  def day_passes_by!
    self.breeding_cycle += 1
    print_brood_status

    self.gestation_groups = gestation_groups
      .to_enum
      .with_index
      .reverse_each
      .reduce(Array.new(9, 0)) do |accut, (fish_count, group_index)|
        index = group_index - 1

        if index == -1
          accut[8] = accut[8] + fish_count
          accut[6] = accut[6] + fish_count
        else
          accut[index] = fish_count
        end

        accut
      end
  end

  def brood_size
    gestation_groups.sum
  end
end
