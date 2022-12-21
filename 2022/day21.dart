import 'dart:convert';

class Advent {
  static const dayFile = '2022/day21.txt';
  static Map<String, Map<String, dynamic>> monkeys = {};
      
  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    // qnrp: 2
    // mffv: shfn * vdcs
    final monkeyRE = RegExp(r'^(\w+):\s*(?:(\d+)|(\w+)\s*([-+*/])\s*(\w+))$');
    if(monkeyRE.hasMatch(line)) {
      var match = monkeyRE.firstMatch(line);
      if(match.group(2) == null) {
        // operation:
        monkeys[match.group(1)] = {'first': match.group(3), 'second': match.group(5), 'op': match.group(4), 'value': -1};
      } else {
        monkeys[match.group(1)] = {'value': int.parse(match.group(2))};
      }
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
