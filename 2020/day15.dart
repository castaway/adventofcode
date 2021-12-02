class Day15 {
  static var dayFile='2020/day15.txt';

  static Map<int, List<int>> numbers = {};
  static int lastNum = -1;
  static int nextIt = 0;
  static handle(String line) {
    var ints = line.split(',');
    for(var i=0; i < ints.length; i++) {
      var val = int.parse(ints[i]);
      //print(val);
      numbers[val] = [];
      numbers[val].add(i);
      lastNum = val;
      nextIt = i;
    }
  }

  static whenDone() {
    print(numbers);
    for(var i = nextIt+1; i < 2020; i++) {
      iterate(i);
      nextIt=i;
      print('$i, $lastNum');
    }
    // print(numbers);
    print('PART 1: $lastNum');
    
    for(var i = nextIt+1; i <  30000000; i++) {
      iterate(i);
      //print('$i, $lastNum');
    }
    
    print('PART 2: $lastNum');
  }

  static iterate(int iteration) {
    // did we see this before?
    if(numbers[lastNum].length == 1) {
      lastNum = 0;
    } else {
      var numList = numbers[lastNum];
      lastNum = numList.last - numList[numList.length-2];
    }
    if(!numbers.containsKey(lastNum)) {
      numbers[lastNum] = [];
    }
    numbers[lastNum].add(iteration);
  }
}
