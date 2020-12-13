class Day12 {
  static var dayFile = '2020/day12.txt';
  
  static List<MapEntry> instructions = [];
  static handle(String line) {
    var navReg = RegExp(r'^(\w)(\d+)$');
    var match = navReg.firstMatch(line);
    instructions.add(MapEntry(match.group(1), int.parse(match.group(2))));
  }
  
  static whenDone() {
    var loc = {'x':0,'y':0, 'dir':1};
    for(var navInstr in instructions) {
      loc = getNextState(loc, navInstr);
      print(loc);
    }
    print(loc);
    var abssum = loc['x'].abs()+loc['y'].abs();
    print('PART 1: $abssum');
  }
  
  static getNextState(Map start, MapEntry move) {
    print(move);
    List<String> dirs = ['N', 'E', 'S', 'W'];
    switch(move.key) {
      case 'N':
        start['y'] -= move.value;
        break;
      case 'S':
        start['y'] += move.value;
        break;
      case 'E':
        start['x'] += move.value;
        break;
      case 'W':
        start['x'] -= move.value;
        break;
      case 'F':
        start = getNextState(start, MapEntry(dirs[start['dir']], move.value));
        break;
      case 'L':
        if(move.value == 180) {
          start['dir'] -= 2;
        } else {
          start['dir'] -= 1;
        }
        break;
      case 'R':
        if(move.value == 180) {
          start['dir'] += 2;
        } else {
          start['dir'] += 1;
        }
        break;
      default:
        print('Unknown nav instruction: $move');
    }
    //print('ST: $start');
    if(start['dir'] < 0) {
      start['dir'] = dirs.length + start['dir'];
    }
    //print('ST2: $start');
    if(start['dir'] >= dirs.length) {
      start['dir'] = start['dir'] - dirs.length;
    }
    //print('ST3: $start');
    
    return start;

  }
}