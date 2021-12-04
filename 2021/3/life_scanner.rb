class LifeScanner < Struct.new(:oxygen_rating, :co2_rating, :data)

  READING_CRITERIAS = {
    oxygen: ->(result) { result[:onces] >= result[:zeros] ? result[:o_rest] : result[:z_rest] },
    co2: ->(result) { result[:onces] < result[:zeros] ? result[:o_rest] : result[:z_rest] }
  }

  def process(data)
    @data = data
    readings = build_reading(data)

    readings.reduce([]) do |rest, row|
      if rest.count == 1
        self.oxygen_rating = data[rest.first]
        break
      end

      scan(row, :oxygen, indices: rest)
    end

    readings.reduce([]) do |rest, row|
      if rest.count == 1
        self.co2_rating = data[rest.first]
        break
      end

      scan(row, :co2, indices: rest)
    end
  end

  def readings
    [oxygen_rating, co2_rating]
  end

  def product
    readings.map { |c| c.to_i(2) }.reduce(&:*)
  end

  private

  def scan(row, type, indices: [])
    results = { zeros: 0, onces: 0, z_rest: [], o_rest: [] }

    row.split('').each_with_index do |char, index|
      next unless  indices.include?(index) || indices.empty?

      bit_field, rest_field = char == '0' ? [:zeros, :z_rest] : [:onces, :o_rest]

      results[bit_field] += 1
      results[rest_field] << index
    end


    READING_CRITERIAS[type][results]
  end

  def build_reading(data)
    data.map { |s| s.split('') }.transpose.map(&:join)
  end
end
