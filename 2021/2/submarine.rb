class Submarine < Struct.new(:depth, :horizontal, :aim)
  def coordinates
    [depth, horizontal]
  end

  def move(movement)
    direction, points = movement.split
    send(direction, points.to_i)
  end

  private

  def up(value)
    self.aim -= value
  end

  def down(value)
    self.aim += value
  end

  def forward(value)
    self.horizontal += value
    self.depth += aim * value
  end
end
