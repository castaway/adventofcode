import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2020/day1.dart';
import './2020/day2.dart';
import './2020/day3.dart';
import './2020/day4.dart';

void main(List<String> arguments) {
  
  var filename = Day4.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Day4.handle(line);
    },
    onDone: () { Day4.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

