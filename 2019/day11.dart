import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> program = [];
  Map<String,int> hull = {};
  Map<String,int> output = {'output':null};
  File inputFile = new File(filename);
  int minx = 0; int miny = 0; int maxx = 0; int maxy = 0;
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => program.add(int.parse(intstr)));
      var intcodeComputer = Intcode(program);
      int x = 0;
      int y = 0;
      // dir = 0 (up), 1 (left), 2 (down), 3 (right)
      int dir = 0;
      int loopCount = 0;
      hull['0,0'] = 1;
      do {
        output = intcodeComputer.handle([hull['$x,$y'] ?? 0], output['iJump'] ?? 0, output['relativeBase'] ?? 0);
        if(output['output'] == null) break;
        if(output['output'] == 1) {
          hull['$x,$y'] = 1;
        } else if(output['output'] == 0) {
          hull['$x,$y'] = 0;
        }
        output = intcodeComputer.handle([], output['iJump'], output['relativeBase'] ?? 0);
        if(output['output'] == 0) {
          dir = dir < 3 ? dir+1 : 0;
        } else if(output['output'] == 1) {
          dir = dir > 0 ? dir-1 : 3;
        } else {
          print('Unknown output: ${output['output']}');
          break;
        }
        if(dir == 0) {
          y-=1;
        } else if(dir == 1) {
          x-= 1;
        } else if(dir == 2) {
          y+= 1;
        } else if(dir == 3) {
          x += 1;
        } else {
          print('Dir $dir unknown!');
        }
        if(x < minx) minx = x;
        if(y < miny) miny = y;
        if(x > maxx) maxx = x;
        if(y > maxy) maxy = y;
        print('x; $x, y: $y, dir: $dir');
      } while (output['output'] != null);
    },
    onDone: () {
      print('min,max: $minx,$miny $maxx,$maxy');
      print(hull.keys.length);
      for(var i=miny; i< maxy; i++) {
        var line = '';
        for(var j=minx; j < maxx; j++) {
          line += hull['$i,$j'] != null && hull['$i,$j'] == 1
          ? hull['$i,$j'].toString() : ' ';
        }
        print(line);
      }
    },
//    onDone: () { print(hull.values.where((val) => val == 1).length); },
    onError: (e) { print(e.toString()); }
  );
}
