
class Board
  attr_accessor :spaces, :columns, :rows
  
  def initialize(columns = 7, rows = 6)
    @columns = columns
    @rows = rows
    @spaces = Array.new(columns) { Array.new(rows) { " " } }
  end 

  def height
    @spaces[0].size
  end

  def width
    @spaces.size
  end

  def set_piece(column, piece)
    if valid_input?(column)
      row = find_next_open_space(column)
      @spaces[column-1][row - 1] = piece
      row
    else
      -1
    end    
  end

  def get_piece(column, row)
    if valid_input?(column, row)
      piece = @spaces[column - 1][row - 1]
    else 
      return nil
    end
  end

  def find_next_open_space(column)
    row = 1
    until get_piece(column, row) == " " || !valid_input?(column, row)
      row += 1
    end
    row
  end

  def check_win?(column, row)
    win_condition = 3
    win = false
    i = 0

    possible_win_paths = collect_paths(column, row)
    puts possible_win_paths.inspect
    until win || possible_win_paths[i].nil?
      last_mark = ""
      marks_in_row = 0

      possible_win_paths[i].each do |mark|
        if mark == last_mark
          marks_in_row += 1 
        else
          marks_in_row = 0
        end
        last_mark = mark 
        win = true if marks_in_row >= win_condition && last_mark != " "
      end
      i += 1
    end
    win
  end

  def collect_paths(column, row)
    paths = []
    puts "collecting paths"
    paths << get_vertical_path(column)
    paths << get_horizontal_path(row)    
    paths << get_upward_path(column, row)
    paths << get_downward_path(column, row)

    paths
  end

  def get_vertical_path(column)
    @spaces[column - 1]
  end

  def get_horizontal_path(row)
    row_values = []

    @columns.times do |column|
      row_values << get_piece(column + 1, row)
    end
    row_values
  end

  def get_downward_path(column, row)
    path = []
    working_row = get_starting_row_dw(column, row)

    @columns.times do |column_number|
      path << get_piece(column_number + 1, working_row) if valid_input?(column_number + 1, working_row)
      working_row -= 1
    end
    path
  end

  def get_upward_path(column, row)
    path = []
    working_row = get_starting_row_uw(column, row)

    @columns.times do |column_number|
      path << get_piece(column_number + 1, working_row) if valid_input?(column_number + 1, working_row)
      working_row += 1
    end
    path
  end

  def valid_input?(column = 1, row = 1)
    if column > @columns || column < 1 || row > @rows || row < 1
      false
    else
      true
    end
  end

  def get_starting_row_uw(column, row)
    row - (column - 1)
  end

  def get_starting_row_dw(column, row)
    row + column - 1
  end

  def show
    output = "C:"

    @columns.times { |i| output += "#{i + 1}|" }    

    @rows.times do |i| 
      line = ["#{i + 1}"]
      @columns.times do |j|
        line << get_piece(j + 1, i + 1)
      end
      output += "\n#{line.join("|")}|"
    end
    puts output
  end
end
