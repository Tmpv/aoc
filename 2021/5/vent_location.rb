class VentLocation < Struct.new(:x, :y)
  def ===(b)
    self.x === b.x && self.y === b.y
  end
end
