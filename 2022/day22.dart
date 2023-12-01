import 'dart:convert';

class Advent {
  static const dayFile = '2022/day22.txt';
  static Map<String, String> board = {};
  static List<String> instructions = [];
  static int col = 1;
  static int maxY = 0;
  static int maxX = 0;

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    if(line.contains('.')) {
      maxY++;
      var row = line.split('');
      for(var x=1; x <= row.length; x++) {
        board['$x:$col'] = row[x-1];
      }
      if (row.length > maxX) {
        maxX = row.length;
      }
      col++;
    } else {
      final instrRE = RegExp(r'(\d+|\w)');
      for (var m in instrRE.allMatches(line)) {
        instructions.add(m.group(1));
      }
    }
  }

  static whenDone() {
    var p1 = 0;
    // print(board);
    // print(instructions);
    var dir = [1,0]; // x+1, y+0
    var d = 1; // Right
    var location = [1,1];
    for(var step in instructions) {
      var dist = int.tryParse(step);
      if(dist !== null) {
        // walk:
        for (var i = 1; i <= dist; i) {
          var nextLoc =  '${location[0]+dir[0]}:${location[1]+dir[1]}';
          if(board.containsKey(nextLoc) && board.containsKey(nextLoc) !== ' ') {
            if(board[nextLoc] == '.') {
              location[0] += dir[0];
              location[1] += dir[1];
            }
          } else {
            // wrap around
            var newXY = [];
            switch (d) {
              case 1:
                // x+
                // find next non-empty field from begining of row
                var x = 1;
                while(board['$x:${location[1]+dir[1]}'] == ' ') {
                  x++;
                }
                if(board['$x:${location[1]+dir[1]}'] == '.') {
                  newXY[0] = x;
                  newXY[1] = location[1];
                }
                break;
              case 2:
                // x+
                // find next non-empty field from begining of row
                var y = 1;
                while(board['${location[0]+dir[0]}:$y'] == ' ') {
                  y++;
                }
                if(board['${location[0]+dir[0]}:$y'] == '.') {
                  newXY[0] = location[0];
                  newXY[1] = y;
                }
                break;
              case 3:
                // x+
                // find next non-empty field from begining of row
                var x = maxX;
                while(board['$x:${location[1]+dir[1]}'] == ' ') {
                  x--;
                }
                if(board['$x:${location[1]+dir[1]}'] == '.') {
                  newXY[0] = x;
                  newXY[1] = location[1];
                }
                break;
              
            }
          }
        }
      } else {
        var dirs = { 1:[1,0], 2: [0,1], 3: [-1,0], 4:[0,-1] }; // x+1, y+0
        // turn
        if (step == 'R') {
          d += 1;
        }
        if (step == 'L') {
          d -= 1;
        }
        if (d > 4) {
          d = = 1;
        }
        if (d == 0) {
          d = 4;
        }
        dir = dirs[d];
      }
    }
    print('Part 1: $location');
    //print('Part 2: $p2');
  }
}

solve(monkeys, name) {
  if(monkeys[name]['value'] > 0) {
    return monkeys[name]['value'];
  }
  switch (monkeys[name]['op']) {
    case '+':
      monkeys[name]['value'] 
        = solve(monkeys, monkeys[name]['first']) 
        + solve(monkeys, monkeys[name]['second']);
      break;
    case '-':
      monkeys[name]['value'] 
        = solve(monkeys, monkeys[name]['first']) 
        - solve(monkeys, monkeys[name]['second']);
      break;
    case '/':
      monkeys[name]['value'] 
        = (solve(monkeys, monkeys[name]['first']) 
        / solve(monkeys, monkeys[name]['second'])).toInt();
      break;
    case '*':
      monkeys[name]['value'] 
        = solve(monkeys, monkeys[name]['first']) 
        * solve(monkeys, monkeys[name]['second']);
      break;
    default:
      print('Unknown op: ${monkeys[name]['op']}');
  }
  return monkeys[name]['value'];
}
