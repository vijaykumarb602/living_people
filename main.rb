require 'json'

## Main class
class Main

  def get_max_year(list=[])
    set_start_end_years(list)
    
    hash = {}
    x = y = Main::START_YEAR

    until x == END_YEAR
      hash[x] = 0
      x += 1
    end

    until y == Main::END_YEAR
      list.each do |x|
        if x[0] == y || x[1] == y || ((x[1] - x[0] > x[1] - y) && (x[1] - y > 0))
          hash[y] += 1
          next
        end
      end
      y += 1
    end

    final = []
    hash.each { |k, v| final << k if v == hash.values.max }
    puts "Highest count: #{hash.values.max} and the years are #{final}"
  end

  def set_start_end_years(list)
    min_start_year = list.map {|row| row[0]}.min
    max_end_year = list.map {|row| row[1]}.max

    self.class.const_set(:START_YEAR, (min_start_year >= 1900 ? min_start_year : 1900))
    self.class.const_set(:END_YEAR, (max_end_year <= 2000 ? max_end_year : 2000))
  end
end

input = JSON.parse(File.read("./years_list.json"))

obj = Main.new
obj.get_max_year(input)