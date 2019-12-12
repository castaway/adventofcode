import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<Point> asteroids = [];
  double yCounter = 0;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      double xCounter = 0;
      line.split('').forEach((char) {
          if(char == '#') {
            asteroids.add(Point(xCounter, yCounter));
            //print(char);
          }
          xCounter++;
      });
      yCounter++;
    },
    onDone: () { Point best = solve(asteroids); print(best); },
    onError: (e) { print(e.toString()); }
  );
}

Point solve(List<Point> points) {
  // check every point against every other point..
  // number of visible asteroids from each other one:
  Map<Point,int> visibleCount = {};
  for(var pt in points) {
    // Line (gradient) from this point to other points (count of points they pass through)
    Map<double,int> gradients = {};
    for(var otherpt in points) {
      if(pt == otherpt) {
        continue;
      }
      double gradient = calcGradient(pt, otherpt);
//      print('From: $pt, To: $otherpt');
      print(gradient);
      if(!gradients.containsKey(gradient)) {
        gradients[gradient] = 1;
      } else {
        gradients[gradient]++;
      }
    }
    print('Point: $pt, Gradients: $gradients');
    visibleCount[pt]  = gradients.keys.length;
  }
  print(visibleCount);
  print(visibleCount.entries.reduce((entry_a, entry_b) => entry_a.value > entry_b.value ? entry_a : entry_b));
}

double calcGradient(Point a, Point b) {
  //  return (b.y - a.y) / (b.x - a.x);
  return atan2(b.y - a.y, b.x-a.x);
}

