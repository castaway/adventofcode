import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2020/day1.dart';
import './2020/day2.dart';
import './2020/day3.dart';
import './2020/day4.dart';
import './2020/day5.dart';

void main(List<String> arguments) {
  
  var filename = Day5.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Day5.handle(line);
    },
    onDone: () { Day5.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

