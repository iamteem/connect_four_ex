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
