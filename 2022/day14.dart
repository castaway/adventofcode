import 'dart:convert';
import 'dart:math';

class Advent {
  static const dayFile = '2022/day14.txt';
  static Map<String, String> coords = {};
  static int maxY = 0;

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var pairs = line.split(' -> ');
    var pairList = pairs.map(
      (p) => p.split(',').map(
        (c) => int.parse(c)
      ).toList()
    ).toList();

    // maxY = deepest row
    for (var p = 0; p < pairList.length-1; p++) {
      //print(' ${pairList[p]}, ${pairList[p+1]}');
      //print(pairList[p][0] < pairList[p+1][0]);
      for (var x = pairList[p][0]; 
           pairList[p][0] < pairList[p+1][0] ? x < pairList[p+1][0] : x > pairList[p+1][0];
           pairList[p][0] < pairList[p+1][0] ? x++ : x--) {
        //print('x: $x, ${pairList[p][1]}');
        //coords[x][pairList[p][1]] = '#';
        coords['$x:${pairList[p][1]}'] = '#';
        // print(coords);
      }
      for (var y = pairList[p][1]; 
           pairList[p][1] < pairList[p+1][1] ? y < pairList[p+1][1] : y > pairList[p+1][1];
           pairList[p][1] < pairList[p+1][1] ? y++ : y--) {
        //print('y: $y');
        if (y > maxY) {
          maxY = y;
        }
        coords['${pairList[p][0]}:$y'] = '#';
      }
    }
  }

  static whenDone() {
    var p1 = 0;
    // print(coords);
    // Drop sand: @[500, 0]
    print(maxY++);
    var sand = [0,0];
    while(sand[1] < maxY ) {
      // sand counter
      p1++;
      print(p1);
      sand = drop(coords, maxY, 500, 0);
      print('Adding: $sand');
      print('MaxY: $maxY');
      coords['${sand[0]}:${sand[1]}'] = 'o';
    }
    //print(coords);
    print('Part 1: $p1');
    // print('Part 2: $p2');
  }
}

List<int> drop(Map<String, String> coords, int maxY, int x, int y) {
  while((!coords.containsKey('$x:${y+1}')  || coords['$x:${y+1}'] == null) && y < maxY+1) {
    y++;
  }
  //print('Y: $y');
  if(y > maxY) {
    return [x,y];
  }
  if(x > 0 && !coords.containsKey('${x-1}:${y+1}') || coords['${x-1}:${y+1}'] == null) {
    //print('X,Y: ${x-1},${y+1}');
    return drop(coords, maxY, x-1, y+1);
  }
  if(!coords.containsKey('${x+1}:${y+1}') || coords['${x+1}:${y+1}'] == null) {
    return drop(coords, maxY, x+1, y+1);
  }
  //print('Cannot go SW or SE!?');
  //print('${coords['$x:${y+1}']}, $x, $y');
  return [x,y];
}
