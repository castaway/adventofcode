class Day17 {
  static var dayFile='2020/day17.txt';
  
  //static List<List<List<String>>> space = [[]];
  static List<ThreeD> space = [];
  static int lineCounter = 0;
  static handle(String line) {
    var inputs = line.split('');
    print('Inputs: $inputs');
    for(var i = 0; i < inputs.length; i++) {
      print('Vals: $i, $lineCounter, 0');
      var newObj = ThreeD(i, lineCounter, 0, inputs[i] == '#' ? true : false);
      //print('Pre: $newObj');
      assignNeighbours(newObj);
      print('Post: $newObj');
      space.add(newObj);

      var previousZ;
      for(var z=-6; z < 7; z++) {
        var skip = false;
        if(z == 0) {
          // continue;
          skip = true;
        }
        
        var newZ = ThreeD(newObj.x, newObj.y, z, false);
        
        assignNeighbours(newZ);

        if(z == newObj.z -1) {
          newObj.neighbours['down'] = newZ;
          newZ.neighbours['up'] = newObj;
          previousZ = null;
          // why does this "continue" the outer i-loop!?
          //continue;
          skip = true;
        }
        if(skip) {
          continue;
        }
        if(z == newObj.z +1) {
          newObj.neighbours['up'] = newZ;
          newZ.neighbours['down'] = newObj;
        }
        if(previousZ != null) {
          newZ.neighbours['down'] = previousZ;
          previousZ.neighbours['up'] = newZ;
          //print('previous: ${previousZ.neighbours}');
        }
        previousZ = newZ;
        print(newZ);
        print(newZ.neighbours);
        //print(newZ.alive());
        
        space.add(newZ);
        
      }
      previousZ = null;
    }

    lineCounter++;
  }
  
  static whenDone() {
    //print(space);

    // neighbours = 8 on "this" layer, 9 on layer "above", 9 on layer "below"
    // if active + 2or3 neighbours active, dont change
    // if inactive + exactly 3 active, become active

    // 6 boot cycles
    for (var i = 0; i < 6; i++) {
      // on 0, only 1 z plane exists.

    }
  }

  static assignNeighbours(ThreeD currentObj) {
    //print('AN input: $currentObj');
    
    var northObj;
    if(currentObj.y > 0) {
      // The point directly "north" of this one on the same layer
      northObj = space.firstWhere((point) => point.x == currentObj.x && point.y == currentObj.y - 1 && point.z == currentObj.z);
      currentObj.neighbours['north'] = northObj;
      if(northObj.neighbours.containsKey('west')) {
        currentObj.neighbours['northwest'] = northObj.neighbours['west'];
      }
      if(northObj.neighbours.containsKey('east')) {
        currentObj.neighbours['northeast'] = northObj.neighbours['east'];
      }
      northObj.neighbours['south'] = currentObj;
    }
    
    if( currentObj.x > 0) {
      // The point directly "west" of this one on the same layer
      var westObj = space.firstWhere((point) => point.x == currentObj.x - 1 && point.y == currentObj.y && point.z == currentObj.z);

      currentObj.neighbours['west'] = westObj;
      if(northObj != null) {
        northObj.neighbours['southwest'] = westObj;
      }
      westObj.neighbours['east'] = currentObj;
      if(westObj.neighbours['north'] != null) {
        westObj.neighbours['north'].neighbours['southeast'] = currentObj;
      }
    }
      
  }

}

class ThreeD {
  final int x;
  final int y;
  final int z;

  bool value;

  // Missing keys if: we're in a corner!
  Map<String, ThreeD> neighbours = {};
  ThreeD(this.x, this.y, this.z, this.value);

  int alive() {
    return neighbours.entries.fold(0, 
      (val, entry) => entry.value != null && entry.value.value ? val + 1 : val);
  }

  ThreeD cloneAt(int newZ) {
    var newThing = ThreeD(x, y, newZ, value);
    newThing.neighbours = Map.from(this.neighbours);
    return newThing;
  }

  String toString() {
    return '$x, $y, $z ($value)';
  }
}