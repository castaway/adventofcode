class Day11 {
  static var dayFile = '2020/day11_test.txt';
  
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
      newSeats = inputPeople(seats, 4, 1);
      // print(seats);
    }
    print('PART 1: ${countOccupied(seats)}');
    
    newSeats = inputPeople(seats2, 5, seats2.length);
    while(newSeats != null) {
      seats2 = newSeats;
      newSeats = inputPeople(seats2, 5, seats2.length);
      print(seats2);
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
        print('state for : $i, $j; $busy');
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
    print(changes);
    return newState;

  }
  
  static getOccupyState(int x, int y, List all, int dist) {
    var count = <int, bool>{};
    for(var i = 1; i <= dist; i++) {
      if(x > i-1 && y > i-1 && all[x-i][y-i] == '#') {
        count[1] = true;
      }
      if(y > i-1 && all[x][y-i] == '#') {
        count[2] = true;
      }
      if(x < all.length -i && y > i-1 && all[x+i][y-i] == '#') {
        print('$x, $y, $i: ${all[x+i]}');
        count[3] = true;
      }
      if(x > i-1 && all[x-i][y] == '#') {
        count[4] = true;
      }
      if(x< all.length -i && all[x+i][y] == '#') {
        count[5] = true;
      }
      if(x > i-1 && y < all[x].length-i && all[x-i][y+i] == '#') {
        count[6] = true;
      }
      if(y < all[x].length-i && all[x][y+i] == '#') {
        count[7] = true;
      }
      if(x < all.length-i && y < all[x].length-i && all[x+i][y+i] == '#') {
        count[8] = true;
      }
    }
    print(count);
    return count.entries.fold(0, (val, entry) => entry.value ? val+1 : val);
  }
  
  static countOccupied(List state) {
    return state.fold(0, (x, ele) {
      // print(ele);
      var cnt = x + ele.fold(0, (y, seat) => seat == '#' ? y+1 : y);
      print(cnt);
      return cnt;
      });
  }
}