defmodule ConnectFour.Games.Board do
  defstruct [grid: nil]
  alias __MODULE__
  import ListExt

  def new do
    grid =
      for _ <- 1..7 do
        for _ <- 1..6, do: nil
      end

    %__MODULE__{grid: grid}
  end

  def can_insert?(%__MODULE__{grid: g}, column) do
    list = Enum.at(g, column)
    if list do
      Enum.any?(list, &(&1 == nil))
    else
      false
    end
  end

  def insert(%__MODULE__{} = board, column, player) do
    if can_insert?(board, column) do
      new_board = do_insert(board, column, player)
      {:ok, new_board}
    else
      {:error, :invalid_move, board}
    end
  end

  def do_insert(board, column, player) do
    grid = board.grid
    insert_player =
      fn row ->
        {nils, filled} = Enum.split_while(row, &is_nil/1)
        case nils do
          [] -> filled
          [_ | t] -> Enum.reverse([player | t], filled)
        end
      end

    new_grid = List.update_at(grid, column, insert_player)
    %__MODULE__{board | grid: new_grid}
  end

  def last_move_result(%__MODULE__{grid: grid} = board, column) do
    if draw?(grid) do
      {:draw}
    else
      check_vertical(board, column)
      || check_horizontal(board, column)
      || check_uphill(board, column)
      || check_downhill(board, column)
      || {:continue}
    end
  end

  def draw?(grid) do
    grid
    |> Enum.map(&hd/1)
    |> Enum.all?(&(&1 != nil))
  end

  def check_vertical(%__MODULE__{grid: grid}, column) do
    top_four = grid |> Enum.at(column) |> Enum.drop_while(&is_nil/1)
    with [player, player, player, player|_] <- top_four do
      {:win, player}
    else
      _ -> false
    end
  end

  def check_horizontal(%__MODULE__{grid: grid} = data, column) do
    %{row_index: row_index, player: player} = get_last_move_details(data, column)
    row = Enum.map(grid, &Enum.at(&1, row_index))
    if is_subsequence(row, (for _ <- 1..4, do: player)) do
      {:win, player}
    else
      false
    end
  end

  defp get_last_move_details(%__MODULE__{grid: grid}, column) do
    list = Enum.at(grid, column)
    row_index = Enum.find_index(list, &(&1 != nil))
    player = Enum.at(list, row_index)
    %{player: player, row_index: row_index}
  end

  def check_uphill(%__MODULE__{grid: grid} = data, column) do
    %{row_index: row, player: player} = get_last_move_details(data, column)
    check_diagonal(grid, column, row, player)
  end

  def check_downhill(%__MODULE__{grid: grid} = data, column) do
    %{row_index: row, player: player} = get_last_move_details(data, column)
    check_diagonal(Enum.reverse(grid), column, row, player)
  end

  def check_diagonal(grid, column, row, player) do
    if get_diagonal_values(grid, column, row) |> is_subsequence(for _ <- 1..4, do: player) do
      {:win, player}
    else
      false
    end
  end

  defp get_diagonal_values(grid, column, row) do
    vals = []
    for current_col <- 0..6 do
      dist = column - current_col
      current_row = row + dist
      if current_row in 0..7 do
        vals = [Enum.at(grid, current_col) |> Enum.at(current_row) | vals]
      end
    end

    Enum.reverse(vals)
  end
end
