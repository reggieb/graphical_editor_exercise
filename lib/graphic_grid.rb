class GraphicGrid
  attr_reader :grid

  DEFAULT_CELL = 'O'

  def initialize(columns, rows)
    @rows = rows.to_i
    @columns = columns.to_i
    @grid = make_grid_of(DEFAULT_CELL)
  end

  def delete
    @grid = nil
  end

  def change_cell(column, row, new_entry)
    @grid[grid_ref(row)][grid_ref(column)] = new_entry
  end

  def change_column(column, start_row, end_row, new_entry)
    rows = (grid_ref(start_row)..grid_ref(end_row)).to_a
    rows.each{|row| @grid[row][grid_ref(column)] = new_entry}
  end

  def change_row(start_column, end_column, row, new_entry)
    length = end_column.to_i - start_column.to_i + 1
    @grid[grid_ref(row)].fill(new_entry, grid_ref(start_column), length)
  end
  
  def find_touching_cells_with_same_content(column, row)
    @touch_grid = make_grid_of(nil)
    @content = @grid[grid_ref(row)][grid_ref(column)]
    mark_touching(grid_ref(column), grid_ref(row))
    return @touch_grid
  end


  private
  def mark_touching(column, row)
    if column >= 0 and column < @columns and row >= 0 and row < @rows and @touch_grid[row][column] == nil
      if @grid[row][column] == @content
        @touch_grid[row][column] = true
        cell_above = [column, row - 1]
        cell_to_right = [column + 1, row]
        cell_below = [column, row + 1]
        cell_to_left = [column - 1, row]
        for cell in [cell_above, cell_to_right, cell_below, cell_to_left]
          mark_touching(*cell)
        end
      else
        @touch_grid[row][column] = false
      end
    end
  end

  def grid_ref(ref)
    ref.to_i - 1
  end

  def make_grid_of(content)
    Array.new(@rows) {|row| Array.new(@columns, content)}
  end
end
