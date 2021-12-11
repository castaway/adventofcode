class Day11 {
  static const dayFile = '2021/day11.txt';
  static Map<String,int> input = {};
  static int lineCount = 0;
  static int colCount = 0;
  
  static handle(String line) {
    //print('INPUT: $line');
    var valCount = 0;
    line.split('').map((v) => int.parse(v)).forEach((v) => input['${valCount++}:$lineCount'] = v);
    lineCount++;
    colCount = valCount;
  }

  static whenDone() {
    // Part 1 - iterate 100x, flash each 9 + increase surrunding
    Map<int, List<String>> inputRev = {};
    var flashCount = 0;
    List<String> flashed = [];
    for(var i=0; i<1000; i++) {
      // inc all
      print(i);
      for(var loc in input.keys) {
        incOctopus(loc);
      }
      print('-');
      printMap();
      // flash 9s and spread
      flashed = [];
      while(true) {
        var prev = flashCount;
          inputRev[9] = input.entries.where((v) => v.value > 9).map((v) => v.key).toList();
  //      print(inputRev);
          if(inputRev[9].length > 0) {
            print('found 9: ${inputRev[9]}');
            flashCount += inputRev[9].length;
            flashed.addAll(inputRev[9]);
            for(var loc in inputRev[9]) {
              // check neighbours and increase
              var pos = loc.split(':').map((v)=> int.parse(v)).toList();
              print('Pos: $pos');
              for(var x = pos[0]-1; x<=pos[0]+1; x++) {
                for(var y = pos[1]-1; y <= pos[1] + 1; y++) {
                  if(x >= 0 && y >= 0 && x < colCount && y < lineCount) {
                    if(x == pos[0] && y == pos[1]) {
                      continue;
                    }
                    var cLoc = '$x:$y';
                    if(flashed.contains(cLoc)) {
                      continue;
                    }
                    // print('Check neighbour: $cLoc, ${input[cLoc]}');
                    if(input[cLoc] > 10) {
                      print('val over 10!?');
                      continue;
                    }
                    incOctopus(cLoc);
                  }
                }
              }
          }
          inputRev[9] = [];
          flashed.forEach((v) => input[v] = 0);
        }
        print('- end loop');
        printMap();
        if(prev == flashCount) {
          flashed.forEach((v) => input[v] = 0);
          print('end');
          printMap();
          break;
        }
      }
      if (i == 100) {
        print('Part1: $flashCount');
      }
      if(flashed.length == colCount * lineCount) {
        print('Part2: $i');
        break;
      }
    }
  }

  static incOctopus(String loc) {
    input[loc]++;
  }

  static printMap() {
  for(var y = 0; y < lineCount; y++) {
      var line = [];
      for(var x = 0; x < colCount; x++) {
        line.add(input['$x:$y']);
      }
      print(line.join(''));
    }
  }
} 