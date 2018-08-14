export class Board {
  constructor(stage) {
    this.stage = stage;
  }

  render() {
    let width = 80, radius = 28;
    this.boardContainer = new createjs.Container();
    for (let row = 0; row < 6; row++) {
      for (let col = 0; col < 7; col++) {
        this.boardContainer.addChild(
          this.createCell(
            col * width,
            row * width,
            width,
            radius
          ));
      }
    }
    this.boardContainer.y = 50;
    this.stage.addChild(this.boardContainer);
    this.stage.update();
  }

  renderDropButtons() {
  }

  createCell(x, y, width, radius) {
    let g = new createjs.Graphics();
    g.
      beginFill('blue').
      moveTo(x, y).
      lineTo(x, y + width).
      lineTo(x + width, y + width).
      lineTo(x + width, y).
      closePath();
    g.append(new createjs.Graphics.Circle(x + width/2, y + width/2, radius));

    return new createjs.Shape(g);
  }
}

