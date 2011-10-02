$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'graphic_grid'

class GraphicGridTest < Test::Unit::TestCase

  def setup
    @graphic_grid = GraphicGrid.new('4', '3')
  end

  def test_grid_for_new
    @expected = [%w{O O O O}, %w{O O O O}, %w{O O O O}]
    assert_grid_matches_expected
  end

  def test_delete
    @graphic_grid.delete
    assert_nil(@graphic_grid.grid)
  end

  def test_change_cell
    @graphic_grid.change_cell('2', '3', 'X')
    @graphic_grid.change_cell('3', '3', 'Y')
    @graphic_grid.change_cell('2', '1', 'Z')
    @expected = [%w{O Z O O}, %w{O O O O}, %w{O X Y O}]
    assert_grid_matches_expected
  end

  def test_change_column
    @graphic_grid.change_column('2', '2', '3', 'A')
    @graphic_grid.change_column('1', '1', '3', 'B')
    @expected = [%w{B O O O}, %w{B A O O}, %w{B A O O}]
    assert_grid_matches_expected
  end

  def test_change_row
    @graphic_grid.change_row('1', '3', '1', 'G')
    @graphic_grid.change_row('2', '3', '2', 'H')
    @graphic_grid.change_row('1', '4', '3', 'I')
    @expected = [%w{G G G O}, %w{O H H O}, %w{I I I I}]
    assert_grid_matches_expected
  end

  def test_find_touching_cells_with_same_content_when_all_same
    result = @graphic_grid.find_touching_cells_with_same_content('2', '2')
    expected = [[true, true, true, true], [true, true, true, true], [true, true, true, true]]
    assert_equal(expected, result)
  end

  def test_find_touching_cells_with_same_content_within_box
    change_graphic_grid_to_having_central_box
    result = @graphic_grid.find_touching_cells_with_same_content('2', '2')
    expected = [[nil, false, false, nil], [false, true, true, false], [false, true, true, false], [nil, false, false, nil]]
    assert_equal(expected, result)
  end

  def test_find_touching_cells_with_same_content_outside_box
    change_graphic_grid_to_having_central_box
    result = @graphic_grid.find_touching_cells_with_same_content('1', '1')
    expected = [[true, true, true, true], [true, false, false, true], [true, false, false, true], [true, true, true, true]]
    assert_equal(expected, result)
  end

  private
  def assert_grid_matches_expected
    assert_equal(@expected, @graphic_grid.grid)
  end

  def change_graphic_grid_to_having_central_box
    @graphic_grid = GraphicGrid.new('4', '4')
    @graphic_grid.change_row('2', '3', '2', 'H')
    @graphic_grid.change_row('2', '3', '3', 'H')
  end

end
