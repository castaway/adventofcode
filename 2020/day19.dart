class Day19 {
  static var dayFile = '2020/day19.txt';

  static List<String> rules = [];
  static List<String> messages = [];
  static List<int> finished = [];
  static handle(String line) {
    // just collect the numbers and the string initially
    var ruleRegExp = RegExp(r'^(\d+):\s(["\w\d\s|]+)$');
    if(ruleRegExp.hasMatch(line)) {
      var match = ruleRegExp.firstMatch(line);
      rules.add(match.group(2));
      if(match.group(2).contains('"')) {
        finished.add(rules.length - 1);
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
    var counter = 0;
    while(counter < 2) {
      for(var i = 0; i < rules.length; i++) {
        
      }
      rules[0] = rules[0].replaceAllMapped(
        new RegExp(r'(\d+)'), (Match m) => rules[int.parse(m.group(1))]);
      print('Rule 0: ${rules[0].length} -  ${rules[0]}');
      if(!rules[0].contains(new RegExp(r'\d'))) {
        //print('Reduced rule: ${rules[r]}');
        finishedRules = true;
      }
      counter++;
    }
    //print(rules);
  }

}