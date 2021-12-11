class Day9 {
  static const dayFile = '2021/day9.txt';
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
    print(input);
    // Part 1 - for each value, check if lower than surrunding values
    List<int> lowPoints = [];
    List<Set<String>> basins = [];
    
    for(var x = 0; x< colCount; x++) {
      for(var y =0; y<lineCount; y++) {
        var val = input['$x:$y'];
        if((!input.containsKey('${x-1}:${y}') ||  input['${x-1}:${y}'] > val)
           && (!input.containsKey('${x}:${y-1}') || input['${x}:${y-1}'] > val)
           && (!input.containsKey('${x+1}:${y}') || input['${x+1}:${y}'] > val)
           && (!input.containsKey('${x}:${y+1}') || input['${x}:${y+1}'] > val)) {
          lowPoints.add(val);
          basins.add({'$x:$y'});
           }
      }
    }
    print(lowPoints);
    print(basins);
    var result = lowPoints.reduce((val,ele) => val + ele +1) + 1;
    print('Part1: $result');
    // Part 2: From each basin, hunt outwards for 9s..
    for(var basin in basins) {
      // Set so we ignore dupes
      // Can't do sets of lists! Sigh
      var bSize = 0;
      while(basin.length > bSize) {
        bSize = basin.length;
        for(var point in basin.toList()) {
          basin.addAll(findNines(point));
        }
        print(basin);
      }
    }
    print(basins);
    List<Set<String>> largest = [];
    while(largest.length < 3) {
      largest.add(basins.reduce((val, ele) => ele.length > val.length ? ele : val));
      basins.remove(largest.last);
    }
    var result2 = 1 ;
    largest.forEach((val) => result2 *= val.length);
    print('Part2: $result2');
  }

  static List<String> findNines(String loc) {
    List<String> edges = [];
    var p = loc.split(':').map((v) => int.parse(v)).toList();
    var iX = p[0];
    var iY = p[1];
    for(var x = iX-1; x >=0; x--) {
      if(input['$x:$iY'] == 9) {
        break;
      }
      edges.add('$x:$iY');
    }
    for(var x = iX+1; x <colCount; x++) {
      if(input['$x:$iY'] == 9) {
        break;
      }
      edges.add('$x:$iY');
    }
    for(var y = iY+1; y < lineCount; y++) {
      if(input['$iX:$y'] == 9) {
        break;
      }
      edges.add('$iX:$y');
    }
    for(var y = iY-1; y >=0; y--) {
      if(input['$iX:$y'] == 9) {
        break;
      }
      edges.add('$iX:$y');
    }
    return edges;
  }

} 