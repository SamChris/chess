# encoding: UTF-8


class Board

  attr_accessor :b_arr, :check_mated, :selected_piece

  def initialize
    @b_arr = Array.new(8) {Array.new(8)}
    set_up_board
    print_board
    @check_mated = false
    @selected_piece = nil
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
  #
  # def background_switch(background)
  #   background == "\033[41m#{self}\033[0m" ? : "\033[47m#{self}\033[0m"
  # end

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

  def play_game
    until check_mated
       begin
          possible_moves = select_a_piece
          destination = select_destination(possible_moves)
       rescue RuntimeError
          begin
            puts "That is not a valid move"
            retry
          end
        if selected_piece.move_into_check?(selected_piece, destination)
        rescue RuntimeError

          update_board(selected_piece, destination)
        else
          rescue
            puts "You are moving into check"
          end

          if check_mate?(opposing_color(piece.color))
              puts "Check Mate"
            else
              puts "You are exposing yourself to being checked."
            end
           print_board


  end

  def select_a_piece
    begin
      puts "Enter coords of piece to move. (Ex. '1 3')"
      start = gets.chomp.split(' ').map(&:to_i)
      x, y = start
      possible_moves = []
      self.selected_piece = b_arr[x][y]
      puts selected_piece.class
      possible_moves = selected_piece.move
    rescue NoMethodError
      puts "Pick an actual piece"
      retry
    end
    possible_moves
  end

  def select_destination(possible_moves)
    begin
      puts "Please select one of these positions"
      p possible_moves
      destination = gets.chomp.split(' ').map(&:to_i)
      if possible_moves.include?(destination)
        return destination
      else
         raise RuntimeError
      end
    end
  end

  def update_board(selected_piece, destination)
    x, y = selected_piece.pos
    self.b_arr[x][y] = nil
    selected_piece.pos = destination
    x, y = selected_piece.pos
    self.b_arr[x][y] = selected_piece
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
    print "   ┇ 0 ┇ 1 ┇ 2 ┇ 3 ┇ 4 ┇ 5 ┇ 6 ┇ 7 ┇".bg_green.red
    print "\n"
    self.b_arr.each_with_index do |el1, i|
      print " #{i} ".bg_green.red
      el1.each_with_index do |el2, j|

        if self.b_arr[i][j].nil?

          if (i+j)%2==0
            print "   ".bg_gray
          else
            print "   ".bg_red
          end

        else
          to_print = get_shape(self.b_arr[i][j], self.b_arr[i][j].color)

          if (i+j)%2==0
            print to_print.bg_gray.cyan
          else
            print to_print.bg_red.magenta
          end
        end

      end

      print "\n"
    end
     print " ♥  0  1  2  3  4  5  6  7 ".bg_green.red
    print "\n\n"
    print "---------------------------------------------------------------"
    print "\n\n"
    return nil
  end


  def get_shape(piece, color)
    if color == :W
      return ' ♙ ' if piece.class == Pawn
      return ' ♕ ' if piece.class == Queen
      return ' ♔ ' if piece.class == King
      return ' ♗ ' if piece.class == Bishop
      return ' ♖ ' if piece.class == Rook
      return ' ♘ ' if piece.class == Knight
    else
      return ' ♟ ' if piece.class == Pawn
      return ' ♛ ' if piece.class == Queen
      return ' ♚ ' if piece.class == King
      return ' ♝ ' if piece.class == Bishop
      return ' ♜ ' if piece.class == Rook
      return ' ♞ ' if piece.class == Knight
    end

  end


end

class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def  brown;         "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_black;       "\033[40m#{self}\0330m"  end
  def bg_red;         "\033[41m#{self}\033[0m" end
  def bg_green;       "\033[42m#{self}\033[0m" end
  def bg_brown;       "\033[43m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
  def bg_magenta;     "\033[45m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bg_gray;        "\033[47m#{self}\033[0m" end
  def bold;           "\033[1m#{self}\033[22m" end
  def reverse_color;  "\033[7m#{self}\033[27m" end
end





