class Day16 {
  static var dayFile = '2020/day16.txt';

  static Map<String,List<int>> rules = {};
  static Set<int> allValid = <int>{};
  static List<int> myTicket = [];
  static List<List<int>> otherTickets = [];
  static var fileLoc = '';
  static handle(String line) {
    var ruleRE = RegExp(r'^([\w\s]+):\s(\d+)-(\d+) or (\d+)-(\d+)$');
    if(ruleRE.hasMatch(line)) {
      var match = ruleRE.firstMatch(line);
      rules[match.group(1)] = [];
      for(var i = int.parse(match.group(2)); i<= int.parse(match.group(3)); i++) {
        rules[match.group(1)].add(i);
      }
      for(var i = int.parse(match.group(4)); i<= int.parse(match.group(5)); i++) {
        rules[match.group(1)].add(i);
      }
      allValid.addAll(rules[match.group(1)]);
    }

      // var listLen = match.group(3)-match.group(2)+match.group(5)-match.group(4)+2;
      // List<int>.generate(listLen, (int index) => index * index);
      // File section names
    //print(line);
    var lineRE = RegExp(r'^([\w\s]+):$');
    if(line.contains(lineRE)) {
      //print('Found section');
      var match = lineRE.firstMatch(line);
      fileLoc = match.group(1);
      return;
    }

    // My Ticket:
    if(fileLoc == 'your ticket') {
      myTicket = line.split(',').map((str) => int.parse(str)).toList();
      fileLoc = '';
      return;
    }

    if(fileLoc == 'nearby tickets') {
      var newTicket = line.split(',').map((str) => int.parse(str)).toList();
      otherTickets.add(newTicket);
    }
  }

  static whenDone() {
    //print(rules['class']);
    //print(myTicket);
    //print(otherTickets);

    List<List<int>> goodTickets = [];
    List<int> badValues = [];
    for(var ticket in otherTickets) {
      var ticketSet = Set.from(ticket);
      var diff = ticketSet.difference(allValid);
      if(diff.length == 0) {
        goodTickets.add(ticket);
      } else {
        badValues.addAll(List.from(diff));
      }
    }

    print('PART 1: ${badValues.fold(0,(val,entry) => val + entry)}');

    // look at good tickets
    // store ticket indexes that match each rule
    // (start by assuming all then removing the bad ones)
    var matches = <String, Set<int>>{};
    for (var ticket in goodTickets) {
      for(var i = 0; i < ticket.length; i++) {
        for(var rule in rules.entries) {
          if(!matches.containsKey(rule.key)) {
            matches[rule.key] = List<int>.generate(ticket.length, (int index) => index).toSet();
          }
          if(!rule.value.contains(ticket[i])) {
            matches[rule.key].remove(i);
          }
        }
      }
    }
    print(matches);
    // still not clear, remove unique ones from everywhere else until it is
    List<int> fixed = [];
    while(fixed.length < matches.length) {
      var found = findUniqueMatch(matches, fixed);
      fixed.add(found);
    }
    print(matches);
    // final loop!
    var result = 1;
    for(var entry in matches.entries) {
      if(entry.key.startsWith('departure')) {
        var index = entry.value.first;
        result *= myTicket[index];
      }
    }

    print('PART2: $result');
  }

  static int findUniqueMatch(Map<String, Set<int>> state, List<int> known) {
    var found = -1;
    var foundKey = '';
    for(var entry in state.entries) {
      if(entry.value.length == 1 && !known.contains(entry.value.first)) {
        // this must be the correct value:
        print('${entry.key} = ${entry.value.first}');
        found = entry.value.first;
        foundKey = entry.key;
      }
    }
    // remove from all other lists
    for(var entry in state.entries) {
      if(entry.key != foundKey) {
        entry.value.remove(found);
      }
    }
    return found;
  }
}