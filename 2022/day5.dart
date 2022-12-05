class Advent {
  static const dayFile = '2022/day5.txt';
  static List<List<int>> instructions = [];
  static List<String> crateData = [];
  static List<List<String>> crates = [[],[],[],[],[],[],[],[],[],[]];
  static List<int> positions = [];

  static handle(String line) {
    print('INPUT: $line, ${line.length}');
    final positionRE = RegExp(r'(\w\])');
    int foundCrate = line.indexOf(positionRE, 0);
    // This is a crate data line:
    if(foundCrate > 0) {
      crateData.add(line);
    }

    // ran out of crate data, this is the crate position list (one line)
    final crateNumRE = RegExp(r'(\d+)');
    print('FoundCrate: $foundCrate');
    if (foundCrate == -1 && positions.length == 0) {
      print('Looking at positions');
      foundCrate = line.indexOf(crateNumRE, 0);
      print('found: $foundCrate');
      while(foundCrate > -1) {
        int crateNum = int.parse(line.substring(foundCrate, foundCrate+1));
        //positions.insert(foundCrate, crateNum);
        positions.add(foundCrate);
        //print('Crate: $crateNum, Pos: $positions');
        foundCrate = line.indexOf(crateNumRE, ++foundCrate);
        //print('Found 2: $foundCrate');
      }
      print('Positions: $positions');

      // Now parse the crate data
      for (var i = 0; i < crateData.length; i++) {
        foundCrate = crateData[i].indexOf(positionRE, 0);
        while(foundCrate > 0) {
          int crateNum = positions.indexOf(foundCrate)+1;
          crates[crateNum].add(crateData[i].substring(foundCrate, foundCrate+1));
          foundCrate = crateData[i].indexOf(positionRE, ++foundCrate);
        }
      }
    }

    if(foundCrate == -1 && positions.length > 0) {
      final instrRE = RegExp(r'^move\s(\d+)\sfrom\s(\d+)\sto\s(\d+)$');
      if(instrRE.hasMatch(line)) {
        var match = instrRE.firstMatch(line);
        instructions.add([int.parse(match.group(1)), int.parse(match.group(2)), int.parse(match.group(3))]);
      }
    }
  }

  static whenDone() {
    print(positions);
    //print(crateData);
    print(crates);
    // print(instructions);

    for(var instr in instructions) {
      print(instr);
      for(var i = 0; i < instr[0]; i++) {
        var toMove = crates[instr[1]].removeAt(0);
        crates[instr[2]].insert(0, toMove);
        // print(crates);
      }
    }
    print(crates);
    var tops = crates.map((ele) => ele.length > 0 ? ele[0] : '').join('');
    print('Part 1: $tops');
//    print('Part 2: $overlaps');

  }
}