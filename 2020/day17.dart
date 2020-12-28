class Day17 {
  static var dayFile='2020/day17_test.txt';
  
  //static List<List<List<String>>> space = [[]];
  static Set<ThreeD> space = <ThreeD>{};
  static int lineCounter = 0;
  static int lineWidth;
  static handle(String line) {
    var inputs = line.split('');
    //print('Inputs: $inputs');
    lineWidth ??= inputs.length;
    for(var i = 0; i < inputs.length; i++) {
      //print('Vals: $i, $lineCounter, 0');
      var newObj = ThreeD(i, lineCounter, 0, inputs[i] == '#' ? true : false);
      //print('Pre: $newObj');
      // maxY unknown at this point:
      space.add(newObj);
      assignNeighbours(newObj, -1, -1);
      //print('Post: $newObj');
    }
      //var previousZ;
      /* 
      for(var z=-6; z < 7; z++) {
        var newZ;
        if(z != 0) {
          newZ = ThreeD(newObj.x, newObj.y, z, false);
          space.add(newZ);
        } else {
          newZ = newObj;
        }

        assignNeighbours(newZ);
        
        if(z == newObj.z -1) {
          newObj.neighbours['down'] = newZ;
          newZ.neighbours['up'] = newObj;
          previousZ = null;
          // why does this "continue" the outer i-loop!?
          //continue;
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
        // previousZ = newZ;
        //print(newZ);
        //print(newZ.neighbours);
        //print(newZ.alive());        
      } */
      //previousZ = null;
    // }

    lineCounter++;
  }
  
  static whenDone() {
    // edge cases for last row:
    printSpace(0);
    var edges = space.where((point) => point.x == lineWidth -1 ||  point.y == lineCounter-1).toList();
    for (var point in edges) {
      print('Edge assign: $point');
      assignNeighbours(point, lineWidth - 1, lineCounter - 1);
    }
    // print(space);
    printSpace(0);

    // neighbours = 8 on "this" layer, 9 on layer "above", 9 on layer "below"
    // if active + 2or3 neighbours active, dont change
    // if inactive + exactly 3 active, become active

    // ARGHH it needs to get wider in X + Y too!
    // 6 boot cycles
    
    for (var i = 0; i < 2; i++) {
      for (var point in space) {
        print('$point has ${point.alive()}');
        if(point.value && point.alive() == 2 || point.alive() == 3) {
          point.value = false;
        } else if(!point.value && point.alive() == 3){
          point.value = true;
        }
      }
      print('Cycle: $i');
      printSpace(-1);
      printSpace(0);
      printSpace(1);
    }
    
    var active = space.fold(0, (val, point) => point.value ? val + 1 : val);
    print('PART 1: $active');
  }

  // we're looping top to bottom, left to right
  // so "north" and "west" will exist after 0
  // add empty items on the edges and above/below
  // also add on "east" and "south" edges when we reach them
  static assignNeighbours(ThreeD currentObj, int maxX, int maxY) {
    //print('AN input: $currentObj');
    
    var northObj;
      // The point directly "north" of this one on the same layer
    northObj = space.firstWhere((point) => point.x == currentObj.x && point.y == currentObj.y - 1 && point.z == currentObj.z, orElse: () => ThreeD(currentObj.x, currentObj.y - 1, currentObj.z, false ));
    space.add(northObj);
    
    currentObj.neighbours['north'] ??= northObj;
/*
    var northwestObj = northObj.neighbours.containsKey('west') 
    ? northObj.neighbours['west'] 
    : space.firstWhere((point) => point.x == currentObj.x - 1 && point.y == currentObj.y - 1 && point.z == currentObj.z, orElse: () => ThreeD(currentObj. x -1 , currentObj.y - 1, currentObj.z, false));
    space.add(northwestObj);
    northObj.neighbours['west'] ??= northwestObj;
    currentObj.neighbours['northwest'] = northwestObj;

    if(northObj.neighbours.containsKey('east')) {
      currentObj.neighbours['northeast'] ??= northObj.neighbours['east'];
    }
    */
    northObj.neighbours['south'] ??= currentObj;
    
    var westObj;
    // The point directly "west" of this one on the same layer
    westObj = space.firstWhere((point) => point.x == currentObj.x - 1 && point.y == currentObj.y && point.z == currentObj.z, orElse: () => ThreeD(currentObj.x - 1, currentObj.y, currentObj.z, false ));
    //print('West: $westObj');
    space.add(westObj);

    currentObj.neighbours['west'] ??= westObj;
    northObj.neighbours['southwest'] ??= westObj;
    
    westObj.neighbours['east'] ??= currentObj;
    if(westObj.neighbours.containsKey('north')) {
      westObj.neighbours['north'].neighbours['southeast'] = currentObj;
    }
    
    var lowerObj = space.firstWhere((point) => point.x == currentObj.x && point.y == currentObj.y && point.z == currentObj.z - 1, orElse: () => ThreeD(currentObj.x, currentObj.y, currentObj.z - 1, false));
    space.add(lowerObj);

    currentObj.neighbours['down'] ??= lowerObj;
    lowerObj.neighbours['up'] ??= currentObj;

    var higherObj = space.firstWhere((point) => point.x == currentObj.x && point.y == currentObj.y && point.z == currentObj.z + 1, orElse: () => ThreeD(currentObj.x, currentObj.y, currentObj.z + 1, false));
    space.add(higherObj);

    currentObj.neighbours['up'] ??= higherObj;
    higherObj.neighbours['down'] ??= currentObj;

    // add empty east items:
    if(currentObj.x == maxX) {
      var eastObj = space.firstWhere((point) => point.x == currentObj.x + 1 && point.y == currentObj.y && point.z == currentObj.z, orElse: () => ThreeD(currentObj.x + 1, currentObj.y, currentObj.z, false));
      space.add(eastObj);
      //print('East: $eastObj');
      // recall so that we get north, lower + higher objs
      assignNeighbours(eastObj, maxX, maxY);
    }
    if(currentObj.y == maxX) {
      var southObj = space.firstWhere((point) => point.x == currentObj.x && point.y == currentObj.y + 1 && point.z == currentObj.z, orElse: () => ThreeD(currentObj.x, currentObj.y + 1, currentObj.z, false));
      space.add(southObj);
      assignNeighbours(southObj, maxX, maxY);
    }
  }

  // Add external edge of empty cells
  static expandLayers() {
  }

  static printSpace(int z) {
    print(space.length);
    var layer = space.where((point) => point.z == z);
    var lowestCol = layer.fold(0, (val, entry) => entry.y < val ? entry.y : val);
    var colNum = lowestCol;;
    var col = layer.where((point) => point.y == colNum).toList();
    while(col.length > 0) {
       col.sort((a, b) => a.x.compareTo(b.x));
       // print(col);
       var text = col.map((point) => point.value ? '#' : '.');
       print(text.join(''));
       //print(col.toList().sort((a, b) => a.x.compareTo(b.x)).map((point) => point.value ? '#' : '.').join(''));
       colNum++;
       col = layer.where((point) => point.y == colNum).toList();
    }
    var active = space.fold(0, (val, point) => point.value ? val + 1 : val);
    print('Active: $active');
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