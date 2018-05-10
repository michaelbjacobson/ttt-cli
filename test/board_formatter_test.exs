defmodule BoardFormatterTest do
  use ExUnit.Case
  alias TicTacToe.BoardFormatter
	alias TicTacToe.Board

	test "BoardFormatter.format_for_display/1 returns a formatted board string" do
    args = [
      {2, " 1 | 2\n---+---\n 3 | 4"},
      {3, " 1 | 2 | 3\n---+---+---\n 4 | 5 | 6\n---+---+---\n 7 | 8 | 9" },
      {4, "  1 |  2 |  3 |  4\n----+----+----+----\n  5 |  6 |  7 |  8\n----+----+----+----\n  9 | 10 | 11 | 12\n----+----+----+----\n 13 | 14 | 15 | 16" },
      {5, "  1 |  2 |  3 |  4 |  5\n----+----+----+----+----\n  6 |  7 |  8 |  9 | 10\n----+----+----+----+----\n 11 | 12 | 13 | 14 | 15\n----+----+----+----+----\n 16 | 17 | 18 | 19 | 20\n----+----+----+----+----\n 21 | 22 | 23 | 24 | 25"}
    ]
    for {arg, expected_result} <- args do
      assert (arg |> Board.new() |> BoardFormatter.format_for_display()) == expected_result
    end
	end

end
