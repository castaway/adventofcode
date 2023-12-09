import 'dart:math';
class Advent {
  static const dayFile = '2023/day9.txt';
  static List<List<int>> inputs = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    inputs.add(line.split(RegExp(r'\s+')).map((n) => int.parse(n)).toList());
  }

  static whenDone() {
    // determine list of input line differences, repeat until 0, determine next value
    var total = 0;
    var p2total = 0;
    for(var history in inputs) {
      //print(history);
      var nextVal = getNextVal(history) + history.last;
      total += nextVal;
      
      //print(history);
      var prevVal = history.first - getPrevVal(history);
      //print(prevVal);
      p2total += prevVal;
    }
    print("Part 1: $total");
    print("Part 2: $p2total");

  }
}
/*
static foo(x) {
  if (x==0) {
    return 1;
  }
  return foo(x-1)+1
}
*/
  // generate new sequence of number differences
  // return new entry of last item plus difference
  getNextVal(List<int> sequence) {
    if(sequence.every((n) => n == 0)) {
      return sequence.last + 0;
    }
    List<int> newSeq = [];
    for(var i=0; i < sequence.length - 1; i++) {
      newSeq.add(sequence[i+1] - sequence[i]);
    }
    //print(newSeq);
    return getNextVal(newSeq) + newSeq.last;
  }

getPrevVal(List<int> sequence) {
  print(sequence);
  if(sequence.every((n) => n == 0)) {
    //print("New val: ${sequence.first + 0}");
    return 0 - sequence.first;
  }
  List<int> newSeq = [];
  for(var i=0; i < sequence.length - 1; i++) {
    newSeq.add(sequence[i+1] - sequence[i]);
  }
  var nextVal = newSeq.first - getPrevVal(newSeq);
  print(nextVal);
  return(nextVal);
}

/*
5  10  13  16  21  30  45
  5   3   3   5   9  15
   -2   0   2   4   6
      2   2   2   2
        0   0   0
*/

