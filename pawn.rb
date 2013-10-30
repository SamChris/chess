class Pawn < Piece
  attr_accessor :first_move

  def initialize(board, pos, color)
    super(board, pos, color)
    @first_move = true
  end


  def moves(sym)
    pawn_moves = get_moves(self.pos)
    put_board(pawn_moves)
    pawn_moves
  end


  def get_moves(pos)
    if self.color == :W ? p_delta = -1 : p_delta = 1
    x, y = pos
    move_arr = []

    new_pos = [x+p_delta, y-1]

    if new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
      move_arr <<  new_pos if self.board.has_enemy?(new_pos, self.color)
    end

    new_pos = [x+p_delta, y+1]

    if new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
      move_arr <<  new_pos if self.board.has_enemy?(new_pos, self.color)
    end

    new_pos = [x+p_delta, y]

    if new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
      if self.board.is_empty?(new_pos)
         move_arr <<  new_pos
         if first_time
            first_time = false
            new_pos = [x+p_delta+p_delta, y]
            move_arr <<  new_pos if self.board.is_empty?(new_pos)
         end
      end
    end

    move_arr

  end



end