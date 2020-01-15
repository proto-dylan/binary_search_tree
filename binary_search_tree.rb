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

    if arr[mid] != nil 
        root = Node.new(arr[mid])
        left = arr[start...mid]
        right = arr[mid + 1..last]
        
        root.left = build_tree(left, start, mid - 1)
        root.right = build_tree(right, mid + 1, last)
    end 

    return root
end

def rebuild(tree)
    arr = []

    tree.in_order do |node|
        if !node.data.nil?
            arr << node.data
        end
      end
    puts "Arr: #{arr}"
    @tree = Tree.new(arr)
    
end


class Tree
    attr_reader :root, :tree

    def initialize(arr)
        @root = build_tree(arr)
    end

    def insert(node = self.root, new_data)
        
        if new_data < node.data
            if node.left == nil
                node.left = Node.new(new_data)
                return @root
            end
            insert(node.left, new_data)
        else
            if node.right == nil
                node.right = Node.new(new_data)
                return@root
            end
            insert(node.right, new_data)
        end
    
    end
    
    def in_order(node=@root, &block)
        return if node.nil?
        in_order(node.left, &block)
        yield node
        in_order(node.right, &block)
    end

    def pre_order(node=@root, &block)
        return if node.nil?
        yield node
        in_order(node.left, &block)
        in_order(node.right, &block)
    end

    def post_order(node=@root, &block)
        return if node.nil?
        in_order(node.left, &block)
        in_order(node.right, &block)
        yield node
    end

   

    def search( data, node=@root )
    
        return nil if node.nil?
        if data < node.data
          search( data, node.left )
        elsif data > node.data
          search( data, node.right )
        else
            puts "Data-match found at node: #{node}"
            return node
        end
        
    end

    def delete( delete_data )
        target_node = search(delete_data)

        if target_node.nil?
            puts " Target node NIL" 
        else
            rec_del(target_node)
        end
    end    

    def rec_del( target_node )
        parent = @parent
        
        if target_node.left.nil? && target_node.right.nil?
            target_node.data = nil
               
        elsif target_node.left.nil? || target_node.right.nil?
        
            if !target_node.left.nil?
                target_node.data = target_node.left.data
                target_node = target_node.left
                rec_del(target_node)
                target_node.data = nil
                target_node=nil

            else
                target_node.data = target_node.right.data
                target_node = target_node.right
                rec_del(target_node)
                target_node.data nil 
                target_node = nil     
            end
        elsif !target_node.left.nil? && !target_node.right.nil?
            target_node.data = target_node.left.data
            target_node= target_node.left
            rec_del(target_node)  
            target_node = nil
        end
    
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
tree.insert(77)

pretty_print(tree.root)

tree.delete(8)
pretty_print(tree.root)


tree.insert(54)
tree.insert(12)
tree.insert(7)
pretty_print(tree.root)

rebuild(tree)
pretty_print(@tree.root)



