export class Board {
  constructor(stage) {
    this.stage = stage;
    this.cellWidth = 80;
    this.cellHoleRadius = 28;
  }

  render() {
    let width = this.cellWidth,
        radius = this.cellHoleRadius;
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
    this.boardContainer.y = this.cellWidth;
    this.stage.addChild(this.boardContainer);
    this.stage.update();

    this.stage.addEventListener('stagemousemove', e => {
      let column = this.getTargetedColumn(e.stageX, e.stageY);
      if (column != this.targetColumn) {
        this.clearShadowDisk();
        this.showShadowDiskAtColumn(column);
        this.targetColumn = column;
        this.stage.update(e);
      }
    });
  }

  getTargetedColumn(stageX, stageY) {
    let point = this.boardContainer.globalToLocal(stageX, stageY);
    return Math.floor(point.x / this.cellWidth);
  }

  showShadowDiskAtColumn(column) {
    let g = new createjs.Graphics();
    g.beginFill('gray').
      drawCircle(column * this.cellWidth + this.cellWidth / 2, this.cellWidth / 2 + 4, this.cellWidth / 2 - 4);
    this.shadowDisk = new createjs.Shape(g);
    this.stage.addChild(this.shadowDisk);
  }

  clearShadowDisk() {
    this.stage.removeChild(this.shadowDisk);
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
