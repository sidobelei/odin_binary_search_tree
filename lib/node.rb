class Node
    attr_accessor :left, :right
    attr_reader :data

    def initalize(data)
        @data = data
        @left = nil
        @right = nil 
    end
end
