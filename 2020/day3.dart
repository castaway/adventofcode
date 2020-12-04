class Day3 {
  static const dayFile = 'day3.txt';
  
  static var map = {};
  static var lineNum = 0;
  static var lineCount = 0;
  static var mapWidth = 0;
  static handle(String line) {
    List<String> icons = line.split('');
    mapWidth = icons.length;
    lineCount++;
    icons.asMap().forEach((index, icon) {
      if(!map.containsKey(index)) {
        map[index] = {};
      }
      map[index][lineNum] = icon == '#' ? true : false;
    });
    lineNum++;
  }
  
  static whenDone() {
    print(map);
    print('Lines: $lineCount');
    print('Width: $mapWidth');
    print('PART 1: ${calcSlope(3, 1)}');
    var part2 = 1;
    part2 *= calcSlope(1,1);
    part2 *= calcSlope(3,1);
    part2 *= calcSlope(5,1);
    part2 *= calcSlope(7,1);
    part2 *= calcSlope(1,2);
    print('PART 2: $part2');
  }

  static int calcSlope(int xInc, int yInc) {
    var x = 0;
    var y = 0;
    var trees = 0;
    while (y < lineCount-1) {
      x += xInc;
      y += yInc;
      print('$x, $y');
      if(x > mapWidth-1) {
        print('$x > ${mapWidth}');
        x  = ((x+1) % mapWidth)-1;
      }
      print('$x, $y');
      print('${map[x][y]}');
      if(map[x][y]) {
        trees++;
      }
    }
    print('Trees: $trees');
    return trees;
  }
}