class Tree
    @attr_reader(:root)

    def initialize(values)
        @root = self.build_tree(values)
    end
    
    def build_tree(values)
        # Return a balanced binary tree
    end
end

class Node
    attr_accessor(:data, :left, :right)

    def initialize(data, left, right)
        @data = data
        @left = left
        @right = right
    end
        
end