class Day19 {
  static var dayFile = '2020/day19.txt';

  static Map<int, String> rules = {};
  static List<String> messages = [];
  static List<int> finished = [];
  static handle(String line) {
    // just collect the numbers and the string initially
    var ruleRegExp = RegExp(r'^(\d+):\s(["\w\d\s|]+)$');
    if(ruleRegExp.hasMatch(line)) {
      var match = ruleRegExp.firstMatch(line);
      var ruleNum = int.parse(match.group(1));
      rules[ruleNum] = match.group(2);
      if(match.group(2).contains('"')) {
        finished.add(ruleNum);
      }
    } else {
      messages.add(line);
    }
  }

  static whenDone() {
    //print(rules);
    //print(messages);
    print(finished);
    var unfinishedRules = rules.length;
    var finishedRules = false;
    while(!finishedRules) {
      for(var rule in rules.entries) {
        rules[rule.key] = rule.value.replaceAllMapped(
          new RegExp(r'(\d+)'), (Match m) {
            var ruleNum = int.parse(m.group(1));

            return rules[ruleNum].contains(new RegExp(r'^"\w"$'))
            ? rules[ruleNum]
            : '(?:${rules[ruleNum]})';
          });
        //print('Rule 0: ${rules[0].length} -  ${rules[0]}');
        if(!rules[0].contains(new RegExp(r'\d'))) {
          //print('Reduced rule: ${rules[r]}');
          finishedRules = true;
        }
      }
    }
    rules[0] = rules[0].replaceAll(new RegExp(r'["\s]'),'');
    print(rules[0]);
    var count = 0;
    for(var m in messages) {
      print(m);
      if(m.contains(new RegExp('^${rules[0]}\$'))) {
        count++;
      }
    }
    print('PART 1: $count of ${messages.length}');
    print(rules[42]);
    print(rules[31]);
  }

}