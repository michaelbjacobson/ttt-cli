defmodule Mix.Tasks.Play do
  use Mix.Task

  def run(_arg) do
    TicTacToe.Program.run()
  end
end
