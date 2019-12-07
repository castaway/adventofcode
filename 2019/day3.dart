import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  Map<String,Set<int>> wires = {};
  int lineCounter = 0;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      int x=0;
      int y=0;
      line.split(',').forEach((instr) {
          var parts = RegExp(r'(\w)(\d+)');
          var match = parts.firstMatch(instr);
          var dir = match.group(1);
          var dist = int.parse(match.group(2));
          if(dir == 'R') {
            dist += x;
            for(x; x<dist;x++) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = <int>{}; }
              wires['$x.$y'].add(lineCounter);
            }
            
          }
          if(dir == 'U') {
            dist += y;
            for(y;y<dist;y++) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = <int>{}; }
              wires['$x.$y'].add(lineCounter);
            }
          }
          if(dir == 'D') {
            dist = y-dist;
            for(y; y>dist; y--) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = <int>{}; }
              wires['$x.$y'].add(lineCounter);
            }
          }
          if(dir == 'L') {
            dist = x-dist;
            for(x; x>dist; x--) {
              if(wires['$x.$y'] == null) { wires['$x.$y'] = <int>{}; }
              wires['$x.$y'].add(lineCounter);
            }
          }
      });

      lineCounter++;
    },
    onDone: () { solve(wires); print(wires['0.0']); },
    onError: (e) { print(e.toString()); }
  );
}

int solve(Map<String,Set<int>> junctions) {
  List<int> distances = []; 
  junctions.entries
  .where((entry) => entry.value.length > 1)
  .forEach((entry) {
      print(entry.key);
      var xy = RegExp(r'(\d+)\.(\d+)');
      var match = xy.firstMatch(entry.key);
      var dist = (int.parse(match.group(1))).abs() +
      (int.parse(match.group(2))).abs();
      //print(dist);
      if(dist > 0) {
        distances.add(dist);
      }
  });

  print(distances.reduce(min));
}

