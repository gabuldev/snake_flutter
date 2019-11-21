class PositionModel {
  final double x;
  final double y;
  bool head;

  PositionModel(this.x, this.y, {this.head = false});

  PositionModel operator +(other) =>
      PositionModel(this.x + other.x, this.y + other.y);

  @override
  int get hashCode => (x * y).toInt();
  operator ==(other) => other.x == this.x && other.y == this.y;
}
