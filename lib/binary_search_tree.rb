class Tree
    attr_reader(:root)

    def initialize(values)
        @root = self.build_tree(values)
    end
    
    def build_tree(values)
        # Recursivly return a balanced binary tree
        p values

        # Base cases
        return nil if values.nil? || values.length == 0
        return Node.new(values[0]) if values.length == 1
        
        # Sort our values...
        values.sort!

        # Create a node for our middle value
        halfway = values.length / 2
        return Node.new(
            values[halfway], 
            build_tree(values.slice(0, halfway)),
            build_tree(values.slice(halfway + 1, values.length))
        )
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