export class ConnectFourGame {
  constructor(canvas) {
    this.stage = new createjs.Stage(canvas)
    this.setupTicker()
  }

  setupTicker() {
    createjs.Ticker.framerate = 30
    createjs.Ticker.addEventListener("tick", (_e) => {
      this.stage.update()
    })
  }

  render() {
    this.board = new Board(this.stage)
    this.board.render()
  }
}

class Board {
  constructor(stage) {
    this.stage = stage
  }

  render() {
    const boardBitmap = new createjs.Bitmap('/images/connect4board.png')
    boardBitmap.scale = 1
    this.stage.addChild(boardBitmap)
  }

  renderDropButtons() {
  }
}

class Disk {
  constructor(color, column, stage) {
    this.stage = stage
    this.color = color
    this.column = column
  }

  render() {
    var g = new createjs.Graphics();
    g.setStrokeStyle(1);
    g.beginStroke(createjs.Graphics.getRGB(0,0,0));
    g.beginFill(createjs.Graphics.getRGB(255,0,0));
    g.drawCircle(0,0,50 );

    var s = new createjs.Shape(g);
    s.x = 100;
    s.y = 100;

    this.stage.addChild(s);
    this.stage.setChildIndex(s, 0)
  }

  dropToRow(row) {
  }
}
