require 'io/console'
require 'timeout'
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
    @engorged = true
  end
  
  #instance methods
  def to_s
    "Snake head at #{@head}\nRest of body: #{@body}"
  end
  
  def head
    @head
  end
  
  def body
    @body
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
      @head = [@head[0], @head[1] - 1]
    elsif @direction == Direction[:east]
      @head = [@head[0] + 1, @head[1]]
    elsif @direction == Direction[:south]
      @head = [@head[0], @head[1] + 1]
    elsif @direction == Direction[:west]
      @head = [@head[0] - 1, @head[1]]
    end
  end
  
  #setter method
  def direction=(value)
    @direction = value
  end
  
end

class Apple

  def initialize(x, y)
    @location = [rand(x), rand(y)]
  end

  #instance method
  def to_s
    "Apple at #{@location}"
  end

  #getter method
  def location
    @location
  end

end

class Field
  
  def initialize(x, y)
    @dimension = {x: x, y: y}
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
    @dimension[:y].times do
      row = []
      @dimension[:x].times do
        row += ['<>']
      end
      @field += [row]
    end
  end
  
  #setter methods
  def update(coordinates)
    @field[coordinates[1]][coordinates[0]] = '{}'
  end
  
  def update_array(coordinates_array)
    coordinates_array.each do |coordinates|
      update(coordinates)
    end
  end
end

def run_game
  dim_x = 20
  dim_y = 20
  apple = Apple.new(dim_x, dim_y)
  apple_eaten = false
  snake = Snake.new(9,9)
  snake_alive = true
  key_pressed = STDIN.getch
  while snake_alive do

    # build and print frame
    field = Field.new(dim_x, dim_y)
    field.update(apple.location)
    field.update_array(snake.get_snake_locations)
    system 'clear' or system 'cls'
    puts field

    # wait for player action
    begin
      Timeout::timeout(0.2) do
        key_pressed = STDIN.getch
      end
    rescue
      nil
    end

    # update snake, apple, and field status
    if key_pressed == 'w'
      snake.direction = Direction[:north]
    elsif key_pressed == 'a'
      snake.direction = Direction[:west]
    elsif key_pressed == 's'
      snake.direction = Direction[:south]
    elsif key_pressed == 'd'
      snake.direction = Direction[:east]
    else
      next
    end
    snake.slither
    
    apple_eaten = apple.location == snake.head
    if apple_eaten
      snake.engorge
      apple = Apple.new(dim_x, dim_y)
    end
    
    if snake.head[0] > -1 and snake.head[0] < dim_x and snake.head[1] > -1 and snake.head[1] < dim_y
      nil
    else
      snake_alive = false
    end
    
    if snake.body.any? { |body_part| body_part == snake.head }
      snake_alive = false
    end
  end
  puts 'You died'
end

run_game
