export default class Board {
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
          this.createCell(col * width, row * width, width, radius));
      }
    }
    this.boardContainer.y = this.cellWidth;
    this.stage.addChild(this.boardContainer);

    this.setupListeners();
  }

  setupListeners() {
    this.stage.addEventListener('stagemousemove', e => {
      if (!this.stage.mouseInBounds) {
        this.targetColumn = null;
        this.clearShadowDisk();
        return;
      }
      let column = this.getTargetedColumn(e.stageX, e.stageY);
      if (column < 7 && column != this.targetColumn) {
        this.targetColumn = column;
        this.clearShadowDisk();
        this.showShadowDisk();
      }
    });

    this.stage.addEventListener('stagemouseup', e => {
      if (this.stage.mouseInBounds) {
        this.tryDropDisk(e);
      }
    });
  }

  /*
    example data: each element is a column, with the first as the left-most column.
    [
    [null, null, null, null, null, 'player_one'],
    [null, null, null, null, 'player_one', 'player_two'],
    [null, null, null, null, null, 'player_one'],
    [null, null, null, null, null, null],
    [null, null, null, null, null, 'player_two'],
    [null, null, null, null, null, null],
    [null, null, null, null, null, null]
    ]
  */
  withData(data) {
    Array.from(Array(7).keys()).map((_, column) => {
      Array.from(Array(6).keys()).map((_, row) => {
        const val = data[column][row];
        if (val != null) {
          const color = this.playerToColor(val);
          this.putDisk({color: color, column: column, row: row});
        }
      });
    });
  }

  playerToColor(player) {
    if (player == 'player_one') {
      return 'yellow';
    } else {
      return 'red';
    }
  }

  tryDropDisk(e) {
    if (this.targetColumn != null) {
      this.clearShadowDisk();
      this.disk = new createjs.Shape(this.graphicsForDisk({color: 'red', row: -1, column: this.targetColumn}));
      this.stage.addChildAt(this.disk, 0);
      const dest = this.centerFromCell(this.targetColumn, this.getEmptyCellRow());
      createjs.Tween.get(this.disk).to(dest, 500);
    }
  }

  putDisk({column, row, color}) {
    const disk = new createjs.Shape(this.graphicsForDisk({color: color, column: column, row: row}));
    this.stage.addChildAt(disk, 0);
  }

  centerFromCell(col, row) {
    return {x: 0, y: this.cellWidth * row + this.cellWidth};
  }

  getEmptyCellRow() {
    return 5;
  }

  getTargetedColumn(stageX, stageY) {
    let point = this.boardContainer.globalToLocal(stageX, stageY);
    return Math.floor(point.x / this.cellWidth);
  }

  showShadowDisk() {
    this.shadowDisk = new createjs.Shape(this.graphicsForDisk({column: this.targetColumn}));
    this.stage.addChild(this.shadowDisk);
  }

  graphicsForDisk({color: color = 'gray', column, row: row = -1}) {
    let g = new createjs.Graphics();
    const x = column * this.cellWidth + this.cellWidth / 2,
          y = (row + 1) * this.cellWidth + this.cellWidth / 2 + 4,
          radius = this.cellWidth / 2 - 4;
    g.beginFill(color).drawCircle(x, y, radius);
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
