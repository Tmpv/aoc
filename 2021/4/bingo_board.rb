class BingoBoard
  attr_accessor :rows, :hits, :last_pulled_number, :last_pull_count

  def initialize
    @rows = []
  end

  def pull_number(number, pull_count)
    rows.each do |row|
      index = row.find_index(number)
      row[index] = nil if index

      self.last_pulled_number = number
      self.last_pull_count = pull_count
    end
  end

  def add_row(row)
    self.rows << row
  end

  def winning?
    rows.any? { |r| r.all?(&:nil?) } ||
    rows.transpose.any? { |r| r.all?(&:nil?) }
  end

  def score
    sum * last_pulled_number.to_i
  end

  def sum
    rows.flatten.map(&:to_i).sum.to_i
  end

  def filled?
    self.rows.count == 5
  end
end
