require_relative '../PolyTreeNode/lib/00_tree_node.rb'

class KnightPathFinder
  
  def initialize(start_pos)
    @root_node = PolyTreeNode.new(start_pos)
    # @move_tree = self.build_move_tree
    @visited_positions = [start_pos] #TODO
  end
  
  def new_move_positions(pos)
    new_positions = KnightPathFinder.valid_moves(pos).reject { |pos1| @visited_positions.include?(pos1) }
    @visited_positions += new_positions
    new_positions
  end
  
  def self.valid_moves(pos)
    possible_moves = []
    row, col = pos
    possible_moves << [row+1, col+2] 
    possible_moves << [row+1, col-2]
    possible_moves << [row-1, col+2]
    possible_moves << [row-1, col-2]
    possible_moves << [row+2, col+1]
    possible_moves << [row+2, col-1]
    possible_moves << [row-2, col+1]
    possible_moves << [row-2, col-1]
    possible_moves.select {|pos| KnightPathFinder.off_board?(pos)}
  end
  
  def self.on_board?(pos)
    pos.all? { |num| num.between?(0,7) }
  end
  
  
  

end