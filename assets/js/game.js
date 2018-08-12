export class ConnectFourGame {
  constructor(canvas) {
    this.stage = new createjs.Stage(canvas)
    createjs.Ticker.framerate = 30
    createjs.Ticker.addEventListener("tick", (_e) => {
      this.stage.update()
      console.log("tick")
    })
  }

  loadBoard() {
    const boardBitmap = new createjs.Bitmap('/images/connect4board.png')
    boardBitmap.scale = 0.2
    this.stage.addChild(boardBitmap)

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
}
