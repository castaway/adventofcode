import 'dart:convert';

class Advent {
  static const dayFile = '2022/day9.txt';
  static List<List<String>> input = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    var instrs = line.split(' ');
    input.add(instrs);
    // movement in x, y
  }

  static whenDone() {
    var p1 = 0;
    print(input);
    var locations = {'H': [0,0], 'T': [0,0]};
    // longer rope:
    for (var x = 1; x <=9; x++) {
      locations[x.toString()] = [0,0];
    }
    var visited = Set();
    visited.add('0:0');
    for(var instrs in input) {
      switch(instrs[0]) {
        case 'U':
          var val = int.parse(instrs[1]);
          for(var x = 1; x <= val; x++) {
            // H moves
            locations['H'][1] += 1;
            // T follows
            var changeT = goTo(locations);
            locations['T'][0] += changeT[0];
            locations['T'][1] += changeT[1];
            //print('U: loc: $locations');
            visited.add('${locations['T'][0]}:${locations['T'][1]}');
          }
          break;
        case 'D':
          var val = int.parse(instrs[1]);
          for(var x = 1; x <= val; x++) {
            // H moves
            locations['H'][1] -= 1;
            // T follows
            var changeT = goTo(locations);
            locations['T'][0] += changeT[0];
            locations['T'][1] += changeT[1];
            //print('D: loc: $locations');
            visited.add('${locations['T'][0]}:${locations['T'][1]}');
          }
          break;
        case 'R':
          var val = int.parse(instrs[1]);
          for(var x = 1; x <= val; x++) {
            // H moves
            locations['H'][0] += 1;
            // T follows
            var changeT = goTo(locations);
            locations['T'][0] += changeT[0];
            locations['T'][1] += changeT[1];
            //print('R: loc: $locations');
            visited.add('${locations['T'][0]}:${locations['T'][1]}');
          }
          break;
        case 'L':
          var val = int.parse(instrs[1]);
          for(var x = 1; x <= val; x++) {
            // H moves
            locations['H'][0] -= 1;
            // T follows
            var changeT = goTo(locations);
            locations['T'][0] += changeT[0];
            locations['T'][1] += changeT[1];
            //print('L: loc: $locations');
            visited.add('${locations['T'][0]}:${locations['T'][1]}');
          }
          break;
        default:
          print('Bad input: $instrs');
      }
      
    }
    // print(visited);

    print('Part 1: ${visited.length}');
    // print('Part 2: ${p2.first}');

  }
}
  List<int> goTo(locs) {
    List<int> move = [0,0];
    if(locs['T'][0] ==  locs['H'][0] + 2
      && locs['T'][1] == locs['H'][1]) {
      move[0] = -1;
    }
    if(locs['T'][0] ==  locs['H'][0] - 2
      && locs['T'][1] == locs['H'][1]) {
      move[0] = 1;
    }
    if(locs['T'][1] ==  locs['H'][1] + 2
      && locs['T'][0] == locs['H'][0]) {
      move[1] = -1;
    }
    if(locs['T'][1] ==  locs['H'][1] - 2
      && locs['T'][0] == locs['H'][0]) {
      move[1] = 1;
    }
    //print('goTo 1: Moved $move');
    // arent touching or in same row/column
    //print('Cond 1: ${(locs["T"][0] - locs['H'][0]).abs() + (locs['T'][1] - locs['H'][1]).abs()}');
    //print('Cond 2: ${locs['T'][0] != locs['H'][0] && locs['T'][1] != locs['H'][1]}');
    if((locs['T'][0] - locs['H'][0]).abs() + (locs['T'][1] - locs['H'][1]).abs() > 2 &&
      locs['T'][0] != locs['H'][0] && locs['T'][1] != locs['H'][1]) {
      if(locs['T'][0] >  locs['H'][0]) {
        move[0] = -1;
      }
      if(locs['T'][0] < locs['H'][0]) {
        move[0] = 1;
      }
      if(locs['T'][1] >  locs['H'][1]) {
        move[1] = -1;
      }
      if(locs['T'][1] <  locs['H'][1]) {
        move[1] = 1;
      }      
      //print('goTo 2: Moved $move');
    }
    return move;
  }
