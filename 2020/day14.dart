import 'package:binary/binary.dart';

class Day14 {
  static var dayFile = '2020/day14.txt';

  static Map<int,int> memory = {};
  static Map<int,int> memorypt2 = {};
  static var currentMask;
  static handle(String line) {
    var maskRE = RegExp(r'^mask = (\w+)$');
    if(maskRE.hasMatch(line)) {
      var match = maskRE.firstMatch(line);
      currentMask = match.group(1).split('').reversed.toList();
    }
    var memRE = RegExp(r'^mem\[(\d+)\] = (\d+)$');
    if(memRE.hasMatch(line)) {
      var match = memRE.firstMatch(line);
      int thisNum = int.parse(match.group(2));

      for(var i = 0; i < currentMask.length; i++) {
        if(currentMask[i] == '1') {
          thisNum = thisNum.setBit(i);
        } else if(currentMask[i] == '0') {
          thisNum = thisNum.clearBit(i);
        }
      }
      memory[int.parse(match.group(1))] = thisNum;
    }
  }

  static whenDone() {
    print(memory);
    var sum = memory.entries.fold(0, (val, entry) => val + entry.value);
    print('PART 1: $sum');
  }
}
