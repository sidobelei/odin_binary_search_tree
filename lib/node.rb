class Node
    include Comparable
    
    attr_accessor :left, :right
    attr_reader :data

    def initalize(data)
        @data = data
        @left = nil
        @right = nil 
    end

    def <=>(other)
        return data <=> other.data
    end
end
