class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end 
  
  def parent
    @parent
  end 
  
  def children
    @children
  end 
  
  def value
    @value
  end 
  
  def parent=(new_parent)
    @parent.children.delete(self) unless @parent == nil
    
    @parent = new_parent
    @parent.children << self unless @parent == nil
  end 
  
  def add_child(child_node)
    child_node.parent = self
  end 
  
  def remove_child(child_node)
    child_node.parent.nil? ? raise : child_node.parent = nil
  end 
  
  def dfs(target_value)
    return self if @value == target_value
    return nil if @children == []
    
    @children.each do |child|
      search_result = child.dfs(target_value)
      return search_result unless search_result.nil?
    end
    nil
  end
  
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      first_node = queue.shift
      return first_node if first_node.value == target_value
      queue.concat(first_node.children)
    end 
    nil
  end 
  
  def inspect
    { 'value' => @value, 'num children' => @children.count }.inspect
  end
  
end