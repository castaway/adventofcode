class Advent {
  static const dayFile = '2023/day2.txt';
  static List<Map> inputs = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    // Game 83: 6 blue, 5 green; 2 green, 12 blue; 1 red, 2 green, 6 blue
    final game_start_RE = RegExp(r'Game (\d+): (.*)');
    RegExpMatch id_match = game_start_RE.firstMatch(line);
    final int id = int.parse(id_match[1]);
    print("Id: $id");
    final rest = id_match[2];
    final games = rest.split(RegExp(r'; '));
    final game_RE = RegExp(r'(\d+) (blue|green|red)');
    Set sets = {};
    for(var g in games) {
      var cubes = {};
      Iterable<RegExpMatch> matches = game_RE.allMatches(g);
      for (final m in matches) {
        cubes[m[2]] = int.parse(m[1]);
      }
      sets.add(cubes);
    }
    var game = {
      'id': id,
      'cubes': sets,
    };
    print(game);
    inputs.add(game);
  }

  static whenDone() {
    int red = 12;
    int green = 13;
    int blue = 14;
    // What is the sum of the IDs of those games?
    var total = 0;
    var possible = [0];
    var minCubes = [];
    var minPowers = [];
    for(final game in inputs) {
      if(game['cubes'].every((s) => (s.containsKey('red') ? s['red'] <= red : true) &&
                             (s.containsKey('blue') ? s['blue'] <= blue : true) &&
                             (s.containsKey('green') ? s['green'] <= green : true))) {
        print("Game ${game['id']} wins");
         possible.add(game['id']);
      }

      minCubes.add({'red':0, 'blue':0, 'green':0});
      game['cubes'].forEach((cubes) {
      if(cubes.containsKey('red') && cubes['red'] > minCubes.last['red']) {
        minCubes.last['red'] = cubes['red'];
      }
        
      if(cubes.containsKey('blue') && cubes['blue'] > minCubes.last['blue']) {
        minCubes.last['blue'] = cubes['blue'];
      }
        
      if(cubes.containsKey('green') && cubes['green'] > minCubes.last['green']) {
        minCubes.last['green'] = cubes['green'];
      }
      });
      print(minCubes.last);
      minPowers.add(minCubes.last['red'] * minCubes.last['blue'] * minCubes.last['green']);
    }
    total = possible.reduce((val,ele) => val + ele);
    // P2 - minimum per colour to make the games work (aka max of each colour listed)
    var sumPowers = minPowers.reduce((val, ele) => val + ele);    
    print("Part 1: $total");
    print("Part 2: $sumPowers");

  }
}