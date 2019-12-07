import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  Map<String,List<String>> wires = {};
  int lineCounter = 0;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      int x=0;
      int y=0;
      var stepCounter = 0;
      line.split(',').forEach((instr) {
          var parts = RegExp(r'(\w)(\d+)');
          var match = parts.firstMatch(instr);
          var dir = match.group(1);
          var dist = int.parse(match.group(2));
          if(dir == 'R') {
            dist += x;
            for(x; x<dist;x++) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = []; }
              wires['$x.$y'].add('$lineCounter:$stepCounter');
              stepCounter++;
            }
            
          }
          if(dir == 'U') {
            dist += y;
            for(y;y<dist;y++) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = []; }
              wires['$x.$y'].add('$lineCounter:$stepCounter');
              stepCounter++;
            }
          }
          if(dir == 'D') {
            dist = y-dist;
            for(y; y>dist; y--) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = []; }
              wires['$x.$y'].add('$lineCounter:$stepCounter');
              stepCounter++;
            }
          }
          if(dir == 'L') {
            dist = x-dist;
            for(x; x>dist; x--) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = []; }
              wires['$x.$y'].add('$lineCounter:$stepCounter');
              stepCounter++;
            }
          }
      });
      lineCounter++;
    },
    onDone: () { solve(wires); print(wires['0.0']); },
    onError: (e) { print(e.toString()); }
  );
}

int solve(Map<String,List<String>> junctions) {
  print(junctions);
  List<int> distances = [];
  int minSteps;
  junctions.entries
  .where((entry) => entry.value.length > 1)
  .forEach((entry) {
      print(entry.key);
      print(entry.value);
      Set<int> lines = <int>{};
      int steps = 0;
      entry.value.forEach((val) {
          var xy = RegExp(r'(\d+):(\d+)');
          var match = xy.firstMatch(val);
          lines.add(int.parse(match.group(1)));
          steps += int.parse(match.group(2));
      });
      print('Steps: $steps');
      print('Lines: $lines');
      if(lines.length > 1 && steps > 0 && (minSteps == null || steps < minSteps)) {
        minSteps = steps;
      }
  });

  print(minSteps);
}

