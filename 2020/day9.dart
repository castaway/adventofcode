import 'package:trotter/trotter.dart';

class Day9 {
  static var dayFile = '2020/day9.txt';
  
  static int currentIndex = 0;
  static List<int> input = [];
  static handle (String line) {
    //print(line);
    input.add(int.parse(line));
  }
  
  static whenDone() {
    var found  = 0;
    while(currentIndex < input.length - 25) {
      //print('${input.sublist(currentIndex, currentIndex+30)}');
      List<int> top25 = input.sublist(currentIndex, currentIndex+25);
      var checkNum = input[currentIndex+25];
      //print('$top25, $checkNum');
      if(!isValid(top25, checkNum)) {
        found = checkNum;
        break;
      }
      currentIndex++;
    }
    
    print('PART 1: $found');
    // set of contiguous numbers that add up to $found
    List<int> toSum = [];
    var checkSum = 0;
    while(checkSum != found) {
      toSum = [];
      for(var i = currentIndex; i >= 0; i--) {
        checkSum = toSum.length > 2 ? toSum.reduce((a,b) => a+b) : 0;
        if(checkSum > found) {
          currentIndex--;
          break;
        }
        if(checkSum == found) {
          break;
        }
        toSum.add(input[i]);
      }
    }
    toSum.sort();
    print('PART 2: ${toSum[0] + toSum.last}');
  }
  
  
  
  static bool isValid(List<int> checkList, int checkNum) {
    //print('$checkList, $checkNum');
    final perms = Permutations(2, checkList);
    for (final perm in perms()) {
      if(perm[0]+perm[1] == checkNum) {
        return true;
      }
    }
    return false;
  }
}