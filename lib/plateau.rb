class Plateau
  attr_reader :up_right_x, :up_right_y

  # Constructor
  def initialize(up_r_x = 0, up_r_y = 0)
    @up_right_x = up_r_x
    @up_right_y = up_r_y
  end

  # Validates if rover coordinates/direction are within Plateau
  def valid_rover_coords_in_pl?(rover_x, rover_y, rover_face)
    if rover_x.between?(0, @up_right_x) && rover_y.between?(0, @up_right_y) && %w(N E S W).include?(rover_face)
      return true
    else
      false
    end
  end
end
