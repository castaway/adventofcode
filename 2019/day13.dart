import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> program = [];
  Map<String,int> game = {};
  Map<String,int> output = {'output':null};
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => program.add(int.parse(intstr)));
      var intcodeComputer = Intcode(program);
      List<int> inputs = [];
      int loopCount = 0;
      int x=0;
      int y=0;
      int tile;
      do {
        output = intcodeComputer.handle([], output['iJump'] ?? 0, output['relativeBase'] ?? 0);
        x = output['output'];
        if(x == null) break;
        output = intcodeComputer.handle([], output['iJump'], output['relativeBase'] ?? 0);
        y = output['output'];
        output = intcodeComputer.handle([], output['iJump'], output['relativeBase'] ?? 0);
        tile = output['output'];
        if(tile > 4) {
          print('Strange tile! tile');
          break;
        }
        game['$x,$y'] = tile;
      } while (output['output'] != null);
    },
    onDone: () {print(game.values.where((val) => val == 2).length); },
    onError: (e) { print(e.toString()); }
  );
}
