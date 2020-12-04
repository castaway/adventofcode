import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> program = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => program.add(int.parse(intstr)));
    },
    onDone: () {
      var points = solve(program);
      print(points);
    },
    onError: (e) { print(e.toString()); }
  );
}

int solve(List<int> program) {
  Map<String,int> map = {};
  int pointCount = 0;
  for(var x = 0; x < 50; x++) {
    for(var y = 0; y < 50; y++) {
      var intcodeComputer = Intcode([...program]);
      Map<String,int> output = {'output':null};
      output = intcodeComputer.handle([x,y], 0, 0);
      if(output['output'] == null) continue;
      // print('Output: ${output['output']}');
      if(output['output'] == 1) {
        pointCount += 1;
      }
      map['$x,$y'] = output['output'];
    }
  }
  return pointCount;
}

//
// Next i: 176
// original: [1002, 132, -1, 132]
// Write: Location: 132, Value: -303
//
// Next i: 130
// original: [1105, 1, -303]
// Next i: -303
