import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:trotter/trotter.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> inputs = [];
  List<int> outputs = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => inputs.add(int.parse(intstr)));
      List<int> phases = [0,1,2,3,4];
      var combos = Permutations(5, phases);
      for (var combo in combos()) {
        int input = 0;
        for (var phase in combo) {
          input = handle([...inputs], [phase, input]);
        }
        outputs.add(input);
      }
    },
    onDone: () { print('Max: ${outputs.reduce(max)}'); },
    onError: (e) { print(e.toString()); }
  );
}

int handle(List<int> nums, List<int> inputs) {
  // ugly hack: dart doesn't have unshift, only removeLast (pop)
  inputs = inputs.reversed.toList();
  print('INPUTS: $inputs');
  // Operation is the first value in each program
  // Ops were all length 4 in day 2, now length varies
  // Opcode value length also varies: could be 4 (1101 etc), 1 or 2 (99)
  Map<int,int> opLengths = {1:4,2:4,3:2,4:2,5:3,6:3,7:4,8:4,99:0};
  int op=0;
  int opLen;
  int i=0;
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

      nums[out] = numWithMode(arg1, opModes[1], nums) + numWithMode(arg2, opModes[2], nums);
    }
    // 2 = multiply values and store
    if(op == 2) {
      var arg1 = nums[i+1];
      var arg2 = nums[i+2];
      var out  = nums[i+3];

      nums[out] = numWithMode(arg1, opModes[1], nums) * numWithMode(arg2, opModes[2], nums);
    }
    // 3 = input/set and external value
    if(op == 3) {
      var out  = nums[i+1];
      
      nums[out] = inputs.removeLast();
    }
    // 4 = print out a value (is this ever immediate?)
    if(op == 4) {
      var out = nums[i+1];
      var output = numWithMode(out, opModes[1], nums);
      print('OUTPUT: $output');
      return output;
    }
    // 5 = jump if param non-zero
    if(op == 5) {
      var arg1 = nums[i+1];
      var out = nums[i+2];
      if(numWithMode(arg1, opModes[1], nums) != 0) {
        iJump = numWithMode(out, opModes[2], nums);
      }
    }
    // 6 = jump if param zero
    if(op == 6) {
      var arg1 = nums[i+1];
      var out = nums[i+2];
      if(numWithMode(arg1, opModes[1], nums) == 0) {
        iJump = numWithMode(out, opModes[2], nums);
      }
    }
    // 7 = arg1 less than arg2, store 1, else 0
    if(op == 7) {
      var arg1 = nums[i+1];
      var arg2 = nums[i+2];
      var out = nums[i+3];
      if(numWithMode(arg1,opModes[1], nums) < numWithMode(arg2, opModes[2], nums)) {
        nums[out] = 1;
      } else {
        nums[out]=0;
      }   
    }
    // 8 = arg1 equals arg2, store 1, else 0
    if(op == 8) {
      var arg1 = nums[i+1];
      var arg2 = nums[i+2];
      var out = nums[i+3];
      if(numWithMode(arg1,opModes[1], nums) == numWithMode(arg2, opModes[2], nums)) {
        nums[out] = 1;
      } else {
        nums[out]=0;
      }   
    }
    i = iJump;
  }
}

int numWithMode(int value, int mode, List<int> source) {
  // Modes: 0 = positional, find value in source
  // 1 = immediate, return value itself
  if(mode == 0) {
    return source[value];
  } else if(mode == 1) {
    return value;
  } else {
    print('No such mode: $mode');
    return null;
  }
}
