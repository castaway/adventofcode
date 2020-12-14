class Day14 {
  static var dayFile = '2020/day14_test.txt';

  static List<int> memory = [];
  static var currentMask;
  static handle(String line) {
    var maskRE = RegExp(r'^mask = (\w+)$');
    if(maskRE.hasMatch(line)) {
      var match = maskRE.firstMatch(line);
      currentMask = match.group(1).split('').reversed;
    }
    var memRE = RegExp(r'^mem\[(\d+)\] = (\d+)$');
    if(memRE.hasMatch(line)) {
      var match = memRE.firstMatch(line);
      int thisNum = match.group(2);

      for(var i = 0; i < currentMask.length; i++) {
        if(currentMask[i] == 'X') {
          continue;
        }
        thisNum = thisNum.setBit(i, currentMask[i]);
      }
      memory[match.group(1)] = thisNum;
    }
  }

  static whenDone() {
    print(memory);
  }
}