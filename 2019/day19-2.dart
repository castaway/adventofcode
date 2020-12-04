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
      var closest;
      for(var size = 1000; size < 10000; size+=100) {
        var beam = solve(program, size);
        print('TestSize: $size');
        closest = findShape(beam,size,100,100);
        if(closest.isNotEmpty) break;
      }
      print(closest);
    },
    onError: (e) { print(e.toString()); }
  );
}

List<String> solve(List<int> program, int maxSize) {
  List<String> map = [];
  int pointCount = 0;
  for(var x = 0; x < maxSize; x++) {
    String row = '';
    for(var y = 0; y < maxSize; y++) {
      var intcodeComputer = Intcode([...program]);
      Map<String,int> output = {'output':null};
      output = intcodeComputer.handle([x,y], 0, 0);
      if(output['output'] == null) continue;
      // print('Output: ${output['output']}');
      if(output['output'] == 1) {
        pointCount += 1;
      }
      row += output['output'].toString();
    }
    map.add(row);
  }
  return map;
}

List<int> findShape(List<String> map, int maxSize, int xLen, int yLen) {
  var shipRow = RegExp('(1\{$xLen\})');
  var found = -1;
  var count = 0;
  // for every row:
  for(var y = 0; y < maxSize; y++) {
    print('Found: $found, Count: $count');
    if(!shipRow.hasMatch(map[y])) continue;
    // This is the first find of this set of matching rows
    if(found == -1) {
      print('Found first');
      found = y;
      count++;
      continue;
    }
    print('Y: $y');
    // row of a continuing find
    if(y == found+1) {
      print('Found more');
      found = y;
      count++;
      // leave if we found 100 rows
      if(count > yLen) break;
      continue;
    }
    // Reset, it matched so we restart
    found = 0;
    count = 1;
  }

  // if count = 100. found is the last row of a 100-block
  if(count == yLen+1) {
    var row = map[found-yLen];
    return [row.indexOf(shipRow), found-yLen];
  }
  return [];
}

