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
      var alignment = solve(program);
      print(alignment);
    },
    onError: (e) { print(e.toString()); }
  );
}

int solve(List<int> program) {
  var intcodeComputer = Intcode(program);
  Map<String,int> map = {};
  List<List<int>> display = [];
  Map<String,int> output = {'output':null};
  int row = 0;
  int x = 0;
  display.add([]);
  do {
    output = intcodeComputer.handle([], output['iJump'] ?? 0, output['relativeBase'] ?? 0);
    if(output['output'] == null) break;
    print('Output: ${output['output']}');
    if(output['output'] == 10) {
      row++;
      x = 0;
      display.add([]);
    } else {
      display[row].add(output['output']);
      map['${x++},$row'] = output['output'];
    }
  } while (output['output'] != null);

  var decoder = AsciiCodec();

  for(var row in display) {
    print(decoder.decode(row));
  }

  // print(map);
  int alignment = 0;
  // No crossings on the edges of the map:      
  for(var i=1; i< display[0].length-1; i++) {
    for(var j=1; j< display.length-1; j++) {
      if(map['$i,$j'] == 35
        && map['${i-1},$j'] == 35
        && map['$i,${j-1}'] == 35
        && map['${i+1},$j'] == 35
        && map['$i,${j+1}'] == 35
      ) {
        alignment += i * j;
      }
    }
  }
  
  return alignment;
}
