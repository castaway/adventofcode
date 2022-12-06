import 'dart:convert';

class Advent {
  static const dayFile = '2022/day6.txt';
  static List<String> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    input.addAll(line.split(''));
  }

  static whenDone() {

    var p1 = -1;
    for(var i = 4; i < input.length; i++) {
      var subset = Set.from(input.sublist(i-4, i));
      //print(subset);
      if (subset.length == 4) {
        p1 = i;
        break;
      }
    }

    var p2 = -1;
    for(var i = 14; i < input.length; i++) {
      var subset = Set.from(input.sublist(i-14, i));
      //print(subset);
      if (subset.length == 14) {
        p2 = i;
        break;
      }
    }
    
    print('Part 1: $p1');
    print('Part 2: $p2');

  }
}