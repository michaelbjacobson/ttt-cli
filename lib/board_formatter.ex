defmodule TicTacToe.BoardFormatter do
	alias TicTacToe.Board

	def format_for_display(board) do
		Enum.zip(rows(board), delimiters(board))
		|> Enum.map(fn {row, delimiter} -> [row, delimiter] end)
		|> List.flatten()
		|> List.delete_at(-1)
		|> Enum.join("\n")
  end

	defp rows(board) do
		board
		|> Board.columns()
		|> Enum.at(0)
		|> Enum.map(fn index -> row(board, index) end)
	end

	defp delimiters(board) do
		(1..board[:width])
		|> Enum.map(fn _i -> delimiter(board) end)
	end

	defp row(board, starting_index) do
		(starting_index)..(starting_index + (board[:width] - 1))
		|> Enum.map(fn index -> " #{tile(board, index)} |" end)
		|> Enum.join("")
		|> String.trim_trailing(" |")
	end

	defp delimiter(board) do
		(if board[:width] <= 3, do: "---+", else: "----+")
		|> String.duplicate(board[:width])
		|> String.trim_trailing("+")
	end

  defp tile(board, index) do
		if (board[:width] > 3) && (String.length(board[index]) == 1) do
			" #{board[index]}"
		else
			board[index]
		end
  end

end
