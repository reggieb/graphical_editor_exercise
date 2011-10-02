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

  private
  def assert_grid_matches_expected
    assert_equal(@expected, @graphic_grid.grid)
  end

end
