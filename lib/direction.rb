class Direction
  attr_accessor :x_coord, :y_coord, :orientation

  # Constructor
  def initialize(x, y, orient)
    @x_coord = x
    @y_coord = y
    @orientation = orient
  end

  #N,E,S,W are assumed direction symbols for North, East, South and West respectively
  #L,R,M are input instructions for left rotate. right rotate and move forward respectively
  north = {
    'L' => 'W',
    'R' => 'E'
  }

	east = {
    'L' => 'N',
    'R' => 'S'
  }

  south = {
    'L' => 'E',
    'R' => 'W'
  }

  west = {
    'L' => 'S',
    'R' => 'N'
  }

  # dir_hash maps rotate instruction result
  @@dirn_hash = {
    'N' => north,
    'E' => east,
    'S' => south,
    'W' => west
  }

  @@axis_hash = {
    'N' => 'Y',
    'S' => 'Y',
    'E' => 'X',
    'W' => 'X'
  }

  @@val_hash = {
    'N' => 1,
    'S' => -1,
    'E' => 1,
    'W' => -1
  }

  def rotate_left
    @orientation = @@dirn_hash[@orientation]['L']
  end

  def rotate_right
    @orientation = @@dirn_hash[@orientation]['R']
  end

  def move_fwd
    if @@axis_hash[@orientation] == 'X'
      @x_coord += @@val_hash[@orientation]
    elsif @@axis_hash[@orientation] == 'Y'
      @y_coord += @@val_hash[@orientation]
    end
  end

end
