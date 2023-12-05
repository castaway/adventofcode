import 'dart:math';
class Advent {
  static const dayFile = '2023/day5_test.txt';
  static List<int> seeds = [];
  static List<String> maps = [];
  static Map<String,List<Map<String, int>>> mappings = {};
  static String mapType = '';

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    // seeds: 79 14 55 13
    // seed-to-soil map:
    // 50 98 2
    // 52 50 48
    final seedsRE = RegExp(r'seeds:\s+([\d\s]+)');
    final mapRE   = RegExp(r'(\w+)-to-(\w+) map:');
    final rangesRE = RegExp(r'(\d+)\s+(\d+)\s+(\d+)');
    if(seedsRE.hasMatch(line)) {
      print('It matches');
      final sMatch = seedsRE.firstMatch(line);
      seeds.addAll(sMatch[1].split(RegExp(r' ')).map((s) => int.parse(s)).toList());
      print(seeds);
      maps.add('seeds');
      return;
    }

    if(mapRE.hasMatch(line)) {
      var mMatch = mapRE.firstMatch(line);
      // ended previous mapType if any:
      if(mapType.length > 0) {
        maps.add(mapType);
      }
      // start new one
      mapType = mMatch[2];
      mappings[maps.last] = [];
      return;
    }

    if(rangesRE.hasMatch(line)) {
      var rMatch = rangesRE.firstMatch(line);
      // X  Y range
      // seed => {'start': X, 'soil': Y, 'range': R}
      mappings[maps.last].add({
        'next': int.parse(rMatch[1]),
        'start': int.parse(rMatch[2]),
        'range': int.parse(rMatch[3])
        });
      print(mappings);
    }
  }

  static whenDone() {
    // add last mapType.. (hopefully location!)
    maps.add(mapType);
    print(maps);
    //Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.
    //Seed 14, soil 14, fertilizer 53, water 49, light 42, temperature 42, humidity 43, location 43.
    //Seed 55, soil 57, fertilizer 57, water 53, light 46, temperature 82, humidity 82, location 86.
    //Seed 13, soil 13, fertilizer 52, water 41, light 34, temperature 34, humidity 35, location 35.

    List<int> locations = [];
    // lowest location needed.. ?
    // loop over seeds, and maps:
    for(var seed in seeds) {
      var currentVal = seed;
      for(var c=0; c < maps.length - 1; c++) {
        var category = maps[c];
        final mapping = mappings[category];
        var matched = false;
        for(var range in mapping) {
          // if in range convert, else keep value
          //print("Checking: $currentVal, ${range['start']}, ${range['range']}");
          if(!matched && currentVal >= range['start'] && currentVal <= range['start'] + range['range'] - 1) {
            currentVal = range['next'] + currentVal - range['start'];
            matched = true;
            //print("Yes $currentVal");
          }
        }
        print("From: $seed to ${maps[c+1]} is $currentVal");
      }
      locations.add(currentVal);
    }
    var lowest = locations.reduce((val, ele) => ele < val ? ele : val);
    print("Part 1: $lowest");
    //print("Part 2: $cardTotal");

  }
}
