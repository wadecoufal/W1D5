require_relative '../PolyTreeNode/lib/00_tree_node.rb'
require 'byebug'
class KnightPathFinder
  attr_reader :visited_positions, :move_tree
  
  def initialize(start_pos)
    @move_tree = PolyTreeNode.new(start_pos) # Node: val [0,0], children: []
    @visited_positions = [start_pos] #TODO   # [[0,0]]
    self.build_move_tree
  end
  
  def build_move_tree 
    tree_queue = [@move_tree]
    
    until tree_queue.empty?
      curr_node = tree_queue.pop #@move_tree
      new_moves = new_move_positions(curr_node.value)  # [0,0] => [1,2],[2,1]
      new_moves.each do |pos| # [1,2]
        child_node = PolyTreeNode.new(pos) # node: val: [1,2]
        curr_node.add_child(child_node) #@move_tree.add_childe([1,2])
        tree_queue.unshift(child_node)
      end
    end
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
    possible_moves.select {|pos| KnightPathFinder.on_board?(pos)}
  end
  
  def self.on_board?(pos)
    pos.all? { |num| num.between?(0,7) }
  end
  
  def find_path(end_pos)
    # search_node = PolyTreeNode.new(end_pos)
    found_node = @move_tree.dfs(end_pos)
    trace_path_back(found_node)
  end
  
  def trace_path_back(found_node)
    curr_node = found_node
    path_arr = [curr_node.value]
    until curr_node.parent == nil
      parent = curr_node.parent
      path_arr.unshift(parent.value)
      curr_node = parent
    end

    path_arr
  end
  

end

if __FILE__ == $PROGRAM_NAME
  knight = KnightPathFinder.new([0,0])
  p knight.find_path([7,6])
end