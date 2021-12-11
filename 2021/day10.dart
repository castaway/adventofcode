class Day10 {
  static const dayFile = '2021/day10.txt';
  static List<List<String>> input = [];
  static const Map<String,String> brackets = {'<': '>', '(': ')', '[': ']', '{': '}'};
  
  static handle(String line) {
    //print('INPUT: $line');
    input.add(line.split(''));
  }

  static whenDone() {
    // print(input);
    List<String> errors = [];
    List<int> acScores = [];
    for (var line in input) {
      List<String> stack = [];
      bool error = false;
      for (var brckt in line) {
        if(brackets.containsKey(brckt)) {
          // Opening
          stack.add(brckt);
        } else {
          if(brckt == brackets[stack.last]) {
            stack.removeLast();
          } else {
            // error! don't care further (part1)
            errors.add(brckt);
            error = true;
            break;
          }
        }
      }
      if(!error) {
        // If we got here, the line is incomplete
        // calc missing bracket scores
        const Map<String,int> compPoints = {')': 1,
      ']': 2,
      '}': 3,
      '>': 4 };
        var total = 0;
        print(stack);
        for(var b in stack.reversed) {
          total = total * 5 + compPoints[brackets[b]];
        }
        acScores.add(total);
      } 
    }
    // Add up points:
    const Map<String, int> points = {')': 3,
      ']': 57,
      '}': 1197,
      '>': 25137 };
    var result = 0;
    errors.forEach((v) => result += points[v]);
    print('Part 1: $result');
    // print(acScores);
    acScores.sort();
    print(input.length);
    print(acScores.length);
    // print(acScores);
    print((acScores.length / 2).floor());
    print('Part 2: ${acScores[(acScores.length / 2).floor()]}');
  }
} 