import 'dart:convert';

class Advent {
  static const dayFile = '2022/day7.txt';
  static List<String> input = [];
  static List tree = [];
  // static String pwd = '';
  // static int depth = 0;
  // List<file,dir>[ Map<file>{}, List<dir>[]]

  static Map<String,int> dirSize = {};

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    final cdRE = RegExp(r'^\$\scd\s([\w\.\/]+)$');
    //final lsRE = RegExp(r'^\$\sls$');
    //final dirRE = RegExp(r'^dir\s(\w+)$');
    final fileRE = RegExp(r'^(\d+)\s([\w\.]+)$');
    
    if(cdRE.hasMatch(line)) {
      var match = cdRE.firstMatch(line);
      if(match.group(1) == '/') {
        print('Top level');
        tree.add('/');
        // depth = 0;
      } else if(match.group(1) == '..') {
        // depth = depth - 1;
        print('Up dir');
        tree.removeLast();
      } else {
        var subdir = match.group(1);
        print('Into $subdir');
        tree.add(subdir);
        // pwd = tree.join('/');
        // depth = depth + 1;
      }
      print(tree);
    }
    if(fileRE.hasMatch(line)) {
      var match = fileRE.firstMatch(line);
      var size = int.parse(match.group(1));
      for (var i = 1; i <= tree.length; i++) {
        var d = tree.sublist(0, i).join('/');
        print('Size add $d');
        if(dirSize.containsKey(d)) { 
          dirSize[d] = dirSize[d] + size;
        } else {
          dirSize[d] = size;
        }
      }
    }
  }

  static whenDone() {
    var p1 = 0;
    var totalSize = 0;
    var diskSize = 70000000;
    var freeNeeded = 30000000;
    //print(tree);
    //print(dirSize);
    for (var e in dirSize.entries) {
      if(e.value <= 100000) {
        p1 += e.value;
      }
    }
    //var toFind = dirSize['/'] - freeNeeded;
    var currentFree = diskSize - dirSize['/'];
    var toFind = freeNeeded-currentFree;
    var p2 = dirSize.entries.where((e) => e.value >= toFind).toList();
    print(p2);
    p2.sort((a, b) => a.value.compareTo(b.value));
    print('Need to find: ${dirSize['/']  - freeNeeded}');
    print('Part 1: $p1');
    print('Part 2: ${p2.first}');

  }
}