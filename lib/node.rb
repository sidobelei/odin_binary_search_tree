class Node
    include Comparable

    attr_accessor :left, :right, :data

    def initialize(data)
        @data = data
        @left = nil
        @right = nil 
    end

    def <=>(other)
        return data <=> other.data
    end
end