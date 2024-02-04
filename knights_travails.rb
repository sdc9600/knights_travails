require 'pry-byebug'

class Knight
  @@moves = [[2,1],[2, -1], [1, 2], [1, -2], [-1, 2], [-1, -2], [-2, 1], [-2, -1]]
  attr_accessor :moves, :starting_square
  def initialize
    end

  def possible_moves(current_square)
    current_square[2] = 0 if current_square[2] == nil
    @@moves.map {|value| [current_square[0] + value[0], current_square[1] + value[1], current_square[2] + 1]}.select {|value| value[0] >= 0 && value[0] < 8 && value[1] >= 0 && value[1] < 8}
  end

  def graph(knight)
    queue = [knight]
    visited = []
    depth = {}

    until queue.empty?
       possible_moves(queue[0]).each {|value| queue.append(value) unless queue.include?([value[0], value[1]]) || visited.include?([value[0],value[1]])}
       depth[queue[0]] = queue[0][-1] unless visited.include?([queue[0][0], queue[0][1]])
       visited.append([queue[0][0], queue[0][1]]) unless visited.include?([queue[0][0], queue[0][1]])
       
       queue.shift
    end
    depth.each {|k,v| k.pop}
    depth
  end 

  def knight_moves(start_square, end_square)
    start_square.append(0)
    distance = [0]
    path = [start_square]
    tmp = start_square
    local_depth = graph(start_square)
    local_depth.each {|k,v| distance = v if k == end_square}
    p distance


      until path.last == end_square
      possible_moves(path.last).each do |value|
        hash = graph(value)
          hash.select! {|k,v| k == end_square}.values == [0]
          if hash.values == [distance]
          p hash
          path.append(value)
          distance -= 1
         end
      end
    end
    path.each {|entry| entry.pop if entry[2] != nil}
    path
  end
end

knight = Knight.new
p knight.knight_moves([4,4], [5,5])
