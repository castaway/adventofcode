class Day7 {
  static var dayFile = '2020/day7.txt';
  
  static Map<String, List<Map<String, dynamic>>> bags = {};

  static handle(String line) {
    var parts = line.split('s contain ');
    var bagItem = RegExp(r'(\d+)\s([\w\s]+?)s?[,.]\s?');
    bagItem.allMatches(parts[1]).forEach((match) {
      if(!bags.containsKey(match.group(2))) {
        bags[match.group(2)] = [];
      }
      print('Matched: >${parts[0]}< contains >${match.group(2)}<');
      bags[match.group(2)].add({'name': parts[0], 'count': int.parse(match.group(1))});
    });
  }
  
  static whenDone() {
    print(bags);
    print('PART 1: ${count('shiny gold bag', -1)}');
    print('PART 2: ${contains('shiny gold bag', 0) - 1}');
  }
  
  static var seen = {};
  static int count(String bagName, int total) {
    //print('$bagName, $total');
    // We counted this one already, don't count it again:
    if(seen.containsKey(bagName)) {
       //print('Return total for $bagName(seen): $total');
      return total;
    }
    // This one doesn't contain any other bags, just count itself:
    if(!bags.containsKey(bagName)) {
       //print('Return total for $bagName(empty): ${total+1}');
      seen[bagName] = true;
      return total+1;
    }
    //print(bags[bagName].length);
    // fold/reduce updating the current total from "contained in" counts:
    var sum = 
      bags[bagName].fold(total, (val, bag) => count(bag['name'], val));
    
    seen[bagName] = true;
    //print('Return total for $bagName(counted): $sum');
    return sum+1;
  }

  static contains(String bagName, int total) {
    // things that are in a $bagName
    print('In $bagName');
    var found = false;
    var sum = 0;
    for(var entry in bags.entries) {
      for(var bag in entry.value) {
         if(bag['name'] == bagName) {
           found = true;
           print('Contains: ${entry.key}, ${bag['count']} times');
           print('Before ${entry.key} $total');
           var contained = contains(entry.key, total);
           sum += bag['count'] * contained;
           print('After ${entry.key} $total, $sum ( ${bag['count']} * $contained )');
         }
      }
    }
    total += sum + 1;

    if(!found) {
      print('Value of $bagName: 1');
      return 1;
    }

    print('Value of $bagName: $total');
    return total;
  }
}