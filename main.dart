import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2022/day2.dart';

void main(List<String> arguments) {
  
  var filename = Advent.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Advent.handle(line);
    },
    onDone: () { Advent.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

