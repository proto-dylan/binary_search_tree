class Node
    attr_accessor :left, :data, :right
    def initialize(data, left=nil, right=nil)
        @left = left
        @data = data
        @right = right
    end
end
    
def build_tree(arr, start=0, last=0)

    return nil if start > last

    arr.sort!.uniq!

    start = 0
    last = arr.size
    mid = (start + last)/2

    if arr[mid] != nil #this line removes empty nodes
        root = Node.new(arr[mid])
        left = arr[start...mid]
        right = arr[mid + 1..last]
        
        root.left = build_tree(left, start, mid - 1)
        root.right = build_tree(right, mid + 1, last)
    end 

    return root
end

class Tree

    attr_reader :root
    def initialize(arr)
        @root = build_tree(arr)
    end


end


#### Thanks to Fensus via run-after ####
def pretty_print(node = root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
end

arr1 = [2,5,8,4,3,21,34,14,13]
  
tree = Tree.new(arr1)
pretty_print(tree.root)