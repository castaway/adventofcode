import 'dart:convert';

class Advent {
  static const dayFile = '2022/day8_test.txt';
  static List<List<int>> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var chars = line.split('');
    input.add(chars.map((e) => int.parse(e)).toList());
  }

  static whenDone() {
    var p1 = 0;
    print(input);
    var tallestY = List.generate(input.length, (int i) => -1);
    // p1+= input.length * 2; // outer top/bottom rows
    for(var y = 0; y < input.length; y++) {
      var tallestX = -1;
      // from left
      for(var x = 0; x < input[y].length; x++) {
        if(input[y][x] > tallestX) {
          tallestX = input[y][x];
          p1++;
          print('y, x: $y, $x, (${input[y][x]}), TallestX: $tallestX, P1: $p1');
        }
        // from top
        if (input[y][x] > tallestY[x]) {
          tallestY[x] = input[y][x];
          p1++;
          print('y, x: $y, $x, (${input[y][x]}), TallestY: ${tallestY[x]}, P1: $p1');
        }
      }
      // from right
      tallestX = -1;
      for(var x = input[y].length -1; x >= 0; x--) {
        if(input[y][x] > tallestX) {
          tallestX = x;
          p1++;
        }
      }
    }

    print('Part 1: $p1');
    // print('Part 2: ${p2.first}');

  }
}