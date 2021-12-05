class VentLine
  attr_accessor :start_point, :end_point

  def initialize(data)
    location1, location2 = data.split('->')

    @start_point = VentLocation.new(*location1.strip.split(',').map(&:to_i))
    @end_point   = VentLocation.new(*location2.strip.split(',').map(&:to_i))
  end

  def vertical?
    @vertical ||= start_point.x == end_point.x
  end

  def horizontal?
    @horizontal ||= start_point.y == end_point.y
  end

  def diagonal?
    !horizontal? && !vertical?
  end

  def overlapping_points(line)
    self.covered_location & line.covered_location
  end

  def covered_location
    @covered_location ||= [
      verticaly_coverd_points,
      horizontaly_coverd_points,
      diagonal_cover_points
    ].flatten
  end

  def ===(line)
    self.start_point === line.start_point &&
      self.end_point === line.end_point
  end

  def x_coordinates
    [start_point.x, end_point.x]
  end

  def y_coordinates
    [start_point.y, end_point.y]
  end

  def diagonal_cover_points
    return [] unless diagonal?

    start = start_point.x < end_point.x ? start_point : end_point
    finish = start_point.x < end_point.x ? end_point : start_point

    if start.y < finish.y
      acending_diagonal_cover_points(start, finish)
    else
      decending_diagonal_cover_points(start, finish)
    end
  end

  def acending_diagonal_cover_points(start, finish)
    (start.x..finish.x).each_with_index.map do |x_coordinate, index|
      VentLocation.new(x_coordinate, start.y + index)
    end
  end

  def decending_diagonal_cover_points(start, finish)
    (start.x..finish.x).each_with_index.map do |x_coordinate, index|
      VentLocation.new(x_coordinate, start.y - index)
    end
  end

  def verticaly_coverd_points
    return [] unless vertical?

    (y_coordinates.min..y_coordinates.max).sort.map do |y_coordinate|
      VentLocation.new(start_point.x, y_coordinate)
    end
  end

  def horizontaly_coverd_points
    return [] unless horizontal?

    (x_coordinates.min..x_coordinates.max).sort.map do |x_coordinate|
      VentLocation.new(x_coordinate, start_point.y)
    end
  end
end
