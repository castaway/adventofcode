class Day8 {
  static const dayFile = '2021/day8.txt';
  static List<Map<String, List<String>>> inputs = [];
  static Map<String, int> numbers = {'ABCEFG': 0, 'CF': 1, 'ACDEG': 2, 'ACDFG': 3, 'BCDF': 4, 'ABDFG': 5, 'ABDEFG': 6, 'ACF': 7, 'ABCDEFG': 8, 'ABCDFG': 9};
  
  static handle(String line) {
    //print('INPUT: $line');
    // fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    var parts = line.split(' | ');
    inputs.add({});
    inputs.last['test'] = parts[0].split(' ');
    inputs.last['digits'] = parts[1].split(' ');
  }
  static whenDone() {
    print(inputs);
    // Part 1 - count how many 2,3,4 and 7 len digits
    var p1count = 0;
    for(var inp in inputs) {
      p1count += inp['digits'].where((val) => val.length == 2 || val.length == 3 || val.length == 4 || val.length == 7).toList().length;
    }
    print('Part 1: $p1count');

    List<int> values = [];
    for (var inp in inputs) {
      var segMap = findDigits(inp['test']);
      var numStr = inp['digits'].map((digit) {
        var segs = digit.split('').map((c) => segMap[c]).toList();
        segs.sort();
        var segStr = segs.join('');
        // print(segStr);
        return numbers[segStr];
      }).toList();
      // print(numStr);
      values.add(int.parse(numStr.join()));
    }
    var result = values.reduce((val, ele) => val + ele);
    print('Part 2: $result');
  }

  static Map<String, String> findDigits(List<String> values) {
    // 3 5-seg numbers
    //3 6-seg numbers
    // A-G 
    // A appears 8 times
    // B = 6, C = 8, D = 7, E = 4, F = 9, G = 7
    var seven = values.firstWhere((val) => val.length == 3);
    var one = values.firstWhere((val) => val.length == 2);
    var four = values.firstWhere((val) => val.length == 4);
    var eight = values.firstWhere((val) => val.length == 7);
    Map<String,int> segCounts = {};
    for(var value in values) {
      value.split('').forEach((l) => segCounts[l] = segCounts.containsKey(l) ? segCounts[l] + 1 : 1);
    }
    //print(segCounts);
    Map<String, String> segMap = {};
    segMap[segCounts.entries.firstWhere((e) => e.value == 4).key] = 'E';
    segMap[segCounts.entries.firstWhere((e) => e.value == 9).key] = 'F';
    segMap[segCounts.entries.firstWhere((e) => e.value == 6).key] = 'B';
    // two items which appearv8 times, one of them is in the known 7 character
    var eightSeg = segCounts.entries.where((e) => e.value == 8).map((e) => e.key);
    for(var eSeg in eightSeg) {
      if(one.contains(eSeg)) {
        segMap[eSeg] = 'C';
      } else {
        segMap[eSeg] = 'A';
      }
    }
  
    var sevenSeg = segCounts.entries.where((e) => e.value == 7).map((e) => e.key);
    for(var sSeg in sevenSeg) {
      if(four.contains(sSeg)) {
        segMap[sSeg] = 'D';
      } else {
        segMap[sSeg] = 'G';
      }
    }
    // print(values);
    // print(segMap);
    return segMap;
  }
} 