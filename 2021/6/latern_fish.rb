class LaternFish < Struct.new(:gestetion_time)

  def live_for(days = 1)
    self.gestetion_time -= days
  end

  def split
    return [self] unless gestetion_time == -1

    self.gestetion_time = 6
    [self, LaternFish.new(8)]
  end
end
