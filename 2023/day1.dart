class Advent {
  static const dayFile = '2023/day1.txt';
  static List<int> inputs = [];
  static List<int> inputs2 = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    final digits = line.split(RegExp(r''));
    digits.retainWhere((item) => item.length > 0 && int.tryParse(item) != null);
    // print(digits);
    int d1, d2;
    if(digits.length > 0) {
      d1 = int.parse(digits.first);
      d2 = int.parse(digits.last);
      inputs.add(d1*10+d2);
    }

    // P2 treat strings 'one', 'two' etc as digits ..
    var numMap = {'one': 'o1e', 'two':'t2o','three':'t3e','four':'f4r','five':'f5e','six':'s6x','seven':'s7n','eight':'e8t','nine':'n9e'};
    print(line);
    
    String newLine = line;
    for(var k in numMap.keys) {
      newLine = newLine.replaceAll(k, numMap[k]);
    }
    print(newLine);
    /*
    var line2 = line.replaceAllMapped(
      RegExp(r'(one|two|three|four|five|six|seven|eight|nine)', caseSensitive: false),
        (Match m) => numMap[m[1]]);
    print(line2);
    */
    final digits2 = newLine.split(RegExp(r''));
    digits2.retainWhere((item) => item.length > 0 && int.tryParse(item) != null);
    print(digits2);
    d1 = int.parse(digits2.first);
    d2 = int.parse(digits2.last);
    inputs2.add(d1*10+d2);
  }

  static whenDone() {
    int val = inputs.reduce((val, ele) => val + ele);
    int val2 = inputs2.reduce((val, ele) => val + ele);
/*
    for (var i in inputs) {
      var total = elf.reduce((val,element) => val + element);
      totals.add(total);
      if (total > most) {
        most = total;
      }
    }
    totals.sort();
    var totalsRev = totals.reversed;
    var t2 = totalsRev.take(3).reduce((v,e) => v+e);
    */

    print("Part 1: $val");
    print("Part 2: $val2");

  }
}