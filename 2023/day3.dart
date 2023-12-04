class Advent {
  static const dayFile = '2023/day3_test.txt';
  static Map<String,String> chart = {};
  static Map<String,String> symbols = {};
  static int lineCount = 0;
  static int lineLength = 0;

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    // 467..114..
    // ...*......
    final parts = line.split(RegExp(r''));
    for(var x = 0; x < parts.length; x++) {
      chart["$x:$lineCount"] = parts[x];
      if(RegExp(r'[^\d\.]').hasMatch(parts[x])) {
        symbols["$x:$lineCount"] = parts[x];
      } else {
        symbols["$x:$lineCount"] = '';
      }
    }

    lineCount++;
    lineLength = parts.length;
  }

  static whenDone() {
    var nums = [];
    Map<String, int> allGears = {};
    int gearTotal = 0;
    //print(chart);
    print("LineLen, LineCnt: $lineLength, $lineCount");
    for(var y = 0; y < lineCount; y++) {
      var currentNum = '';
      var hasSymbol = '';
      List<String> hasGears = [];
      for(var x = 0; x < lineLength; x++) {
        //print("Checking: $x, $y, ${chart["$x:$y"]}");
        if(int.tryParse(chart["$x:$y"]) != null) {
          currentNum += chart["$x:$y"];
          //print("Found: $currentNum");
          List<String> gears = [];
          hasSymbol +=  checkSymbol(x,y,lineLength, lineCount, symbols, gears);
          if(gears.length > 0 && !hasGears.contains(gears.last)) {
            print("Found gears: $gears");
            hasGears.add(gears.last);
          }
        } else {
          if(currentNum.length > 0 && hasSymbol.length > 0) {
            print("Found with symbol: $currentNum, $hasSymbol");
            nums.add(int.parse(currentNum));
            if(hasGears.length > 0) {
              for(var g in hasGears) {
                //print("allG pre: $allGears");
                if(allGears.containsKey(g)) {
                  allGears[g] = allGears[g] * nums.last;
                  gearTotal += allGears[g];
                } else {
                  allGears[g] = nums.last;
                }
                //print("allG post: $allGears");
                //print("gTotal: $gearTotal");
              }
            }
          }
          currentNum = '';
          hasSymbol = '';
          hasGears = [];
        }
      }
      if(currentNum.length > 0 && hasSymbol.length > 0) {
        print("Found with symbol: $currentNum");
        nums.add(int.parse(currentNum));
      }
    }
    //print(allGears);
    var total = nums.reduce((val,ele) => val+ele);
    print("Part 1: $total");
    print("Part 2: $gearTotal");

  }
}

checkSymbol(int x, int y, int maxX, int maxY, Map symbols, List gears) {
  var x_min = x > 0 ? x - 1 : x;
  var y_min = y > 0 ? y - 1 : y;
  var x_max = x < maxX + 1 ? x + 1 : x;
  var y_max = y < maxY + 1 ? y + 1 : y;

  for(var fromx = x_min; fromx <= x_max; fromx++) {
    for(var fromy = y_min; fromy <= y_max; fromy++) {
      if(symbols.containsKey("$fromx:$fromy") && symbols["$fromx:$fromy"].length > 0) {
        if(symbols["$fromx:$fromy"] == '*') {
          gears.add("$fromx:$fromy");
        }
        return symbols["$fromx:$fromy"];
      }
    }
  }
  return '';
}