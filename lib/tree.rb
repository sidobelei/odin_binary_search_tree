class Tree 
    def initialize(array)
        @root = build_tree(array.sort())
    end
end