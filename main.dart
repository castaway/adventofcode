import 'dart:io';
import 'dart:convert';
import 'dart:async';
import './2020/day1.dart';
import './2020/day2.dart';
import './2020/day3.dart';
import './2020/day4.dart';
import './2020/day5.dart';
import './2020/day6.dart';
import './2020/day7.dart';
import './2020/day8.dart';
import './2020/day9.dart';
import './2020/day10.dart';
import './2020/day11.dart';
import './2020/day12.dart';
import './2020/day13.dart';
// import './2020/day14.dart';
import './2020/day15.dart';
import './2020/day16.dart';
import './2020/day17.dart';
import './2020/day19.dart';

void main(List<String> arguments) {
  
  var filename = Day19.dayFile; // arguments[0];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
    Day19.handle(line);
    },
    onDone: () { Day19.whenDone(); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

