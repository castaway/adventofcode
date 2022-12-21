import 'dart:convert';
import 'dart:math';

class Advent {
  static const dayFile = '2022/day8_test.txt';
  static List<List<int>> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var chars = line.split('');
    input.add(chars.map((e) => int.parse(e)).toList());
  }

  static whenDone() {
    var p1 = input.length * 2 + (input[0].length - 2) * 2;
    print(p1);
    // max scenic score
    var p2 = 0;
    print(input);
    // Iterate down (then across)
    for(var y = 0; y < input.length; y++) {
      for(var x = 0; x < input[y].length; x++) {
        print('x,y: $x, $y');
        // P2:
        // Need distance between x,y and next tree same size or taller in each direction
        var score = 1;
        // Left
        if (x > 0) {
        var left = input[y].sublist(0,x).lastIndexWhere((t) => t >= x);
        print('Left: $left');
        score *= x - left;
        }
        // Right
        var right = input[y].sublist(x+1, input[y].length).indexWhere((t) => t >= input[y][x]);
        print('Right: $right');
        score *= right - x;
        // Above
        score *= input.sublist(0,y).map((row) => row[x]).toList().indexWhere((t) => t >= y) - y;
        // Below
        score *= y - input.sublist(y+1,input.length).map((row) => row[x]).toList().indexWhere((t) => t >= y);
        if (score > p2) {
          p2 = score;
        }
        //print('Left: ${input[y].sublist(0,x)}');
        //print('Right: ${input[y].sublist(x+1, input[y].length)}');
        //print('Above: ${input.sublist(0,y).map((row) => row[x]).toList()}');
        //print('Below: ${input.sublist(y+1,input.length).map((row) => row[x]).toList()}');
        // P1 doesnt consider 0/length:
        if (x == 0 || y == 0 || y == input.length-1 || x == input[y].length -1) {
          continue;
        }
        if(
          // Left
          input[y][x] > input[y].sublist(0,x).reduce((v,e) => v > e ? v : e) ||
          // Right
          input[y][x] > input[y].sublist(x+1, input[y].length).reduce((v,e) => v > e ? v : e) ||
          // Above
          input[y][x] > input.sublist(0,y).map((row) => row[x]).toList().reduce((v,e) => v > e ? v : e) ||
          // Below
          input[y][x] > input.sublist(y+1,input.length).map((row) => row[x]).toList().reduce((v,e) => v > e ? v : e) ) {
            p1++;
        }
      }
    }

    print('Part 1: $p1');
    print('Part 2: $p2');

  }
}