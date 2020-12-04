import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:trotter/trotter.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> input = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split('').forEach((val) => input.add(int.parse(val)));
    },
    onDone: () {
      List<int> repeatInput = [];
      for(var i = 0; i < 10000; i++) {
        repeatInput.addAll(input);
      }
      var result = solve(repeatInput, [0,1,0,-1]);
      print(result);
    },
    onError: (e) { print(e.toString()); }
  );
}

List<int> solve(List<int> signal, List<int> pattern) {
  for(var i =0; i < 100; i++) {
    List<int> newSignal = [];
    bool skipStart = false;
    // Repeat for each digit in signal
    for(var j = 0; j< signal.length; j++) {
      var repeatedPattern = repeatPattern(pattern, j+1);
      // print(repeatedPattern);
      var reverseSignal = signal.reversed.toList();
      // print(reverseSignal);
      var value = reverseSignal.removeLast();
      int sumAll = 0;
      // Sum up each new value multiplying by the pattern value(s)
      while(value != null) {
        for(var p in repeatedPattern) {
          if(skipStart == false) {
            skipStart = true;
            continue;
          }
          if(value == null) break;
          // print('$value * $p');
          sumAll += p*value;
          value = reverseSignal.length > 0 ? reverseSignal.removeLast() : null;
        }
      }
      // print(sumAll);
      skipStart = false;
      newSignal.add(sumAll.abs() % 10);
      // print(newSignal);
    }
    signal = newSignal;
  }
  return signal;
}

// given eg 0,1,0,-1
// return list with each input value repeated $n times
// and without the first value
List<int> repeatPattern(List<int> basic, int n) {
  List<int> pattern = [];
  List<int> nList = List<int>.generate(n, (int index) => index);
  for (var val in basic) {
    pattern.addAll(nList.expand((i) => [val]));
  }
  // pattern = basic.map((val) { nList.expand((i) => [val]).toList(); });

  return pattern;
}
