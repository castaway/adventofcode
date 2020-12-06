class Day6 {
  static const dayFile = '2020/day6.txt';
  static List<List<List<String>>> customs = []; // groups, people, questions
  static List<List<String>> currentGroup = [];
  static handle(String line) {
    if(line == '') {
      customs.add(currentGroup);
      currentGroup = [];
      return;
    }
    print(line);
    currentGroup.add(line.split(''));
  }
  
  static whenDone() {
    customs.add(currentGroup);
    print(customs);
    // count all questions which were true in group
    var count1 = customs.fold(0, (val, group) {
      // make a Set of unique questions
      Set<String> unique = {};
      group.forEach((person) => unique.addAll(person));
      return val + unique.length;
    });
    print('PART 1: $count1');
    // Pt2: questions where everyone in group said yes
    var count2 = customs.fold(0, (val, group) {
      Set<String> unique = Set.from(group[0]);
      // keep the values that exist in following people answers
      group.forEach((person) => 
        unique.retainWhere((uval) => 
          person.contains(uval)
        )
      );
      return val + unique.length;
    });
    print('PART 2: $count2');
  }
}
