import 'dart:math';
class Advent {
  static const dayFile = '2023/day8.txt';
  static Map<String,List<String>> map = {};
  static List<String> nodes = [];
  static List<int> instructions = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    if(line.isEmpty) {
      return;
    }
    if(instructions.length == 0) {
      line.split(RegExp(r'')).forEach((l) => l == 'L' ? instructions.add(0) : instructions.add(1));
    } else {
      final mapRE = RegExp(r'^([\w]+)\s+=\s+\((\w+), (\w+)\)');
      final match = mapRE.firstMatch(line);
;      map[match[1]] = [match[2], match[3]];
      if(match[1].endsWith('A')) {
        nodes.add(match[1]);
      }
    }
    // print(instructions);
  }

  static whenDone() {
    // AAA to ZZZ (repeat instructions if not reached)
    var count = 0;
    var instr = 0;
    var currentLoc = 'AAA';
    //print(map);
    
    while (currentLoc != 'ZZZ') {
      //print(currentLoc);
      currentLoc = map[currentLoc][instructions[instr]];      
      count++;
      instr++;
      if(instr >= instructions.length) {
        instr = 0;
      }
    }
    
    var p2count = 0;
    instr = 0;
    print(nodes);
    while (!(nodes.every((n) => n.endsWith('Z')))) {
      for(var n = 0; n < nodes.length; n++) {
        nodes[n] = map[nodes[n]][instructions[instr]];
      }
      p2count++;
      instr++;
      if(instr >= instructions.length) {
        instr = 0;
      }
      //print(nodes);
    }
    print("Part 1: $count");
    print("Part 2: $p2count");

  }
}
