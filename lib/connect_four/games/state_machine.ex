defmodule ConnectFour.Games.StateMachine do
  alias ConnectFour.Games.Board
  import Board

  def next_player_after(:player_one), do: :player_two
  def next_player_after(:player_two), do: :player_one

  use Fsm, initial_state: :waiting_for_player, initial_data: %{board: Board.new, player_turn: :player_one, winner: nil, moves: []}

  defstate waiting_for_player do
    defevent player_move(player, col), data: %{board: board, player_turn: player, moves: moves} = game_state do
      case insert(board, col, player) do
        {:ok, new_board} ->
          moves = [{player, col} | moves]
          case last_move_result(new_board, col) do
            {:draw} ->
              next_state(:draw, %{game_state | board: new_board, player_turn: next_player_after(player), moves: moves})
            {:win, player} ->
              next_state(:victory, %{game_state | board: new_board, player_turn: nil, winner: player, moves: moves})
            {:continue} ->
              next_state(:waiting_for_player, %{game_state | board: new_board, player_turn: next_player_after(player), moves: moves})
          end
        {:error, :invalid_move, _} -> next_state(:waiting_for_player, game_state)
      end
    end

    defevent player_move(_, _), data: game_state, do: next_state(:waiting_for_player, game_state)
  end

  defstate victory, do: nil
  defstate draw, do: nil

  def game_over?(fsm) do
    state(fsm) != :waiting_for_player
  end
end
