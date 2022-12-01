class Advent {
  static const dayFile = '2022/day1.txt';
  static List<int> inputs = [];
  static List<List<int>> elves = [[]];
  static var elf = 0; 

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    if (line.length == 0) {
      elf++;
      elves.add([]);
      return;
    }
    int newNum = int.parse(line);
    elves[elf].add(newNum);
  }

  static whenDone() {
    int most = 0;
    List<int> totals = [];
    for (var elf in elves) {
      var total = elf.reduce((val,element) => val + element);
      totals.add(total);
      if (total > most) {
        most = total;
      }
    }
    totals.sort();
    var totalsRev = totals.reversed;
    var t2 = totalsRev.take(3).reduce((v,e) => v+e);
      

    print("Part 1: $most");
    print("Part 2: $t2");

  }
}