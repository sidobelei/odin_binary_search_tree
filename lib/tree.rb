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

    def insert(value)
        node = Node.new(value)
        leaf_node = @root
        empty_branch = false
        until empty_branch
            if node < leaf_node
                if leaf_node.left.nil?
                    leaf_node.left = node
                    empty_branch = true
                else
                    leaf_node = leaf_node.left
                end
            else
                if leaf_node.right.nil?
                    leaf_node.right = node
                    empty_branch = true
                else
                    leaf_node = leaf_node.right
                end
            end
        end
    end

    def find(value)
        current_node = @root
        until current_node.data == value
            if current_node.data < value
                current_node = current_node.right
            else
                current_node = current_node.left
            end
            if current_node.nil?
                break
            end
        end
        return current_node
    end

    # This method was written by another student
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end