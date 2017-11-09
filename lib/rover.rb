require_relative 'direction'

class Rover
  attr_accessor :id, :direction

  # Constructor
  def initialize(index, x, y, orientation)
    @id = index
    @direction = Direction.new(x, y, orientation)
  end

  # For 'L' instruction
  def spin_90_left
    @direction.rotate_left
  end

  # For 'R' instruction
  def spin_90_right
    @direction.rotate_right
  end

  # For 'M' instruction
  def move
    @direction.move_fwd
  end

  def get_curr_x
    return @direction.x_coord
  end

  def get_curr_y
    return @direction.y_coord
  end

  def get_curr_orientation
    return @direction.orientation
  end

  # Output Rover's current position
  def output_curr_position
    puts [@direction.x_coord, @direction.y_coord, @direction.orientation].join(' ')
  end

end
