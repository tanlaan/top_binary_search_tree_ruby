require_relative './binary_search_tree.rb'
foo = Tree.new(Array.new(15) {rand(1..100)})
p foo.level_order
p foo.preorder
p foo.postorder
p foo.inorder
(1..10).each do 
    foo.insert(rand(101..200))
end
p "Am I balanced? #{foo.balanced?}"
foo.rebalance
p "How about now? #{foo.balanced?}"
p foo.level_order
p foo.preorder
p foo.postorder
p foo.inorder
foo.pretty_print