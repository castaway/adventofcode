class Day20 {
  static var dayFile = '2020/day20.txt';

  // id => top, right, bottom, left
  static Map<int, List<String>> tiles = {};
  static int currentId = 0;
  static List<String> currentTile = [];
  static handle(String line) {
    var idRegExp = RegExp(r'^Tile\s(\d+):$');
    if(idRegExp.hasMatch(line)) {
      if(currentId != 0) {
        tiles[currentId] = currentTile;
        currentTile = [];
      }
      var match = idRegExp.firstMatch(line);
      currentId = int.parse(match.group(1));
      return;
    }
    var pixels = line.split('');
    // ignoring empty lines
    if(pixels.length > 0) {
      // first line is top if not set
      if(currentTile.length == 0) {
        currentTile.add(line);
        currentTile.add(pixels.last);
        currentTile.add(line);
        currentTile.add(pixels[0]);
      } else {
        currentTile[1] = '${currentTile[1]}${pixels.last}';
        currentTile[3] = '${pixels[0]}${currentTile[3]}';
        currentTile[2] = line;
      }
    }
  }

  static whenDone() {
    tiles[currentId] = currentTile;
    print(tiles);

    // find pairs:
    Set<String> pairs = <String>{};
    Set<String> allKeys = <String>{};
    for(var tile in tiles.entries) {
      for(var other in tiles.entries) {
        if(tile.key == other.key) {
          continue;
        }
        for(var e=0; e < tile.value.length; e++) {
          var edge = tile.value[e];
          var rEdge = edge.split('').reversed.toList().join('');
          var eKey = '${tile.key}_$e';
          allKeys.add(eKey);
          if(pairs.contains(eKey)) {
            // print('Already got $eKey');
            continue;
          }
          for(var oe = 0; oe < other.value.length; oe++) {
            var oeKey = '${other.key}_$oe';
            allKeys.add(oeKey);
            var otheredge = other.value[oe];
            var rOtherEdge = otheredge.split('').reversed.toList().join('');
            if(edge == otheredge || edge == rOtherEdge || rEdge == otheredge || rEdge == rOtherEdge) {
              pairs.add(eKey);
              pairs.add(oeKey);
            }
          }
        }
      }
    }

    print(pairs);
    var outside = allKeys.difference(pairs).toList();
    outside.sort();
    // find the id pairs (those will be the corners)
    var prevKey = '';
    var corners = [];
    for(var key in outside) {
      var idIndex = key.split('_');
      if(prevKey == idIndex[0]) {
        // found a corner
        corners.add(int.parse(idIndex[0]));
      }
      prevKey = idIndex[0];
    }

    print('PART 1: ${corners.fold(1, (val, entry) => val * entry)}');
  }
}