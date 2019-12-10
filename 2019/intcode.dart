class Intcode {
  List<int> nums;
  List<int> inputs;
  int iJump;
  // mode 2's relative base
  int relativeBase;

  Intcode(this.nums, this.inputs, [this.relativeBase = 0, this.iJump = 0]);

  Map<String,int> handle() {
    // ugly hack: dart doesn't have unshift, only removeLast (pop)
    inputs = inputs.reversed.toList();
    print('INPUTS: $inputs');
    // Operation is the first value in each program
    // Ops were all length 4 in day 2, now length varies
    // Opcode value length also varies: could be 4 (1101 etc), 1 or 2 (99)
    Map<int,int> opLengths = {1:4,2:4,3:2,4:2,5:3,6:3,7:4,8:4,9:2,99:0};
    // Current operation:
    int op=0;
    // How many input values does current operation use (including itself)
    int opLen;
    // Where is the next instruction
    int i=iJump;
    while (op != 99) {
      List<int> opWithModes = nums[i].toString().split('').map((val) => int.parse(val)).toList();
      op = opWithModes.removeLast();
      // Well this is ugly.. most op codes are 1 digit (or 0-padded) except 99
      if(opWithModes.length > 0 && opWithModes.removeLast() == 9) {
        op = 99;
      }
      opLen = opLengths[op];
      int iJump = i+opLen;
      print('original: ${nums.sublist(i,i+opLen)}');
      // opmodes are reversed: last position is the mode of the first op parameter etc
      // Add 0 for the opcode (just makes the mode param args match the op param args later)
      opWithModes.add(0);
      // if we have none or any are missing, they default to 0 (param mode)
      // -1 on len as the op param is 2 digits    
      while(opWithModes.length < opLen) {
        opWithModes.insert(0, 0);
      }
      // Now we've got just our modes, in the same order as our parameters (as integers)
      List<int> opModes = opWithModes.reversed.toList();

      if(op == 99) break;

      // Outout locations are never immediate
      // 1 = add values and store
      if(op == 1) {
        var arg1 = nums[i+1];
        var arg2 = nums[i+2];
        var out  = nums[i+3];

        storeValueWithMode(
          numWithMode(arg1, opModes[1]) + numWithMode(arg2, opModes[2]),
          out, opModes[3]);
      }
      // 2 = multiply values and store
      if(op == 2) {
        var arg1 = nums[i+1];
        var arg2 = nums[i+2];
        var out  = nums[i+3];
        storeValueWithMode(
          numWithMode(arg1, opModes[1]) * numWithMode(arg2, opModes[2]),
          out, opModes[3]);
      }
      // 3 = input/set and external value
      if(op == 3) {
        var out  = getValue(i+1);
        storeValueWithMode(inputs.removeLast(), out, opModes[1]);
      }
      // 4 = print out a value (is this ever immediate?)
      if(op == 4) {
        var out = getValue(i+1);
        var output = numWithMode(out, opModes[1]);
        print('OUTPUT: $output');
        return {'output':output, 'iJump': iJump};
      }
      // 5 = jump if param non-zero
      if(op == 5) {
        var arg1 = getValue(i+1);
        var out = getValue(i+2);
        if(numWithMode(arg1, opModes[1]) != 0) {
          iJump = numWithMode(out, opModes[2]);
        }
      }
      // 6 = jump if param zero
      if(op == 6) {
        var arg1 = getValue(i+1);
        var out = getValue(i+2);
        if(numWithMode(arg1, opModes[1]) == 0) {
          iJump = numWithMode(out, opModes[2]);
        }
      }
      // 7 = arg1 less than arg2, store 1, else 0
      if(op == 7) {
        var arg1 = getValue(i+1);
        var arg2 = getValue(i+2);
        var out = nums[i+3];
        if(numWithMode(arg1,opModes[1]) < numWithMode(arg2, opModes[2])) {
          storeValueWithMode(1, out, opModes[3]);
        } else {
          storeValueWithMode(0, out, opModes[3]);
        }   
      }
      // 8 = arg1 equals arg2, store 1, else 0
      if(op == 8) {
        var arg1 = getValue(i+1);
        var arg2 = getValue(i+2);
        var out = getValue(i+3);
        if(numWithMode(arg1,opModes[1]) == numWithMode(arg2, opModes[2])) {
          storeValueWithMode(1, out, opModes[3]);
        } else {
          storeValueWithMode(0, out, opModes[3]);
        }   
      }
      // 9 = change the relative base, relatively
      if(op == 9) {
        var arg1 = getValue(i+1);
        var modedArg = numWithMode(arg1, opModes[1]);
        relativeBase += modedArg;
      }
      i = iJump;
      print('Next i: $i');
    }
  }

  int numWithMode(int value, int mode) {
    if(mode == 0) {
      // position mode
      return getValue(value);
    } else if(mode == 1) {
      // immediate mode
      return value;
    } else if(mode == 2) {
      // relative mode
      print('Get value at ${relativeBase + value}');
      return getValue(relativeBase + value);
    } else {
      print('No such mode: $mode');
      return null;
    }
  }

  void storeValueWithMode(int value, int location, [int mode = 0]) {
    if(mode == 2) {
      location += relativeBase;
    }
    if(location+1 > nums.length) {
      nums.length = location+1;
    }
    nums[location] = value;
  }

  int getValue(int location) {
    if(nums[location] == null) {
      return 0;
    } else {
      return nums[location];
    }
  }
}
