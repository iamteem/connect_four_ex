import "phoenix_html"
import socket from "./socket"
import {ConnectFourGame} from "./game/game"

const canvas = document.getElementById('game_canvas')
if (canvas) {
  const game = new ConnectFourGame(canvas)
  game.render()
}
