class Day2 {
  static const dayFile = '2021/day2.txt';
  static List<List<dynamic>> inputs = [];

  // forward 1 / down 2 / up 3
  static handle(String line) {
    // print('INPUT: $line');
    var dirRegExp = RegExp(r'^(\w+)\s(\d+)$');
    if(dirRegExp.hasMatch(line)) {
      var match = dirRegExp.firstMatch(line);
      inputs.add([match.group(1), int.parse(match.group(2))]);
    }
  }
  static whenDone() {
    int x = 0;
    int y = 0;
    for (var val in inputs) {
      if(val[0] == 'forward') {
        x += val[1];
      } else if(val[0] == 'down') {
        y += val[1]; 
       } else if(val[0] == 'up') {
        y -= val[1];
      } else {
        print('Invalid direction: ${val[0]}');
      }
    }
    var result = x*y;  
    print('Part 1: X*Y = $x, $y = $result');
    // #2
    int aim = 0;
    x = 0;
    int depth = 0;
    for (var val in inputs) {
      if(val[0] == 'forward') {
        x += val[1];
        depth += aim * val[1];
      } else if(val[0] == 'down') {
        aim += val[1]; 
       } else if(val[0] == 'up') {
        aim -= val[1];
      } else {
        print('Invalid direction: ${val[0]}');
      }
    }
    result = x*depth;  
    print('Part 1: X*Depth = $x, $depth = $result');

    }

  }
