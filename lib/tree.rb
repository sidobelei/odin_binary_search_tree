class Tree 
    require_relative "./node"

    def initialize(array)
        @root = build_tree(array.uniq.sort())
    end

    def build_tree(array)
        if array.length == 1
            data = array[0]
            return Node.new(data)
        elsif array.length == 0
            return
        end
        middle = (array.length / 2).round()
        if array.length % 2 == 0 
            middle -= 1
        end
        root = array[middle]
        node = Node.new(root)
        node.left = build_tree(array[0...middle])
        node.right = build_tree(array[middle + 1 ... array.length])
        return node 
    end

    # This method was written by another student
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end