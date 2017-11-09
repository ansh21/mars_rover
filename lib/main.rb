  require_relative 'plateau'
  require_relative 'rover'

  class Main
    attr_accessor :plateau, :rover

    # Checks if input coords are vaild i.e Integers
    def valid_coords?(x, y)
      is_valid = Integer(x) && Integer(y) rescue false
      is_valid
    end

    # process instructions like L, R, M, etc.
    def process_instruction(instruction)
      case instruction
      when 'L'
        @rover.spin_90_left
      when 'R'
        @rover.spin_90_right
      when 'M'
        @rover.move
      else
        # Invalidate rover if instruction is not valid
        puts "INVALID INPUT: Given rover instruction: '#{instruction}' is invalid. Allowed instructions are: L, R and M"
        exit
      end
    end

    # Main Process
    def process

      #input upper right coordinates of plateau
      up_right_x, up_right_y = gets.chomp.split(' ') #split on the basis of space as mentioned in the problem

      if !valid_coords?(up_right_x, up_right_y)
        puts "INVALID INPUT: Given upper-right Coordinates of Plateau: (#{up_right_x}, #{up_right_y}) are NOT Integers"
        exit
      end
      
      @plateau = Plateau.new(up_right_x.to_i, up_right_y.to_i)

      rover_history_hash = Hash.new(0)

      #input rover's position along with instructions on the next line
      STDIN.each_slice(2).each_with_index { |lines, index|
        rover_x, rover_y, rover_orientation = lines[0].split

        #check if input initial position coords of rover are valid (by Integer)
        if !valid_coords?(rover_x, rover_y)
          puts "INVALID INPUT: Given rover Coordinates: (#{rover_x}, #{rover_y}) are NOT Integers"
          exit
        end

        rover_x_val = rover_x.to_i
        rover_y_val = rover_y.to_i
        rover_orientation_val = rover_orientation.to_s

        #check if input initial position coords of rover are within the plataue
        if !@plateau.valid_rover_coords_in_pl?(rover_x_val, rover_y_val, rover_orientation_val)
          puts "INVALID INPUT: Given rover co-ordinates: (#{rover_x_val}, #{rover_y_val}, #{rover_orientation_val}) are either NOT WITHIN PLATEAU or the Orientation is INCORRECT"
          exit
        end

        # Initialize Rover
        @rover = Rover.new(index, rover_x_val, rover_y_val, rover_orientation_val)

        catch :invalid_instruction {
          lines[1].chomp.each_char { |instrctn|
            throw :invalid_instruction unless process_instruction(instrctn)
          }
        }

        curr_x = @rover.get_curr_x
        curr_y = @rover.get_curr_y
        curr_orientation = @rover.get_curr_orientation

        curr_pos_str = curr_x.to_s + "." + curr_y.to_s + "." +  curr_orientation.to_s

        is_rep = 0

        if rover_history_hash[curr_pos_str] == 0
          rover_history_hash[curr_pos_str] = 1
        else
          puts "ERROR: Collision of rovers at position: (#{curr_x}, #{curr_y}, #{curr_orientation})" 
          is_rep = 1
        end

        if is_rep == 0
          is_valid = @plateau.valid_rover_coords_in_pl?(curr_x, curr_y, curr_orientation)

          if is_valid
            @rover.output_curr_position
          else
            puts "ERROR: Final Rover Position: (#{curr_x}, #{curr_y}, #{curr_orientation}) is NOT WITHIN PLATEAU" 
          end
        end
      }
    
    end
    
  end

  # Main: Executes the program
  if __FILE__ == $PROGRAM_NAME
    main_processor = Main.new
    main_processor.process
  end
