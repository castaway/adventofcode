import 'dart:convert';

class Advent {
  static const dayFile = '2022/day9.txt';
  static List<List<int>> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var chars = line.split('');
    input.add(chars.map((e) => int.parse(e)).toList());
  }

  static whenDone() {
    var p1 = 0;

    print('Part 1: $p1');
    // print('Part 2: ${p2.first}');

  }
}