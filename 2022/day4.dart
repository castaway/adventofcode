class Advent {
  static const dayFile = '2022/day4.txt';
  static List<Set<int>> elf1 = [];
  static List<Set<int>> elf2 = [];
  // static List<List<String>> inputs = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    final sectionsRE = RegExp(r'^(\d+)-(\d+),(\d+)-(\d+)$');
    if(sectionsRE.hasMatch(line)) {
      var match = sectionsRE.firstMatch(line);
      var firstSet = Set<int>();
      for (var e1 = int.parse(match.group(1)); e1 <= int.parse(match.group(2)); e1++) {
        firstSet.add(e1);
      }      
      elf1.add(firstSet);
      var secondSet = Set<int>();
      for (var e2 = int.parse(match.group(3)); e2 <= int.parse(match.group(4)); e2++) {
        secondSet.add(e2);
      }      
      elf2.add(secondSet);
    }
  }

  static whenDone() {
    var contained = 0;
    for (var i = 0; i < elf1.length; i++) {
      if(elf1[i].containsAll(elf2[i]) || elf2[i].containsAll(elf1[i])) {
        contained++;
      }
    }

    var overlaps = 0;
    for (var i = 0; i < elf1.length; i++) {
      if(elf1[i].intersection(elf2[i]).length > 0) {
        overlaps++;
      }
    }
    
    print('Part 1: $contained');
    print('Part 2: $overlaps');

  }
}