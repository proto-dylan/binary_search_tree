class BinarySearchTree
    class Node
      attr_reader :key, :left, :right
  
 # On initialization, the @key variable is set. This is used in the insert method below as the parent for the @left and @right nodes.
  
   
      def initialize( key )
        @key = key
        @left = nil
        @right = nil
      end
  
 # Inserting at the node level will check what the new key is in order to insert it in the appropriate place. The restriction being that the key in any node is larger than the keys in all nodes in that node’s left sub-tree and smaller than the keys in all nodes in that node’s right sub-tree.
  
   
      def insert( new_key )
        if new_key <= @key
          @left.nil? ? @left = Node.new( new_key ) : @left.insert( new_key )
        elsif new_key > @key
          @right.nil? ? @right = Node.new( new_key ) : @right.insert( new_key )
        end
      end
    end
  
  #Initialize the @root variable to nil.
  
   
    def initialize
      @root = nil
    end
  
 # Inserting at the BinarySearchTree level looks if there is a @root node, if not it creates one. If there is then the insert is delegated the the Node level.
  
   
    def insert( key )
      if @root.nil?
        @root = Node.new( key )
      else
        @root.insert( key )
      end
    end
  
  #This is in order traversal (recursive implementation). Notice hold the yield for visting the node is in between the two recursive calls for left and right nodes respectively.
  
   
    def in_order(node=@root, &block)
      return if node.nil?
      in_order(node.left, &block)
      yield node
      in_order(node.right, &block)
    end
  
  #This is pre order traversal (recursive implementation). Notice hold the yield for visting the node is before the two recursive calls for left and right nodes respectively.
  
   
    def pre_order(node=@root, &block)
      return if node.nil?
      yield node
      in_order(node.left, &block)
      in_order(node.right, &block)
    end
  
  #This is post order traversal (recursive implementation). Notice hold the yield for visting the node is after the two recursive calls for left and right nodes respectively.
  
   
    def post_order(node=@root, &block)
      return if node.nil?
      in_order(node.left, &block)
      in_order(node.right, &block)
      yield node
    end
  
  #This is where you get to see the binary search tree shine. A recursive approach is taken to traverse the tree, each time disregarding half of the nodes in the tree. With this you will get O( log n ) time.
  
   
    def search( key, node=@root )
      return nil if node.nil?
      if key < node.key
        search( key, node.left )
      elsif key > node.key
        search( key, node.right )
      else
        return node
      end
    end
  
    def check_height(node)
      return 0 if node.nil?
  
      leftHeight = check_height(node.left)
      return -1 if leftHeight == -1
  
      rightHeight = check_height(node.right)
      return -1 if rightHeight == -1
  
      diff = leftHeight - rightHeight
      if diff.abs > 1
        -1
      else
        [leftHeight, rightHeight].max + 1
      end
    end
  
    def is_balanced?(node=@root)
      check_height(node) == -1 ? false : true
    end
  
  end
  
  tree = BinarySearchTree.new
  tree.insert(50)
  tree.insert(25)
  tree.insert(75)
  tree.insert(12)
  tree.insert(37)
  tree.insert(87)
  tree.insert(63)
  
  temp = tree.search(25)
  puts "temp = #{temp}"