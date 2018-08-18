import Board from './board';
import socket from './socket';

export class ConnectFourGame {
  constructor(canvas) {
    this.stage = new createjs.Stage(canvas);
    this.stage.snapToPixel = true;
    this.setupTicker();
  }

  setupTicker() {
    createjs.Ticker.framerate = 60;
    createjs.Ticker.addEventListener("tick", () => {
      this.stage.update();
    });
  }

  render() {
    this.board = new Board(this.stage);
    this.board.render();
    this.setupChannel();
  }

  setupChannel() {
    this.gameChannel = socket.channel(`games:${gameId}`);
    this.gameChannel.join()
      .receive('ok', resp => console.log("joined the game channel", resp))
      .receive('error', reason => console.log("join failed", reason));
    this.gameChannel.on("player_joined", this.onPlayerJoined);
  }
}
