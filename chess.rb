

class Piece


  # @board = Array.new(8) {Array.new(8)}

  DIAG_DELTAS = [ [1,1],[-1,-1],[1,-1],[-1, 1]]
  STRAIGHT_DELTAS = [ [0, 1],[0,-1],[1, 0],[-1,0]]
  KNIGHT_DELTAS = [ [-2, -1],[-2, 1],[-1, -2],[-1, 2],[1, 2],[2, 1],[2, -1],[1, -2] ]
  KING_DELTAS = [ [-1, -1],[-1, 0],[-1, 1],[0, -1],[0, 1],[1, 1],[1, 0],[1, -1]]
  PAWN_W_DELTAS = [ [-1, -1], [-1, 0], [-1, 1] ]
  PAWN_B_DELTAS = [ [1, -1], [1, 0], [1, 1] ]

  attr_accessor :pos, :board
  attr_reader :color


  def initialize(board, pos, color)
    @board = board
    @pos = pos
    @board.set_piece(pos, self)
    @color = color
  end


  def moves(sym)
    p sym
  end

  def move
    #can't implement this because the piece
    #should use its own move method
  end

  def move_into_check?(piece, new_pos)
    test_board = @board.dup_the_board
    x, y = piece.pos
    dup_piece = test_board.b_arr[x][y]
    test_board.b_arr[x][y] = nil
    dup_piece.pos = new_pos
    a, b = new_pos
    test_board.b_arr[a][b] = dup_piece

    return test_board.checked?(piece.color)
  end

  def duplicate_piece(test_board)
    return self.class.new(test_board, self.pos, self.color)
  end


  def put_board(moves)
    @board.b_arr.each_with_index do |el1, i|
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

require_relative 'board'
require_relative 'slidingpiece'
require_relative 'steppingpiece'
require_relative 'pawn'





# p = Piece.new(board,[3, 2])
# board = Array.new(8) {Array.new(8)}
# q = Queen.new(board, [5, 4])
# q = Queen.new(board, [5, 4])



