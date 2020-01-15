class BinarySearchTree
  attr_accessor :root

  def initialize(array)
    @root = nil
    build(array)
  end


  def breadth_first_search(value)
    current = @root
    queue = []
    loop do
      return current if current.value == value
      queue << current.left_child unless current.left_child.nil?
      queue << current.right_child unless current.right_child.nil?
      return nil if queue.empty?
      current = queue.shift
    end
  end

  def depth_first_search(value)
    current = @root
    stack = []
    loop do
      return current if current.value == value
      stack << current.right_child unless current.right_child.nil?
      stack << current.left_child unless current.left_child.nil?
      return nil if stack.empty?
      current = stack.pop
    end
  end

  def dfs_req(value, current = @root)
    if current.value == value
      return current
    else
      node = nil
      node = dfs_req(value, current.left_child) unless current.left_child.nil?
      if node.nil?
        node = dfs_req(value, current.right_child) unless current.right_child.nil?
      end
      node
    end    
  end

  private

  def build(array)
    @root = Node.new(array.shift)
    until array.empty?
      current = Node.new(array.shift)
      add_node(current, root)
    end
  end

  def add_node(current, parent)
    current.parent = parent
    if current.value < parent.value
      if parent.left_child == nil
        parent.left_child = current
      else
        add_node(current, parent.left_child)
      end
    else
      if parent.right_child == nil
        parent.right_child = current
      else
        add_node(current, parent.right_child)
      end
    end
  end
  
end

class Node
  attr_accessor :parent, :left_child, :right_child, :value

  def initialize(value = nil)
    @parent = nil
    @left_child = nil
    @right_child = nil
    @value = value
  end

end

def pretty_print(node = parent, prefix="", is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right_child
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.value.to_s}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left_child
end


  




tree = BinarySearchTree.new([5,7,1,15,9,2,14,8,7,3])
puts tree.to_s
pretty_print(tree.root)