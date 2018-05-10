defmodule DisplayTest do
  use ExUnit.Case
  alias TicTacToe.Display
  alias TicTacToe.Game
  import ExUnit.CaptureIO

  @blank_board TicTacToe.Board.new()
  @tied_board %{ 1 => "X", 2 => "O", 3 => "X", 4 => "O", 5 => "O", 6 => "X", 7 => "X", 8 => "X", 9 => "O", :width => 3 }
  @board_won_by_x %{ 1 => "X", 2 => "X", 3 => "X", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", :width => 3 }
  @board_won_by_o %{ 1 => "O", 2 => "O", 3 => "O", 4 => "4", 5 => "5", 6 => "6", 7 => "7", 8 => "8", 9 => "9", :width => 3 }
  @player_1 TicTacToe.Player.new("X", TicTacToe.Human)
  @player_2 TicTacToe.Player.new("O", TicTacToe.ImpossibleComputer)

  test "Display.board/1" do
    expected = """
                1 | 2 | 3
               ---+---+---
                4 | 5 | 6
               ---+---+---
                7 | 8 | 9
               """
    actual = capture_io(fn -> Display.board(Game.new(@blank_board, @player_1, @player_2)) end)
    assert actual == expected
  end

  test "Display.clear_screen/0" do
    expected = "\e[2J\e[H\e[0m\n"
    actual = capture_io(fn -> Display.clear_screen() end)
    assert actual == expected
  end

  test "Display.move_prompt/1" do
    args = [
      { Game.new(@blank_board, @player_1, @player_2), "\nPlayer X, please choose a tile...\n" },
      { Game.new(@blank_board, @player_2, @player_1), "\nComputer O is taking it's turn...\n" }
    ]
    for {arg, expected_result} <- args do
      assert capture_io(fn -> Display.move_prompt(arg) end) == expected_result
    end
  end

  test "Display.game_over_message/1" do
    args = [
      { Game.new(@tied_board, @player_1, @player_2), "\nTie game!\n" },
      { Game.new(@board_won_by_x, @player_1, @player_2), "\nPlayer X wins!\n" },
      { Game.new(@board_won_by_o, @player_1, @player_2), "\nComputer O wins!\n" }
    ]
    for {arg, expected_result} <- args do
      assert capture_io(fn -> Display.game_over_message(arg) end) == expected_result
    end
  end

end
