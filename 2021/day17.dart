class Day17 {
  static const dayFile = '2021/day17.txt';
  static List<List<int>> input = [];
  
  static handle(String line) {
    //print('INPUT: $line');
    // target area: x=150..171, y=-129..-70
    var tRE = RegExp(r'^target area: x=([-\d]+)\.+([-\d]+), y=([-\d]+)\.+([-\d]+)$');
    if(tRE.hasMatch(line)) {
      var match = tRE.firstMatch(line);
      input = [[int.parse(match.group(1)), int.parse(match.group(2))],
               [int.parse(match.group(3)), int.parse(match.group(4))],
               ];
    }
  }

  static whenDone() {
    print(input);
    // Input: target area: x=150..171, y=-129..-70
    var vX=34, vY=-14;
    vX = 17;
    vY = 15;
    var maxY = -70;
    while(vY > maxY && testGuess(vX, vY)) {
      maxY = vY;
      vY ++;
      vX -= 2;
    }
    print('Max Y: $maxY');
  }

  static bool testGuess(int vX, int vY) {
    var x=0, y=0, maxY=0;
      while(true) {
      if(x>=150 && x<=171 && y>=-129 && y<=-70) {
        print('Stopped: $x, $y, $maxY');
        return true;
      }
      x+= vX;
      y+= vY;

      if(vX > 0) {
        vX--;
      }
      if(vX < 0) {
        vX++;
      }
      vY--;
      if(y > maxY) {
        maxY = y;
      }
      print('X: $x, Y: $y, vX: $vX; vY: $vY');
      if(x > 171 || y <-129) {
        print('Overshot');
        return false;
      }
    }
  }
} 