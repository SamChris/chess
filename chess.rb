require './slidingpiece'
require './steppingpiece'

class Piece

  # @board = Array.new(8) {Array.new(8)}

  DIAG_DELTAS = [ [1,1],[-1,-1],[1,-1],[-1, 1]]
  STRAIGHT_DELTAS = [ [0,1],[0,-1],[1,0],[-1,0]]
  KNIGHT_DELTAS = [ [-2, -1],[-2, 1],[-1, -2],[-1, 2],[1, 2],[2, 1],[2, -1],[1, -2] ]
  KING_DELTAS = [ [-1, -1],[-1, 0],[-1, 1],[0, -1],[0, 1],[1, 1],[1, 0],[1, -1]]

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

# p = Piece.new(board,[3, 2])
# board = Array.new(8) {Array.new(8)}
# q = Queen.new(board, [5, 4])
# q = Queen.new(board, [5, 4])
board = Array.new(8) {Array.new(8)}

k = Knight.new(board, [5, 4])

k.move



