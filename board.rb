


class Board

  attr_accessor :b_arr

  def initialize
    @b_arr = Array.new(8) {Array.new(8)}
    set_up_board
    print_board
  end

  def set_piece(pos, piece)
    x, y = pos
    b_arr[x][y] = piece
    # piece.pos = [x, y]
  end

  def checked?(color)
    king_pos = find_king_pos(color)
    op_color = opposing_color(color)
    op_pieces_pos = find_opposing_pieces_locations(op_color)

    op_pieces_pos.each do |pos|
      i, j = pos
      piece_moves = b_arr[i][j].move
      return true if piece_moves.include?(king_pos)
    end

    false
  end

  def check_mate?(color)
    #find all opposing pieces
    #find all their possible moves
    #if a single possible move does not lead to checked?, player is not in
    #checkmate, else player is checkmated.

    op_pieces = find_opposing_pieces(color)
    p op_pieces
    op_pieces.each do |op_piece|
      op_piece_moves = op_piece.move
      p op_piece_moves
      op_piece_moves.each do |move_pos|
        return false unless op_piece.move_into_check?(op_piece, move_pos)
      end
    end
    true

  end

  def find_opposing_pieces(op_color)
    opp_pieces = []
    b_arr.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        next if b_arr[i][j].nil?
        if b_arr[i][j].color == op_color
          opp_pieces << b_arr[i][j]
        end
      end
    end

    opp_pieces
  end

  def find_opposing_pieces_locations(op_color)
    opp_pieces_locations = []
    b_arr.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        next if b_arr[i][j].nil?
        if b_arr[i][j].color == op_color
          opp_pieces_locations << [i,j]
        end
      end
    end

    opp_pieces_locations
  end

  def opposing_color(color)
    color == :W ? :B : :W
  end

  def find_king_pos(color)
    b_arr.each_with_index do |el1, i|
      b_arr.each_with_index do |el2, j|
        next if b_arr[i][j].nil?
        if b_arr[i][j].class == King && b_arr[i][j].color == color
          return [i,j]
        end
      end
    end

    return []
  end


  def has_enemy?(pos, color)
    x, y = pos
    return false if self.b_arr[x][y].nil?
    return false if self.b_arr[x][y].color == color
    return true
  end

  def is_empty?(pos)
    x, y = pos
    return true if self.b_arr[x][y].nil?
    false
  end


  def make_move
    # begin
      puts "Enter coords of piece to move. (Ex. '1 3')"
      # debugger
      start = gets.chomp.split(' ').map(&:to_i)
      x, y = start
      possible_moves = []
      piece = b_arr[x][y]
      puts piece.class
      possible_moves = piece.move
      puts "Please select one of these positions"
      p possible_moves
      move_to = gets.chomp.split(' ').map(&:to_i)
      if possible_moves.include?(move_to)
        update_board(b_arr[x][y], move_to)
        # move(start, move_to)
      end
    # rescue NoMethodError
    #   puts "There is no piece to move. Pick an actual piece."
    #   retry
    # end
  end

  def update_board(piece, new_pos)
     # unless piece.move_into_check?(piece, new_pos)
        x, y = piece.pos
        self.b_arr[x][y] = nil
        piece.pos = new_pos
        x, y = piece.pos
        self.b_arr[x][y] = piece
        if check_mate?(opposing_color(piece.color))
          puts "Check Mate"
          exit
        end
     # else
#        puts "You are exposing yourself to being checked."
#      end
     print_board
     nil
  end


  def dup_the_board
    test_board = Board.new
    self.b_arr.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        next if self.b_arr[i][j].nil?
        dupped_piece = self.b_arr[i][j].duplicate_piece(test_board)
        test_board.b_arr[i][j] = dupped_piece
      end
    end

    test_board
  end

  def set_up_board
      [0, 7].each do |row|

        if row == 0
          sym = :B
        else
          sym = :W
        end

        self.b_arr[row][0] = Rook.new(self, [row, 0], sym)
        self.b_arr[row][1] = Knight.new(self,[row, 1], sym)
        self.b_arr[row][2] = Bishop.new(self, [row, 2], sym)
        self.b_arr[row][3] = Queen.new(self, [row, 3], sym)
        self.b_arr[row][4] = King.new(self, [row, 4], sym)
        self.b_arr[row][5] = Bishop.new(self, [row, 5], sym)
        self.b_arr[row][6] = Knight.new(self, [row, 6], sym)
        self.b_arr[row][7] = Rook.new(self, [row, 7], sym)
      end


      8.times { |i| self.b_arr[1][i] = Pawn.new(self, [1, i], :B) }
      8.times { |i| self.b_arr[6][i] = Pawn.new(self, [6, i], :W) }

  end

  def print_board
    self.b_arr.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        if self.b_arr[i][j].nil?
          print "  "
        else
          to_print = get_shape(self.b_arr[i][j])
          print to_print
        end
      end
       print "\n"
    end
    print "\n\n"
    print "---------------------------------------------------------------"
    print "\n\n"
    return nil
  end


  def get_shape(piece)
    return 'P ' if piece.class == Pawn
    return 'Q ' if piece.class == Queen
    return 'K ' if piece.class == King
    return 'B ' if piece.class == Bishop
    return 'R ' if piece.class == Rook
    return 'N ' if piece.class == Knight
  end


end
