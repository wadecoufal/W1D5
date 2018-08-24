require 'byebug'
class PolyTreeNode
  
  attr_reader :parent, :children, :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(parent)
    if @parent
      @parent.children.delete(self)
    end
    @parent = parent
    @parent.children << self unless @parent == nil
  end
  
  def add_child(child_node)
      child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "No child found" unless @children.include?(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end
  
  def inspect
    "Node: value: #{value} children: #{@children.map {|child| child.value}}"
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    @children.each do |child|
      result = child.dfs(target_value)
      return result unless result == nil
    end
    nil
  end
  
  def bfs(target_value)
    
    queue_arr = [self]
    
    until queue_arr.empty?
      curr_node = queue_arr.pop
      return curr_node if curr_node.value == target_value
      
      curr_node.children.each do |child|
        queue_arr.unshift(child)
      end
      
    end
    
    nil
  end
  
  
  
  
end