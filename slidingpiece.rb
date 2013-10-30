class SlidingPiece < Piece

  def moves(sym)
    if sym == :diagonal
      diag_moves = get_diag_moves
      # put_board(diag_moves)
      diag_moves
    elsif sym == :straight
      straight_moves = get_straight_moves
      # put_board(straight_moves)
      straight_moves
    else
      all_moves = get_diag_moves
      all_moves += get_straight_moves
      # put_board(all_moves)
      all_moves
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

    #if there is empty space then keep on sliding
    if @board.b_arr[new_pos[0]][new_pos[1]].nil?
      move_arr << new_pos
      return move_arr + get_moves(new_pos, delta)
    end

    #if there is an opposing piece then add its position and terminate
    if ( @board.b_arr[new_pos[0]][new_pos[1]].color != self.color )
       move_arr << new_pos
       return move_arr
    end



    return []
  end


end




class Bishop < SlidingPiece

  def move
    self.moves(:diagonal)
  end

end

class Rook < SlidingPiece

  #def moves
#   end

  def move
    self.moves(:straight)
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










