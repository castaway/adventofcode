import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2021/day11.dart';

void main(List<String> arguments) {
  
  var filename = Day11.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Day11.handle(line);
    },
    onDone: () { Day11.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

