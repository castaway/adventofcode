class Day12 {
  static const dayFile = '2021/day12_test.txt';
  static Map<String,List<String>> input = {};
  
  static handle(String line) {
    //print('INPUT: $line');
    var pair = line.split('-');
    if(!input.containsKey(pair[0])) {
      input[pair[0]] = [];
    }
    if(!input.containsKey(pair[1])) {
      input[pair[1]] = [];
    }
    input[pair[0]].add(pair[1]);
    input[pair[1]].add(pair[0]);
  }

  static whenDone() {
    print(input);
    // unique paths that visit small caves at most once?
    // recurse?
    List<List<String>> paths = [];
    input['start'].forEach((p) {
      paths.add(['start']);
      checkPath(p, paths);
    });
  }

  static List<List<String>> checkPath(String fromCave, List<List<String>> paths) {
    if(fromCave == 'end') {
      print('end: $paths');
      paths.last.add(fromCave);
      return paths;
    }
    if(isSmall(fromCave) && paths.last.contains(fromCave)) {
      print('looped in small cave');
      return [];
    }
    // List<String> extPath = [fromCave];
    print('recursing: $fromCave -> $paths (${input[fromCave]})');

    for(var p in input[fromCave]) {
      if(p != paths.last.last) {
        print(p);
        paths.last.add(fromCave);
      }
    }
//    return input[fromCave].map((p) {
      // new path for each exit from here (but not the one we just came from?
//      if(p != paths.last.last) {
//        paths.add(List.from(paths.last));
//        checkPath(p, paths);
//        return paths;
//      }
//    }).toList();

  }

  static bool isSmall(String cave) {
    var comp = cave;
    comp.toLowerCase();
    return comp == cave;
  }
} 