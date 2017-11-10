require_relative '../PolyTree/lib/00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  
  attr_accessor :visited_positions
  
  MOVE_ARRAY = [[1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]]
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @start_node = PolyTreeNode.new(@start_pos)
    build_move_tree
    
  end 
  
  def self.valid_moves(pos)
    x, y = pos
    valids = []
    MOVE_ARRAY.each do |modifier|
      new_x = x + modifier.first 
      new_y = y + modifier.last
      if new_x >= 0 && new_x <= 8 && new_y >= 0 && new_y <= 8
        valids << [new_x, new_y]
      end 
    end 
    valids
  end 
  
  def build_move_tree
    queue = [@start_node]
    until queue.empty?
      first_node = queue.shift
      next_poses = new_move_positions(first_node.value)
      next_poses.each do |position|
        next_node = PolyTreeNode.new(position)
        next_node.parent = first_node
        queue << next_node
      end 
    end 
  end 
  
  def new_move_positions(pos)
    all_pos = KnightPathFinder.valid_moves(pos)
    new_moves = all_pos.reject {|positions| @visited_positions.include?(positions)}
    @visited_positions.concat(new_moves)
    new_moves
  end
  
  def find_path(end_pos)
    trace_path_back(@start_node.dfs(end_pos))
  end 
  
  def trace_path_back(end_node)
    result = []
    until end_node.nil?
      result << end_node.value
      end_node = end_node.parent
    end
    result
  end 
end 