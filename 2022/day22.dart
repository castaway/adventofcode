import 'dart:convert';

class Advent {
  static const dayFile = '2022/day22.txt';
  static Map<String, String> board = {};
      
  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    if(line.contains('.')) {
      var row = line.split('');
      var y = 1;
      for(var x=1; x <= row.length; x++) {
        board['$x:${y++}'] = row[x];
      }
    } else {
      
    }
  }

  static whenDone() {
    var p1 = 0;
    print(monkeys);
    p1 = solve(monkeys, 'root');
    print(monkeys);
    print('Part 1: $p1');
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
