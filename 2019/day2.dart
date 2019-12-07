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
      for(var x = 0; x<= 99; x++) {
        for(var y = 0; y<= 99; y++) {
          List<int> inputscopy = [ ...inputs];
          inputscopy[1] = x;
          inputscopy[2] = y;
          handle(inputscopy);
        }
      }
    },
    onDone: () { print(inputs[0]); },
    onError: (e) { print(e.toString()); }
  );
}

int handle(List<int> nums) {
  for(var i = 0; i < nums.length; i+=4) {
    var op = nums[i];
    if(op == 99) break;

    var arg1 = nums[i+1];
    var arg2 = nums[i+2];
    var out  = nums[i+3];

    if(op == 1) {
      nums[out] = nums[arg1] + nums[arg2];
    }
    if(op == 2) {
      nums[out] = nums[arg1] * nums[arg2];
    }
  }
  if(nums[0] == 19690720) {
    print('Found 19690720 at ${nums[1]}, ${nums[2]}');
  }
}

