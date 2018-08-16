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
      if (!this.stage.mouseInBounds) {
        this.targetColumn = null;
        this.clearShadowDisk();
        this.stage.update(e);
        return;
      }
      let column = this.getTargetedColumn(e.stageX, e.stageY);
      if (column < 7 && column != this.targetColumn) {
        this.targetColumn = column;
        this.clearShadowDisk();
        this.showShadowDisk();
        this.stage.update(e);
      }
    });

    this.stage.addEventListener('stagemouseup', e => {
      if (this.stage.mouseInBounds) {
        this.tryDropDisk(e);
      }
    });
  }

  tryDropDisk(e) {
    if (this.targetColumn) {
      this.clearShadowDisk();
      this.stage.update(e);
      this.disk = new createjs.Shape(this.graphicsForDisk('red'));
      this.stage.addChild(this.disk);
      const dest = this.centerFromCell(this.targetColumn, this.getEmptyCellRow());
      createjs.Tween.get(this.disk).to(dest, 500);
    }
  }

  centerFromCell(x, y) {
    return {x: (this.cellWidth + 0.5) * x,
            y: (this.cellWidth + 1.5) * y};
  }

  getEmptyCellRow() {
    return 5;
  }

  getTargetedColumn(stageX, stageY) {
    let point = this.boardContainer.globalToLocal(stageX, stageY);
    return Math.floor(point.x / this.cellWidth);
  }

  showShadowDisk() {
    this.shadowDisk = new createjs.Shape(this.graphicsForDisk());
    this.stage.addChild(this.shadowDisk);
  }

  graphicsForDisk(color = 'gray') {
    let g = new createjs.Graphics();
    g.beginFill(color).
      drawCircle(this.targetColumn * this.cellWidth + this.cellWidth / 2, this.cellWidth / 2 + 4, this.cellWidth / 2 - 4);
    return g;
  }

  clearShadowDisk() {
    this.stage.removeChild(this.shadowDisk);
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
