class Piece

  def moves
    places = []
  end

  def move
  end

end

class SlidingPiece < Piece
  @board # has the board reference

  def moves(dir)

  end

end

class Bishop < SlidingPiece


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