class Advent {
  static const dayFile = '2022/day3.txt';
  static List<List<String>> sack1 = [];
  static List<List<String>> sack2 = [];
  static List<List<String>> inputs = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    inputs.add(line.split(''));
    int mid = (line.length / 2).toInt();
    // Two bags of characters
    sack1.add(line.substring(0, mid).split(''));
    sack2.add(line.substring(mid).split(''));
  }

  static whenDone() {
    var a = 'a';
    var A = 'A';
    print('a: ${a.codeUnitAt(0)}');
    print('A: ${A.codeUnitAt(0)}');
    var priority = 0;
    for (var i = 0; i< sack1.length; i++) {
      var extra = sack1[i].firstWhere((item) => sack2[i].contains(item));
      // print('Found $extra, unit: ${extra.codeUnitAt(0)}');
      if(extra.toUpperCase() == extra) {
        var value = extra.codeUnitAt(0) - A.codeUnitAt(0) +1 + 26;
        priority += value;
      } else {
        var value =  extra.codeUnitAt(0) - a.codeUnitAt(0) +1;
        priority += value;
      }
    }
    // 2
    var priority2 = 0;
    for (var i = 0; i < inputs.length; i+=3) {
      var extra = inputs[i].firstWhere((item) => inputs[i+1].contains(item) && inputs[i+2].contains(item));
      //  print('Extra: $extra');
      if(extra.toUpperCase() == extra) {
        var value = extra.codeUnitAt(0) - A.codeUnitAt(0) +1 + 26;
        priority2 += value;
      } else {
        var value =  extra.codeUnitAt(0) - a.codeUnitAt(0) +1;
        priority2 += value;
      }
    }
    
    print('Part 1: $priority');
    print('Part 2: $priority2');

  }
}