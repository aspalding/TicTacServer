require 'ai'
require 'board'
require 'state'
require 'player_manager'

class Web
  def initialize(board)
    @manager = Player_manager.new("x", false, "o", true)
    @ai = Ai.new("o", @manager)
    @board = board
    @state = State.new(@manager)
  end

  def show_board
      "<h1></br>%s | %s | %s</br>%s | %s | %s</br>%s | %s | %s</br></br></h1>" % @board.board
  end

  def human_move(mark, loc)
    @board.place(mark, cast_int(loc))
  end
  
  def ai_move(mark)
    loc = @ai.smart_move(@board.board)
    @board.place(mark, loc)
  end

  def cast_int(loc)
    begin
      location = Integer(loc)
    rescue ArgumentError
      loc = -1
    end
  end

  def game_over?
    @state.terminal?(@board.board)
  end

  def over_message
    if @state.winner?(@board.board, "x")
      "x is the winner!"
    elsif @state.winner?(@board.board, "o")
      "o is the winner!"
    else
      "It's a tie!"
    end
  end

  def valid?(loc)
    @board.valid?(cast_int(loc))
  end

  def started?
    (@state.empty_indices(@board.board).length == @board.board.length)? false : true 
  end

end

Web.new(Board.new(3))
