defmodule ConnectFour.Games.GameServer do
  use ExActor.GenServer
  alias ConnectFour.Games.StateMachine

  defstart start_link, do: initial_state(StateMachine.new)

  defcallp move(player, column), state: fsm do
    if StateMachine.game_over?(fsm) do
      set_and_reply(fsm, StateMachine.data(fsm))
    else
      s = StateMachine.player_move(fsm, player, column)
      set_and_reply(s, StateMachine.data(s))
    end
  end

  def move_p1(game, column) do
    move(game, :player_one, column)
  end

  def move_p2(game, column) do
    move(game, :player_two, column)
  end

  defcall state, state: fsm, do: reply(StateMachine.state(fsm))
  defcall data, state: fsm, do: reply(StateMachine.data(fsm))

  defcast stop, do: stop_server(:normal)
end
