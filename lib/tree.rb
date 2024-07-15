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
        middle = (array.length / 2)
        root = array[middle]
        node = Node.new(root)
        node.left = build_tree(array[0...middle])
        node.right = build_tree(array[middle + 1 .. array.length])
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

    def delete(value)
        parent_node = nil
        current_node = @root
        next_node = nil
        until current_node.data == value
            parent_node = current_node
            if current_node.data < value
                current_node = current_node.right
            else
                current_node = current_node.left
            end
            if current_node.nil?
                return
            end
        end
        if !current_node.left.nil? && !current_node.right.nil?
            next_node = current_node.right
            parent_node = current_node.right
            until next_node.left.nil?
                parent_node = next_node
                next_node = next_node.left
            end
            current_node.data = next_node.data
            unless parent_node.left.nil?
                parent_node.left = nil
            else
                current_node.right = parent_node.right
            end
        else    
            if current_node.left.nil?
                next_node = current_node.right
            elsif current_node.right.nil?
                next_node = current_node.left
            end
            if parent_node.nil?
                @root = next_node
            elsif parent_node.left == current_node
                parent_node.left = next_node
            else
                parent_node.right = next_node
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

    def level_order
        array = []
        queue = [@root]
        return array if @root.nil?
        until queue.empty?
            yield queue[0] if block_given? 
            array.push(queue[0].data)
            if !queue[0].left.nil?
                queue.push(queue[0].left)
            end
            if !queue[0].right.nil?
                queue.push(queue[0].right)
            end
          queue.shift
        end
        return array
    end

    def inorder(current_node = @root, array = [], &block)
        if current_node.nil?
            return array
        end
        if !current_node.left.nil?
            array = inorder(current_node.left, array, &block)
        end
        array.push(current_node.data)
        yield current_node if block_given?
        if !current_node.right.nil?
            array = inorder(current_node.right, array, &block)
        end
        return array
    end

    def preorder(current_node = @root, array = [], &block)
        if current_node.nil?
            return array
        end
        array.push(current_node.data)
        yield current_node if block_given?
        if !current_node.left.nil?
            array = preorder(current_node.left, array, &block)
        end
        if !current_node.right.nil?
            array = preorder(current_node.right, array, &block)
        end
        return array 
    end
    
    def postorder (current_node = @root, array = [], &block)
        if current_node.nil?
            return array
        end
        if !current_node.left.nil?
          array = postorder(current_node.left, array, &block)
        end
        if !current_node.right.nil?
          array = postorder(current_node.right, array, &block)
        end
        array.push(current_node.data)
        yield current_node if block_given?
        return array
    end

    def height(node = @root)
        return if find(node.data).nil?
        height = 0
        parent_queue = [node]
        child_queue = []
        until parent_queue.empty? && child_queue.empty?
            if !parent_queue[0].left.nil?
                child_queue.push(parent_queue[0].left)
            end
            if !parent_queue[0].right.nil?
                child_queue.push(parent_queue[0].right)
            end
            parent_queue.shift
            if !child_queue.empty? && parent_queue.empty?
                parent_queue = child_queue
                child_queue = []
                height += 1
            end
        end
        return height
    end

    # This method was written by another student
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end