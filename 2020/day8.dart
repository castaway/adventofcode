class Day8 {
  static var dayFile = '2020/day8.txt';

  static List<MapEntry> program = [];
  static int currentValue = 0;
  static int currentPosition = 0;
  static int currentChange = 0;

  static handle(String line) {
    var instr = RegExp(r'(\w+)\s([-+\d]+)');
    var match = instr.firstMatch(line);
    program.add(MapEntry(match.group(1), int.parse(match.group(2))));
  }

  static whenDone() {
    Map<int,bool> oldPos = {};
    var oldValue = 0;
    var newPosition = 0;
    while(!oldPos.containsKey(newPosition)) {
      oldValue = currentValue;
      oldPos[currentPosition] = true;
      print('Run: $currentPosition');
      newPosition = runProgram(program);
    }
    print('PART 1: $oldValue');

    // Attempt to edit a jmp to a nop or vice versa, and rerun until exit or repeat..
    oldPos = {};
    oldValue = 0;
    newPosition = 0;
 
    while(newPosition < program.length ) {
      currentChange = program.indexWhere((entry) => 
        entry.key == 'jmp' || entry.key == 'nop', currentChange);
      // this should be a deep copy.. 
      List<MapEntry> newProgram = program.map((entry) => MapEntry(entry.key, entry.value)).toList();
      if(newProgram[currentChange].key == 'nop') {
        newProgram[currentChange] = MapEntry('jmp', newProgram[currentChange].value);
      } else {
        newProgram[currentChange] = MapEntry('nop', newProgram[currentChange].value);
      }
      print('Changed instruction at $currentChange');
      currentChange++;

      oldPos = {};
      oldValue = 0;
      newPosition = 0;
      while(!oldPos.containsKey(newPosition)) {
        oldValue = currentValue;
        oldPos[currentPosition] = true;
        // print('Run: $currentPosition');
        newPosition = runProgram(newProgram);
      }
    }

    print('PART 2: $currentValue');
  }

  // Can we predefine a Map with instructions -> functions?

  static runProgram(List<MapEntry> currentProgram) {
    if(currentPosition >= currentProgram.length) {
      return currentPosition;
    }
    var currentInstruction = currentProgram[currentPosition];
    switch (currentInstruction.key) {
      case 'acc':
        currentValue += currentInstruction.value;
        currentPosition += 1;
        break;
      case 'nop':
        currentPosition += 1;
        break;
      case 'jmp':
        currentPosition += currentInstruction.value;
        break;
      default:
        print('Unknown instruction at: $currentPosition');
    }
    return currentPosition;
  }
}