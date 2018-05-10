defmodule TicTacToe.Program do
  alias TicTacToe.{ Game, Display, Rules, Board, Player, Human, ImpossibleComputer, EasyComputer }

  def run do
    Display.clear_screen()
    Display.welcome()
    set_up_game()
    |> play_game()
  end

  def play_game(game) do
    Display.clear_screen()
    Display.board(game)
    if game.is_over? do
      Display.game_over_message(game)
    else
      get_next_move(game)
      |> Game.take_turn(game)
      |> play_game()
    end
  end

  defp set_up_board do
    Display.board_size_prompt()
    selection = IO.gets("> ") |> String.trim()
    case selection do
      "1" -> Board.new(3)
      "2" -> Board.new(4)
      _else -> set_up_board()
    end
  end

  defp set_up_computer_difficulty do
    Display.difficulty_prompt()
    selection = IO.gets("> ") |> String.trim()
    case selection do
      "1" -> EasyComputer
      "2" -> ImpossibleComputer
      _else -> set_up_computer_difficulty()
    end
  end

  defp set_up_game_mode do
    Display.game_mode_prompt()
    selection = IO.gets("> ") |> String.trim()
    case selection do
      "1" -> :human_v_human
      "2" -> :human_v_computer
      "3" -> :computer_v_human
      "4" -> :computer_v_computer
      _else -> set_up_game_mode()
    end
  end

  defp set_up_game do
    board = set_up_board()
    game_mode = set_up_game_mode()
    if game_mode == :human_v_human do
      Game.new(board, Player.new("X", Human), Player.new("O", Human))
    else
      computer = set_up_computer_difficulty()
      case game_mode do
        :human_v_computer -> Game.new(board, Player.new("X", Human), Player.new("O", computer))
        :computer_v_human -> Game.new(board, Player.new("X", computer), Player.new("O", Human))
        :computer_v_computer -> Game.new(board, Player.new("X", computer), Player.new("O", computer))
      end
    end
  end

  defp get_next_move(game) do
    Display.move_prompt(game)
    input = Player.get_move(game.current_player, game)
    if Rules.input_is_valid?(input, game) do
      String.to_integer(input)
    else
      get_next_move(game)
    end
  end

end
