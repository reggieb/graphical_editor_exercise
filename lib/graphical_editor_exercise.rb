require 'graphic_grid'

input = ""

commands = {
  'I' => :populate,
  'C' => :delete,
  'L' => :change_cell,
  'V' => :change_column,
  'H' => :change_row,
  'F' => :change_touching_cells
}

graphic_grid = GraphicGrid.new

while input[0,1] != 'X'
  input = gets
  elements = input.split(/\s+/)
  command = elements.delete_at(0)
  
  if command == 'S'
    graphic_grid.grid.each{|row| puts row.join}
  elsif command == 'X'
    exit
  elsif commands.keys.include?(command)
    graphic_grid.send(commands[command], *elements)
  else
    puts 'Command not recognised'
  end
end
