class GraphicGrid
  attr_reader :grid

  DEFAULT_CELL = 'O'

  def initialize(columns, rows)
    @grid = Array.new(rows.to_i) {|row| Array.new(columns.to_i, DEFAULT_CELL)}
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

  private
  def grid_ref(ref)
    ref.to_i - 1
  end
end
