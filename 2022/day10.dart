import 'dart:convert';

class Advent {
  static const dayFile = '2022/day10_test.txt';
  static List<List<String>> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var instrs = line.split(' ');
    input.add(instrs);
  }

  static whenDone() {
    var p1 = 0;
    var cycle = 0;
    List<int> actions = List.generate(250, (int i) => 0);
    for(var x=0; x < input.length; x++) {
      if(input[x][0] == 'addx') {
        cycle += 2;
        print('addX: $x, ${input[x]}');
        actions[cycle] += int.parse(input[x][1]);
      } else if(input[x][0] == 'noop') {
        cycle += 1;
      }
    }
    print(actions);
    print(actions.sublist(0, 19));
    var x = 1 + actions.sublist(0, 19).reduce((value, element) => value + element);
    p1 += 20 * x;
    print('Nth: 20 is $x');
    for(var i = 60; i <= 220; i+=40) {
      var x = 1 + actions.sublist(0, i-1).reduce((value, element) => value + element);
      print(actions.sublist(0, i-1));
      print('Nth: $i is $x');
      p1 += i * x;
    }
// 1 + 15 - 11 + 6 - 3 + 5 - 1 - 8 + 13 + 4 = 21.
    print('Part 1: $p1');
    //print('Part 2: ${visited9.length}');

  }
}
