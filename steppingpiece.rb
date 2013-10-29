class SteppingPiece < Piece

  def moves(sym)
    if sym == :knight
      knight_moves = get_knight_moves
      p knight_moves
      put_board(knight_moves)
    elsif sym == :king
      king_moves = get_king_moves
      put_board(king_moves)
    end
  end


  def get_knight_moves
    knight_arr = []
    KNIGHT_DELTAS.each do |delta|
      knight_arr << get_moves(self.pos, delta)
    end

    knight_arr
  end

  def get_king_moves
    king_arr = []
    KING_DELTAS.each do |delta|
      king_arr << get_moves(self.pos, delta)
    end

    king_arr
  end


  # This method uses the delta to keep sliding in one direction
  def get_moves(pos, delta)
    x, y = delta
    move_arr = []
    new_pos = [pos[0] + x, pos[1] + y]
    return [] unless new_pos[0].between?(0,7) && new_pos[1].between?(0,7) &&
                    @board[new_pos[0]][new_pos[1]].nil?
    p new_pos
    new_pos
  end


end


class Knight < SteppingPiece

  #def moves
#   end

  def move
    self.moves(:knight)
  end

end






class King < SteppingPiece

  # def initialize(pos)
#     super(pos)
#   end

  def move
    self.moves(:king)
  end

end

board = Array.new(8) {Array.new(8)}

k = Knight.new(board, [5, 4])

k.move


