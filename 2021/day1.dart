class Day1 {
  static const dayFile = 'day1.txt';
  static List<int> inputs = [];
  static List<int> windows = [0,0,0];
  static List<int> winPos = [0,1,2];
  static var index = -1; 

  static handle(String line) {
    // print('INPUT: $line');
    index++;
    int newNum = int.parse(line);
    inputs.add(newNum);
    if(!winPos.contains(index)) {
      winPos.removeAt(0);
      winPos.add(index);
      windows.add(0);
    }
    print('Adding at: $index, $winPos, $windows');  
    windows[index]+= newNum;
    if(index > 0) {
      windows[index - 1] += newNum;
    }
    if(index > 1) {
      windows[index - 2] += newNum;
    }
    print('Adding at: $index, $winPos, $windows');  
  }
    static whenDone() {
      int increased = 0;
      int prev = -1;
      for (var val in inputs) {
        if(prev > 0 && val > prev) {
          increased++;
        }
        prev = val;
      }
      print('Count part 1: $increased');

      print(inputs);
      print(windows);
      increased = 0;
      prev = -1;
      for (var val in windows) {
        if(prev > 0 && val > prev) {
          increased++;
        }
        prev = val;
      }
      print('Count part 2: $increased');
    }

  }
