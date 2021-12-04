class PowerScanner < Struct.new(:gamma_reading, :epsilon_reading)
  def process(data)
    readings = build_reading(data)
    readings.map(&method(:scan))
  end

  def readings
    [gamma_reading.join, epsilon_reading.join]
  end

  def product
    readings.map { |c| c.to_i(2) }.reduce(&:*)
  end

  private

  def scan(row)
    zeros = row.count('0')
    onces = row.count('1')

    if zeros > onces
      gamma_reading << '1'
      epsilon_reading << '0'
    else
      gamma_reading << '0'
      epsilon_reading << '1'
    end
  end

  def build_reading(data)
    data.map { |s| s.split('') }
        .transpose
        .map(&:join)
  end
end
