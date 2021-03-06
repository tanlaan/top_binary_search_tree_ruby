class Tree
    attr_reader(:root)

    def initialize(values)
        @root = self.build_tree(values)
    end
    
    def build_tree(values)
        # Recursivly return a balanced binary tree

        # Base cases
        return nil if values.nil? || values.length == 0
        return Node.new(values[0]) if values.length == 1
        
        # Sort our values, and remove duplicates...
        p values
        values.sort!.uniq!

        # Create a node for our middle value
        halfway = values.length / 2
        return Node.new(
            values[halfway], 
            build_tree(values.slice(0, halfway)),
            build_tree(values.slice(halfway + 1, values.length))
        )
    end

    def insert(value, current_node = @root)
        # Base case, either the value was in the list or we added it
        return if current_node.data == value

        # Insert left
        current_node.left = Node.new(value) if value < current_node.data && current_node.left.nil?
        # Insert right
        current_node.right = Node.new(value) if value > current_node.data && current_node.right.nil?

        # Go left
        insert(value, current_node.left) if value < current_node.data
        # Go right
        insert(value, current_node.right) if value > current_node.data
    end

    def delete(value)
        last_node = nil
        current_node = @root
        from_left = false
        # Search for node to delete
        until current_node.data == value
            last_node = current_node
            if value < current_node.data
                current_node = current_node.left
                from_left = true
            else
                current_node = current_node.right
                from_left = false
            end
        end

        # Case leaf, remove reference in last_node
        if current_node.left.nil? && current_node.right.nil?
            from_left ? last_node.left = nil : last_node.right = nil
        # Case single child, replace reference in last_node
        elsif current_node.left.nil?  
            from_left ? last_node.left = current_node.right : last_node.right = current_node.right
        elsif current_node.right.nil? 
            from_left ? last_node.left = current_node.left : last_node.right = current_node.left
        # Case multiple child, replace reference in last_node with smallest right tree value
        else
            secondary_last_node = current_node
            secondary_current_node = current_node.right
            until secondary_current_node.left.nil?
                secondary_last_node = secondary_current_node
                secondary_current_node = secondary_current_node.left
            end
            secondary_last_node.left = nil
            secondary_current_node.left = current_node.left
            secondary_current_node.right = current_node.right
            from_left ? last_node.left = secondary_current_node : last_node.right = secondary_current_node
        end
    end

    def find(value)
        current_node = @root
        until current_node.data == value
            value < current_node.data ? current_node = current_node.left : current_node = current_node.right
            # Value not found
            return nil if current_node == nil
        end
        current_node
    end

    def level_order
        # Return an array of the level ordered binary tree values
        node_queue = [@root]
        level_order = []
        # Populate level_order with value
        # If left child add to queue
        # If right child add to queue
        while node_queue.length > 0
            current_node = node_queue.slice!(0)
            level_order.append(current_node.data)
            node_queue.append(current_node.left) unless current_node.left.nil?
            node_queue.append(current_node.right) unless current_node.right.nil?
        end
        level_order
    end

    def inorder(current_node = @root)
        # Return an array of the inorder ordered binary tree values
        # (Left, Data, Right)

        # Base case
        return [] if current_node.nil?
        inorder(current_node.left)  + [ current_node.data ] + inorder(current_node.right)
    end

    def preorder(current_node = @root)
        # Return an array of the preorder ordered binary tree values
        # (Data, Left, Right)

        # Base case
        return [] if current_node.nil?
        [ current_node.data ] + preorder(current_node.left) + preorder(current_node.right)
    end

    def postorder(current_node = @root)
        # Return an array of the postorder ordered binary tree values
        # (Left, Right, Data)

        # Base case
        return [] if current_node.nil?
        postorder(current_node.left) + postorder(current_node.right) + [ current_node.data ]
    end

    def height(current_node = @root, current_height = 0)
        # Return the longest path from the given node to a leaf
        return 0 if current_node.nil?

        [ current_height, 
          height(current_node.left, current_height + 1),
          height(current_node.right, current_height + 1)
        ].max
    end

    def depth(current_node)
        height(@root) - height(current_node)
    end

    def balanced?
        (height(@root.left) - height(@root.right)).abs <= 1
    end

    def rebalance
        @root = build_tree(self.level_order)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '???   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '????????? ' : '????????? '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '???   '}", true) if node.left
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