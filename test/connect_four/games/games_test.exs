defmodule ConnectFour.GamesTest do
  use ConnectFour.DataCase

  alias ConnectFour.Games

  describe "games" do
    alias ConnectFour.Games.Game

    @valid_attrs %{state: "some state"}
    @update_attrs %{state: "some updated state"}
    @invalid_attrs %{state: nil}

    def game_fixture(attrs \\ %{}) do
      {:ok, game} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_game()

      game
    end

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      assert {:ok, %Game{} = game} = Games.create_game(@valid_attrs)
      assert game.state == "some state"
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      assert {:ok, game} = Games.update_game(game, @update_attrs)
      assert %Game{} = game
      assert game.state == "some updated state"
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end

  describe "players" do
    alias ConnectFour.Games.Player

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Games.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Games.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Games.create_player(@valid_attrs)
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, player} = Games.update_player(player, @update_attrs)
      assert %Player{} = player
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_player(player, @invalid_attrs)
      assert player == Games.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Games.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Games.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Games.change_player(player)
    end
  end

  describe "moves" do
    alias ConnectFour.Games.Move

    @valid_attrs %{column: 42, turn_number: 42}
    @update_attrs %{column: 43, turn_number: 43}
    @invalid_attrs %{column: nil, turn_number: nil}

    def move_fixture(attrs \\ %{}) do
      {:ok, move} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Games.create_move()

      move
    end

    test "list_moves/0 returns all moves" do
      move = move_fixture()
      assert Games.list_moves() == [move]
    end

    test "get_move!/1 returns the move with given id" do
      move = move_fixture()
      assert Games.get_move!(move.id) == move
    end

    test "create_move/1 with valid data creates a move" do
      assert {:ok, %Move{} = move} = Games.create_move(@valid_attrs)
      assert move.column == 42
      assert move.turn_number == 42
    end

    test "create_move/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_move(@invalid_attrs)
    end

    test "update_move/2 with valid data updates the move" do
      move = move_fixture()
      assert {:ok, move} = Games.update_move(move, @update_attrs)
      assert %Move{} = move
      assert move.column == 43
      assert move.turn_number == 43
    end

    test "update_move/2 with invalid data returns error changeset" do
      move = move_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_move(move, @invalid_attrs)
      assert move == Games.get_move!(move.id)
    end

    test "delete_move/1 deletes the move" do
      move = move_fixture()
      assert {:ok, %Move{}} = Games.delete_move(move)
      assert_raise Ecto.NoResultsError, fn -> Games.get_move!(move.id) end
    end

    test "change_move/1 returns a move changeset" do
      move = move_fixture()
      assert %Ecto.Changeset{} = Games.change_move(move)
    end
  end
end
