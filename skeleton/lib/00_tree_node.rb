class PolyTreeNode
  attr_reader :parent, :children, :value

  def initialize(value, parent = nil)
    @value = value
    @parent = parent
    @children = []
  end

  def parent=(parent_node)
    #Delete child from previous parent if previous parent exists
    self.parent.children.delete(self) unless self.parent.nil?

    #Assign new parent
    @parent = parent_node

    #Assign self to parent's children array unless parrent is nil
    parent_node.children << self unless self.parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not my child!" unless  self.children.include?(child_node)
    self.children.delete(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    result = [self]

    until result.empty?
      first_val = result.shift
      return first_val if first_val.value == target_value
      first_val.children.each {|child| result.push(child)}
    end

    nil
  end
end
