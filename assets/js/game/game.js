import {Board} from './board'

export class ConnectFourGame {
  constructor(canvas) {
    this.stage = new createjs.Stage(canvas);
    this.stage.snapToPixel = true
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
    this.drawGrid();
  }

  drawGrid() {
  }
}
