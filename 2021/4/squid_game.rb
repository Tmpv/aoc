#! ruby
require './bingo_board'

data_file = ARGV[0]

file = File.open(data_file)

numbers = file.readline

current_board = BingoBoard.new

all_boards = []

file.each_line do |line|
  if current_board.filled?
    all_boards << current_board
    current_board = BingoBoard.new
  end

  next if line == "\n"
  current_board.add_row(line.split)
end

puts 'The winning numbers are:'
puts numbers

numbers.split(',').each_with_index do |number, pull_count|
  break if all_boards.all?(&:winning?)

  all_boards.each do |board|
    next if board.winning?
    board.pull_number(number, pull_count)
  end
end

last_winner = all_boards.sort {|a, b| a.last_pull_count <=> b.last_pull_count }.last

puts "Last pulled number #{last_winner.last_pulled_number}"
puts "Score is #{last_winner.score}"
