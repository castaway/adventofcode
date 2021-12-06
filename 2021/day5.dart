class Day5 {
  static const dayFile = '2021/day5.txt';
  static List<Map<String,int>> inputs = [];
  static Map<String, int> countsP1 = {};
  static Map<String, int> countsP2 = {};

  static handle(String line) {
    // print('INPUT: $line');
    final pointsRE = RegExp(r'^(\d+),(\d+)\s->\s(\d+),(\d+)$');
    if(pointsRE.hasMatch(line)) {
      var match = pointsRE.firstMatch(line);
      inputs.add({
        'x1': int.parse(match.group(1)),
        'y1': int.parse(match.group(2)),
        'x2': int.parse(match.group(3)),
        'y2': int.parse(match.group(4))});
    }
    final seg = inputs.last;
    var isDiag = false;
    if(seg['x1'] != seg['x2'] && seg['y1'] != seg['y2']) {
      isDiag = true;
    }
    var sorted = {};
    sorted['x'] = [seg['x1'],seg['x2']];
    sorted['x'].sort();
    sorted['y'] = [seg['y1'],seg['y2']];
    sorted['y'].sort();
    var loopInd = 'x';

    if(!isDiag && seg['x1'] == seg['x2']) {
      loopInd = 'y';
    }
    // loop over x or y depending on which changes
    // for diag, increase both
    var x = seg['x1'];
    var y = seg['y1'];
    //print(seg);
    //print(sorted);
    for(var index=sorted[loopInd][0]; index<=sorted[loopInd][1]; index++ ) {
      // only need one loop!
      var key = loopInd == 'x' ? '$index:${seg['y1']}' : '${seg['x1']}:$index';
      if(!isDiag) {
        countsP1[key] = countsP1.containsKey(key) ? countsP1[key]+1 : 1;
        countsP2[key] = countsP2.containsKey(key) ? countsP2[key]+1 : 1;
      } else {
        // diagonal, inc both:
        //print('$x:$y');

        countsP2['$x:$y'] = countsP2.containsKey('$x:$y') ? countsP2['$x:$y']+1 : 1;
        // some magical "count towards this number", would be useful!
        x += seg['x2'] > seg['x1'] ? 1 : -1;
        y += seg['y2'] > seg['y1'] ? 1 : -1;
      }
    }
  }
  static whenDone() {
    //print(inputs);
    // print(countsP2);
    // part1 , counts at least 2
    var part1 = countsP1.values.where((val) => val > 1).toList();
    print('Part1: ${part1.length}');
    var part2 = countsP2.values.where((val) => val > 1).toList();
    print('Part2: ${part2.length}');
  }
}