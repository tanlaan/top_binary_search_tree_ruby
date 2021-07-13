class Tree
    @attr_reader(:root)

    def initialize(values)
        @root = self.build_tree(values)
    end
    
    def build_tree(values)
        # Recursivly return a balanced binary tree
        
        # Sort our values....
        values.sort!

        # Create a node for our middle value
        root = Node.new()

    end
end

class Node
    attr_accessor(:data, :left, :right)

    def initialize(data = nil, left = nil, right = nil)
        @data = data
        @left = left
        @right = right
    end
        
end