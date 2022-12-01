class Day14 {
  static const dayFile = '2021/day14.txt';
  static List<String> input = [];
  static Map<String,String> templates = {};
 
  static handle(String line) {
    //print('INPUT: $line');
    if(input.length == 0) {
      input = line.split('');
    }
    var templateRE = RegExp(r'^(\w\w)\s->\s(\w)$');
    if(templateRE.hasMatch(line)) {
      var match = templateRE.firstMatch(line);
      templates[match.group(1)] =  match.group(2);
    }
  }

  static whenDone() {
    print(input);
    print(templates);
    var result1 = part1(input);
    print('Part1: $result1');
    // etoobig! Track pairs?
    Map<String, int> pairs = {};
    // dummy start, end:
    // List<String> amendedInput = ['_', ...input, '_'];
    for(var c = 1; c<input.length; c++) {
      var pair = [input[c-1], input[c]].join('');
      pairs[pair] = pairs.containsKey(pair) ? pairs[pair] + 1 : 1;
    }
    print(pairs);
    Map<String, int> counts = {};
    Map<String, int> newPairs = {};

    for(var i=0; i < 40; i++) {
      counts = {};
      newPairs = {};
      for(var p in pairs.keys) {
        var pCount = pairs[p];
        pairs[p] = 0;
        var subst = templates[p];
        var pSplit = p.split('');
        var p1 = pSplit[0] + subst;
        var p2 = subst + pSplit[1];
        newPairs[p1] = newPairs.containsKey(p1) ? newPairs[p1] + pCount :  pCount;
        newPairs[p2] = newPairs.containsKey(p2) ? newPairs[p2] + pCount : pCount;

        // keep count of each character:
        counts[subst] = counts.containsKey(subst) ? counts[subst] + pCount : pCount;
        counts[pSplit[0]] = counts.containsKey(pSplit[0]) ? counts[pSplit[0]] + pCount : pCount;
        // counts[pSplit[1]] = counts.containsKey(pSplit[1]) ? counts[pSplit[1]] + pCount : pCount;
      }
      pairs = newPairs;
    }
    print(pairs);
    counts[input.last]++;
    print(counts);
    var most = counts.values.reduce((val,ele) => val > ele ? val : ele);
    var least = counts.values.reduce((val,ele) => val < ele ? val : ele);
    print('Part 2: ${most-least}');
  }

  static part1(List<String> input) {
    Map<String,int> counts = {};
    for(var i =0; i <10; i++) {
      var copy = [];
      counts = {};
      for(var c = 1; c<input.length; c++) {
        var pair = [input[c-1], input[c]].join('');
        copy.add(input[c-1]);
        copy.add(templates[pair]);
        counts[input[c-1]] = counts.containsKey(input[c-1]) ? counts[input[c-1]] + 1 : 1;
        counts[templates[pair]] = counts.containsKey(templates[pair]) ? counts[templates[pair]] + 1 : 1;
      }
       counts[input.last] = counts.containsKey(input.last) ? counts[input.last] + 1 : 1;
       copy.add(input.last);
      //print(copy.join(''));
      input = List.from(copy);
    }
    print(input);
    print(counts);
    var most = counts.values.reduce((val,ele) => val > ele ? val : ele);
    var least = counts.values.reduce((val,ele) => val < ele ? val : ele);
    return most - least;
  }
} 