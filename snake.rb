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
  end

  #instance methods
  def getSnakeLocations
    [@head] + @body
  end
  
  #setter methods
  def setDirection=(value)
    @direction = value
  end

  #self methods
  def slither
    @body.unshift(@head)
    @body.pop
    if @direction = Direction[:north]
      @head = [@head[0], @head[1] + 1]
    elsif @direction = Direction[:east]
      @head = [@head[0] + 1, @head[1]]
    elsif @direction = Direction[:south]
      @head = [@head[0], @head[1] - 1]
    elsif @direction = Direction[:west]
      @head = [@head[0] - 1, @head[1]]
    end
    nil
  end
  nil
end
