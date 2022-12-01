class Day13 {
  static const dayFile = '2021/day13.txt';
  static Map<String,bool> input = {};
  static List<Map<String,int>> folds = [];
  static var lineCount = 0;
  static var colCount = 0;
  
  static handle(String line) {
    //print('INPUT: $line');
    if(line.contains(',')) {
      var loc = line.split(',').map((v) => int.parse(v)).toList();
      if(loc[0] > colCount) {
        colCount = loc[0];
      }
      if(loc[1] > lineCount) {
        lineCount = loc[1];
      }
      input['${loc[0]}:${loc[1]}'] = true;
    }
    var foldRE = RegExp(r'^fold along (\w)=(\d+)$');
    if(foldRE.hasMatch(line)) {
      var match = foldRE.firstMatch(line);
      folds.add({match.group(1): int.parse(match.group(2))});
    }
  }

  static whenDone() {
    print(input);
    print(folds);
    print('yMax: $lineCount');
    print('xMax: $colCount');
    print(input.entries.where((v) => v.value).toList().length);

    printPaper();
    fold(folds[0]);
    print(input.entries.where((v) => v.value).toList().length);
    printPaper();
    folds.removeAt(0);
    folds.forEach((f) => fold(f));
    printPaper();
  }

  static fold(Map<String,int> foldLine) {
    // we're assuming fold lines are empty..
    if(foldLine.keys.first == 'x') {
      for(var x = foldLine['x'] + 1; x<= colCount; x++) {
        for(var y = 0; y<= lineCount; y++) {
          input['${foldLine['x']}:$y'] = false;
          // Empty the old
          if(input.containsKey('$x:$y')) {
            input['$x:$y'] = false;
            var newX = colCount - x;
            input['$newX:$y'] = true;
          }
        }
      }
      colCount = foldLine['x'] - 1;
    }
    if(foldLine.keys.first == 'y') {
      for(var x = 0; x<= colCount; x++) {
        input['$x:${foldLine['y']}'] = false;
        for(var y = foldLine['y'] + 1; y<= lineCount; y++) {
          if(input.containsKey('$x:$y')) {
            input['$x:$y'] = false;
            var newY = lineCount - y;
            input['$x:$newY'] = true;
          }
        }
      }
      lineCount = foldLine['y'] - 1;
    }
  }

  static printPaper() {
    print('x Rows: ${colCount+1}');
    print('y Rows: ${lineCount+1}');
    for(var y = 0; y <= lineCount; y++) {
      var line = [];
      for(var x = 0; x<= colCount; x++) {
        if(input.containsKey('$x:$y')) {
          line.add('#');
        } else {
          line.add('.');
        }
      }
      print(line.join(''));
    }
  }
} 