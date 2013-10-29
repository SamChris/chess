class Piece
  DIAG_DELTAS = [ [1,1],[-1,-1],[1,-1],[-1, 1]]
  STRAIGHT_DELTAS = [ [0,1],[0,-1],[1,0],[1,-1]]

  attr_accessor :pos


  def initialize(board, pos)
    @board = board
    @pos = pos
    @board[pos[0]][pos[1]]= self
  end


  def moves
    places = []
  end

  def move
  end

  def move_into_check?(pos)
  end

  def get_diagonal_moves
    diag_arr = []
    DIAG_DELTAS.each do |delta|
      diag_arr += get_moves(self.pos, delta)
    end

    diag_arr
  end

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

board = Array.new(8) {Array.new(8)}
 p = Piece.new(board, [3, 4])


class SlidingPiece < Piece


  def moves(dir)
    if dir == :diagonal
      diag_moves = super.get_diag_moves
      return diag_moves
    elsif dir == :straight
      straight = super.get_straight_moves
      return straight
    else
      all = super.get_diag_moves
      all += super.get_straight_moves
      return all
    end
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

  # def moves
  # end

  def move_dirs
    super.moves(:all)
  end

end

class SteppingPiece < Piece

  def moves
  end

end