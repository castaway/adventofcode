class Day11 {
  static var dayFile = '2020/day11.txt';
  
  static List<List<String>> seats = [];
  static List<List<String>> seats2 = [];
  static handle(String line) {
    var row = line.split('');
    seats.add(row);
    seats2.add(List.from(row));
  }
  
  static whenDone() {
    // simultaneously: 
    // if seat is empty + all 8 around also empty, occupy
    // if seat is occupied and 4+ around occupied, empty

    print(seats);
    var newSeats = inputPeople(seats, 4, 1);
    while(newSeats != null) {
      seats = newSeats;
      //print(seats);
      newSeats = inputPeople(seats, 4, 1);
    }
    print('PART 1: ${countOccupied(seats)}');
    
    print(seats2);
    
    newSeats = inputPeople(seats2, 5, seats2.length);
    while(newSeats != null) {
      seats2 = newSeats;
      //print(seats2);
      newSeats = inputPeople(seats2, 5, seats2.length);
    }
    print(seats2);
    print('PART 2: ${countOccupied(seats2)}');
  
  }
  
  static inputPeople(List state, int busyTotal, int distCheck) {
    var changes = 0;
    List<List<String>> newState = [];
    for(var i=0; i < state.length; i++) {
      newState.add([]);
      for(var j=0; j < state[i].length; j++) {
        var busy = getOccupyState(i, j, state, distCheck);
        //print('state for : $i, $j; $busy');
        if(busy == 0 && state[i][j] == 'L') {
          newState[i].add('#');
          changes++;
        }
        else if(busy >= busyTotal && state[i][j] == '#') {
          newState[i].add('L');
          changes++;
        } else {
          newState[i].add(state[i][j]);
        }
      }
    }
    if(changes == 0) {
      print('Ended');
      return null;
    }
    print('Changed: $changes');
    return newState;

  }
  
  static getOccupyState(int x, int y, List all, int dist) {
    var visible = <int, String>{};
    for(var i = 1; i <= dist; i++) {
      if(x > i-1 && y > i-1 && all[x-i][y-i] != '.' && visible[1] == null) {
         visible[1] = all[x-i][y-i];
      }
      if(y > i-1 && all[x][y-i] != '.' && visible[2] == null) {
        visible[2] = all[x][y-i];
      }
      if(x < all.length -i && y > i-1 && all[x+i][y-i] != '.' && visible[3] == null) {
        visible[3] = all[x+i][y-i];
      }
      if(x > i-1 && all[x-i][y] != '.' && visible[4] == null) {
        visible[4] = all[x-i][y];
      }
      if(x< all.length -i && all[x+i][y] != '.' && visible[5] == null) {
        visible[5] = all[x+i][y];
      }
      if(x > i-1 && y < all[x].length-i && all[x-i][y+i] != '.' && visible[6] == null) {
        visible[6] = all[x-i][y+i];
      }
      if(y < all[x].length-i && all[x][y+i] != '.' && visible[7] == null) {
        visible[7] = all[x][y+i];
      }
      if(x < all.length-i && y < all[x].length-i && all[x+i][y+i] != '.' && visible[8] == null) {
        visible[8] = all[x+i][y+i];
      }
    }
    //print(visible);
    return visible.entries.fold(0, (val, entry) => entry.value == '#' ? val+1 : val);
  }
  
  static countOccupied(List state) {
    return state.fold(0, (x, ele) {
      // print(ele);
      var cnt = x + ele.fold(0, (y, seat) => seat == '#' ? y+1 : y);
      //print(cnt);
      return cnt;
      });
  }
}