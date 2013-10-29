class Piece

  @board = Array.new(8) {Array.new(8)}

  DIAG_DELTAS = [ [1,1],[-1,-1],[1,-1],[-1, 1]]
  STRAIGHT_DELTAS = [ [0,1],[0,-1],[1,0],[-1,0]]

  attr_accessor :pos, :board


  def initialize(board, pos)
    @board = board
    @pos = pos
    @board[pos[0]][pos[1]]= self
  end


  def moves(places_to_move)
    p places_to_move
  end




  def move
    #can't implement this because the piece
    #should use its own move method
  end

  def move_into_check?(pos)
  end

  def put_board(moves)
    @board.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        if moves.include?([i, j])
          print "  "
        else
          print "X "
        end
      end
      print "\n"
    end
  end

end


class SlidingPiece < Piece

  def moves(sym)
    if sym == :diagonal
      diag_moves = get_diag_moves
      put_board(diag_moves)
    elsif sym == :straight
      straight_moves = get_straight_moves
      put_board(straight_moves)
    else
      all_moves = get_diag_moves
      all_moves += get_straight_moves
      put_board(all_moves)
    end
  end


  def get_diag_moves
    diag_arr = []
    DIAG_DELTAS.each do |delta|
      diag_arr += get_moves(self.pos, delta)
    end

    diag_arr
  end

  def get_straight_moves
    str_arr = []
    STRAIGHT_DELTAS.each do |delta|
      str_arr += get_moves(self.pos, delta)
    end

    str_arr
  end


  # This method uses the delta to keep sliding in one direction
  def get_moves(pos, delta)
    x, y = delta
    move_arr = []
    new_pos = [pos[0] + x, pos[1] + y]
    return [] unless new_pos[0].between?(0,7) && new_pos[1].between?(0,7)

    if @board[new_pos[0]][new_pos[1]].nil?
      move_arr << new_pos
      return move_arr + get_moves(new_pos, delta)
    end

    return []
  end


end

class Bishop < SlidingPiece

  def initialize(pos)
    super(pos)
  end


  def move_dirs
    super.moves(:diagonal)
  end

end

class Rook < SlidingPiece

  # def moves
#   end

  def move_dirs
    super.moves(:straight)
  end

end

class Queen < SlidingPiece

  # def initialize(pos)
#     super(pos)
#   end

  def move
    self.moves(:all)
  end

end

# p = Piece.new(board,[3, 2])
# board = Array.new(8) {Array.new(8)}
q = Queen.new(board, [5, 4])

q.move



class SteppingPiece < Piece

  def moves
  end

end