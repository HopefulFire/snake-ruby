Direction =
{
  :north => 0,
  :east => 1,
  :south => 2,
  :west => 3
}


class Snake

  def initialize(x, y)
    @head = [x, y]
    @body = [[x, y-1]]
    @direction = Direction[:north]
    @engorged = false
  end
  
  #instance methods
  def to_s
    "Snake head at #{@head}\nRest of body: #{@body}"
  end

  def get_snake_locations
    [@head] + @body
  end

  def engorge
    @engorged = true
  end

  def slither
    @body.unshift(@head)
    if not @engorged
      @body.pop
    else
      @engorged = false
    end
    if @direction == Direction[:north]
      @head = [@head[0], @head[1] + 1]
    elsif @direction == Direction[:east]
      @head = [@head[0] + 1, @head[1]]
    elsif @direction == Direction[:south]
      @head = [@head[0], @head[1] - 1]
    elsif @direction == Direction[:west]
      @head = [@head[0] - 1, @head[1]]
    end
  end
  
  #setter method
  def set_direction=(value)
    @direction = value
  end
  
end

class Field
  
  def initialize(x, y)
    @dimensions = {x: x, y: y}
    generate
  end
  
  #instance methods
  def to_s
    output = ""
    @field.each do
      |row|
      row.each do
        |plot|
        output += plot
      end
      output += "\n"
    end
    output
  end
  
  def generate
    @field = []
    @dimensions[:y].times do
      row = []
      @dimensions[:x].times do
        row += ['[]']
      end
      @field += [row]
    end
  end
  
  #setter method
  def update(x, y)
    @field[y][x] = '{}'
  end
  
  def update_array(coordinates_array)
    coordinates_array.each do |coordinates|
      update(coordinates[0], coordinates[1])
    end
  end
end
