import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> program = [];
  Map<List<int>,String> map = {};
  Map<String,int> output = {'output':null};
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => program.add(int.parse(intstr)));
      var intcodeComputer = Intcode(program);
      int x=0; int minx = 0; int maxx = 0;
      int y=0; int miny = 0; int maxy = 0;
      map{[0,0]} = ' ';
      String nextLoc;
      // 1(north), 2(south), 3(west), 4 (east)
      List<int> dirs = [1,2,3,4];
      int dirIndex = 2;
      do {
        int newDirIndex;
        while(newDirIndex == null) {
          // decide direction:
          nextLoc = getXYIn(dirs[dirIndex], x, y);
          // null = havent been here before, go look:
          // space = nothing here
          // # = wall
          if(map{nextLoc} != null && map{nextLoc} == '#') {
            dirIndex = dirIndex < 3 ? dirIndex++ : 0;
          } else {
            newDirIndex = dirIndex;
          }
        }

        output = intcodeComputer.handle([dirs[dirIndex]], output['iJump'] ?? 0, output['relativeBase'] ?? 0);
        x = output['output'];
        if(x == null) break;
        game['$x,$y'] = tile;
      } while (output['output'] != null);
    },
    onDone: () {print(game.values.where((val) => val == 2).length); },
    onError: (e) { print(e.toString()); }
  );
}

List<int> getXYIn(int direction, List<int> loc) {
  if(direction == 3) {
    return [loc[0]-1,loc[1]];
  } else if(direction == 4) {
    return [loc[0]+1,loc[1]];
  } else if(direction == 1) {
    return [loc[0],loc[1]+1];
  } else if(direction == 2) {
    return [loc[0],loc[1]-1];
  } else {
    print('Unknown direction $direction');
  }
}

// given the known map, the current location, and the direction(s) we just went..
// try to go the same dir (return that dir if unknown
// if not "look" left and right (eg for west, look north/south
// all else fails, go back

// when we run this the next time, if we were going back just now, we should
// "look" left/right again?
int findNextMove(Map<List<int>,String> map, List<int> loc, List<int> prevDirIndex) {
  // 1(north), 2(south), 3(west), 4 (east)
  List<int> dirs = [3,1,4,2];
  // keep going in same direction?
  int dirIndex = prevDirIndex.last ?? 0;

  nextLoc = getXYIn(dirs[dirIndex], loc);
  // null = havent been here before, go look:
  // space = nothing here
  // # = wall
  if(map[nextLoc] != null && map[nextLoc] == '#') {
    // try left:
    int dirIndexLeft = dirIndex == 0 ? 3 : dirIndex-1;
    nextLoc = getXYIn(dirs[dirIndexLeft], loc);
  }
  if(map[nextLoc] != null && map[nextLoc] == '#') {
    // try right:
    int dirIndexRight = dirIndex == 3 ? 0 : dirIndex+1;
    nextLoc = getXYIn(dirs[dirIndexRight], loc);
  }
  if(map[nextLoc] != null && map[nextLoc] == '#') {
    // go back
    int dirIndexRight = dirIndex == 3 ? 0 : dirIndex+1;
    nextLoc = getXYIn(dirs[dirIndexRight], loc);
  }
  

  // Pass out the updated (next) location and the direction its in
  loc[0] = nextLoc[0];
  loc[1] = nextLoc[1];
  prevDirIndex.add(dirIndex);
  // do we need both dirIndex+dir? (assume calling code doesn't know the dirs
  // list)
  return dirs[dirIndex];
}
