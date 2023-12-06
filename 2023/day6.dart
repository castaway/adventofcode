import 'dart:math';
class Advent {
  static const dayFile = '2023/day6_test.txt';
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
      for(var dist = r['Distance']+1; dist < 2*r['Distance']; dist++) {
        for(var t = 1; t < r['Time']; t++) {
          if(dist % t != 0) {
            continue;
          }
          if(dist / t  == r['Time'] - t) {
            r['solutions'].add(r['Time'] - t);
          }
        }
      }
      countSolutions.add(r['solutions'].length);
      //print(races);
    }
    // multiply counts:
    print(countSolutions);
    var total = countSolutions.reduce((val, ele) => val * ele);

    // P2, rTime, rDistance
    List<int> rSolutions = [];
    for(var dist = rDistance+1; dist < 2*rDistance; dist++) {
      print(dist);
      for(var t = 1; t < rTime; t++) {
        if(dist % t != 0) {
          continue;
        }
        if(dist / t  == rTime - t) {
          rSolutions.add(rTime - t);
        }
      }
    }

    print(rSolutions);

    print("Part 1: $total");
    //var lowest2 = locations.reduce((val, ele) => ele < val ? ele : val);
    print("Part 2: ${rSolutions.length}");

  }
}
