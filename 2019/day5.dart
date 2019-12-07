import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> inputs = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => inputs.add(int.parse(intstr)));
      handle(inputs);
    },
    onDone: () { print(inputs[0]); },
    onError: (e) { print(e.toString()); }
  );
}

int handle(List<int> nums) {
  // Operation is the first value in each program
  // Ops were all length 4 in day 2, now length varies
  // Opcode value length also varies: could be 4 (1101 etc), 1 or 2 (99)
  Map<int,int> opLengths = {1:4,2:4,3:2,4:2,9:0};
  int op=0;
  int opLen;
  int i=0;
  while (op != 99) {
    List<int> opWithModes = nums[i].toString().split('').map((val) => int.parse(val)).toList();
    op = opWithModes.removeLast();
    opLen = opLengths[op];
    print('i: $i');
    print('original: ${nums.sublist(i,i+opLen)}');
    // Well this is ugly.. most op codes are 1 digit (or 0-padded) except 99
    if(opWithModes.length > 0 && opWithModes.removeLast() == 9) {
      op = 99;
    }
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
    print(opWithModes);
    print('op: $op');
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

      // FIXME Hardcoded input!:
      nums[out] = 1;
    }
    // 4 = print out a value (is this ever immediate?)
    if(op == 4) {
      var out = nums[i+1];
      var output = numWithMode(out, opModes[1], nums);
      print('OUTPUT: $output');
    }
    i += opLen;
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
