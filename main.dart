import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2021/day8.dart';

void main(List<String> arguments) {
  
  var filename = Day8.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Day8.handle(line);
    },
    onDone: () { Day8.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

