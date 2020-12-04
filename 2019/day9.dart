import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';
import 'package:trotter/trotter.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> program = [];
  List<int> outputs = [];
  Map<String,int> output;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      line.split(',').forEach((intstr) => program.add(int.parse(intstr)));
      List<int> inputs = [1];
      var intcodeComputer = Intcode(program);
      output = intcodeComputer.handle(inputs);
    },
    onDone: () { print(output); },
    onError: (e) { print(e.toString()); }
  );
}
