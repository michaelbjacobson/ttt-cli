defmodule TicTacToe.Display do
  alias TicTacToe.BoardFormatter
  alias TicTacToe.Rules

  def game_over_message(game) do
    cond do
      Rules.game_is_tied?(game) -> "\nTie game!" |> IO.puts()
      Rules.game_is_won_by?(game, game.player_1) -> winner(game.player_1) |> IO.puts()
      Rules.game_is_won_by?(game, game.player_2) -> winner(game.player_2) |> IO.puts()
    end
  end

  def move_prompt(game) do
    case game.current_player.module do
      TicTacToe.ImpossibleComputer -> "\nComputer #{game.current_player.marker} is taking it's turn..." |> IO.puts()
      TicTacToe.EasyComputer -> "\nComputer #{game.current_player.marker} is taking it's turn..." |> IO.puts()
      TicTacToe.Human -> "\nPlayer #{game.current_player.marker}, please choose a tile..." |> IO.puts()
      _other -> "\nPlease choose a tile..." |> IO.puts()
    end
  end

  def clear_screen do
    IO.ANSI.format([:clear, :home])
    |> IO.puts()
  end

  def board(game) do
    BoardFormatter.format_for_display(game.board)
    |> IO.puts()
  end

  def welcome do
    "Let's play Tic-Tac-Toe!"
    |> IO.puts()
  end

  def board_size_prompt do
    """
    \nPlease select a board size...
    1. Standard (3x3)
    2. Large (4x4)
    """
    |> IO.puts()
  end

  def difficulty_prompt do
    """
    \nPlease select a computer difficulty...
    1. Easy
    2. Unbeatable
    """
    |> IO.puts()
  end

  def game_mode_prompt do
    """
    \nPlease select a game mode...
    1. Human vs Human
    2. Human vs Computer
    3. Computer vs Human
    4. Computer vs Computer
    """
    |> IO.puts()
  end

  defp winner(player) do
    case player.module do
      TicTacToe.ImpossibleComputer -> "\nComputer #{player.marker} wins!"
      TicTacToe.EasyComputer -> "\nComputer #{player.marker} wins!"
      TicTacToe.Human -> "\nPlayer #{player.marker} wins!"
      _other -> "\n#{player.marker} wins!"
    end
  end

end
