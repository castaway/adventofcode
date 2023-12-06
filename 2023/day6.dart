import 'dart:math';
class Advent {
  static const dayFile = '2023/day6.txt';
  static List<Map<String,dynamic>> races = [];
  static int rTime;
  static int rDistance;

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    // Time:        35     93     73     66
    // Distance:   212   2060   1201   1044
    final inputRE = RegExp(r'(Time|Distance):\s+([\d\s]+)');
    final match = inputRE.firstMatch(line);
    final values = match[2].split(RegExp(r'\s+')).map((item) => int.parse(item)).toList();
    
    if(races.length == 0) {
      for(var t in values) {
        races.add({match[1]: t});
      }
      rTime = int.parse(values.join(''));
    } else {
      for(var d = 0; d < values.length; d++) {
        races[d][match[1]] = values[d];
      }
      rDistance = int.parse(values.join(''));
    }
    print(races);
  }

  static whenDone() {
    // find values > race.Distance, where value / X = time - X (and time < race.Time)
    // number of ways can get > distance per race, then multiply the results
    List<int> countSolutions = [];
    for (var r in races) {
      r['solutions'] = <int>[];
      //for(var dist = r['Distance']+1; dist < 2*r['Distance']; dist++) {
        var halfTime = (r['Time'] / 2).toInt();
        // start in the middle of the time, increment while distance is greater
        for(var t = halfTime; t * (r['Time'] - t) > r['Distance']; t++) {
          r['solutions'].add(t);
        }
        for(var t = halfTime - 1; t * (r['Time'] - t) > r['Distance']; t--) {
          r['solutions'].add(t);
        }
      //}
      countSolutions.add(r['solutions'].length);
      //print(races);
    }
    // multiply counts:
    print(countSolutions);
    var total = countSolutions.reduce((val, ele) => val * ele);

    // P2, rTime, rDistance
    List<int> rSolutions = [];
    var halfTime = (rTime / 2).toInt();
    // start in the middle of the time, increment while distance is greater
    for(var t = halfTime; t * (rTime - t) > rDistance; t++) {
      rSolutions.add(t);
    }
    for(var t = halfTime - 1; t * (rTime - t) > rDistance; t--) {
      rSolutions.add(t);
    }
    //print(rSolutions);

    print("Part 1: $total");
    //var lowest2 = locations.reduce((val, ele) => ele < val ? ele : val);
    print("Part 2: ${rSolutions.length}");

  }
}
