require_relative "lib/tree"

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
print "Level Order: #{tree.level_order}\n"
print "Preorder:    #{tree.preorder}\n"
print "Postorder:   #{tree.postorder}\n"
print "Inorder:     #{tree.inorder}\n"
unbalance = Array.new(9) { rand(1..100) }
unbalance.each {|node| tree.insert(node)}
tree.pretty_print
puts "Balanced? #{tree.balanced?}"
puts "Rebalance Tree."
tree.rebalance
puts "Balanced? #{tree.balanced?}"
print "Level Order: #{tree.level_order}\n"
print "Preorder:    #{tree.preorder}\n"
print "Postorder:   #{tree.postorder}\n"
print "Inorder:     #{tree.inorder}\n\n"
tree.pretty_print
