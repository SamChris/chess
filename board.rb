


class Board

  attr_accessor :b_arr

  def initialize
    @b_arr = Array.new(8) {Array.new(8)}
  end

  def set_piece(pos, piece)
    x, y = pos
    b_arr[x][y] = piece
  end

  def checked?(color)
    king_pos = find_king_pos(color)
    op_color = opposing_color(color)
    op_pieces_pos = find_opposing_pieces(op_color)

    op_pieces_pos.each do |pos|
      i, j = pos
      piece_moves = b_arr[i][j].move
      return true if piece_moves.include?(king_pos)
    end

    false
  end

  def find_opposing_pieces(op_color)
    opp_pieces = []
    b_arr.each_with_index do |el1, i|
      el1.each_with_index do |el2, j|
        next if b_arr[i][j].nil?
        if b_arr[i][j].color == op_color
          opp_pieces << [i,j]
        end
      end
    end

    opp_pieces
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

  def make_move
    begin
      puts "Enter coords of piece to move. (Ex. '1 3')"
      start = gets.chomp.split(' ').map(&:to_i)
      x, y = start
      possible_moves = []
      piece = b_arr[x][y]
      possible_moves = piece.move
      puts "Please select one of these positions"
      p possible_moves
      move_to = gets.chomp.split(' ').map(&:to_i)
      if possible_moves.include?(move_to)
        update_board(b_arr[x][y], move_to)
        # move(start, move_to)
      end
    rescue NoMethodError
      puts "There is no piece to move. Pick an actual piece."
      retry
    end
  end

  def update_board(piece, new_pos)
    x, y = piece.pos
    b_arr[x][y] = nil

    piece.pos = new_pos
    x, y = piece.pos
    b_arr[x][y] = piece
  end


end
