import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main(List<String> arguments) {
  var filename = arguments[0];
  int total = 0;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      print(line);
      total += mass(int.parse(line));
      print('Total: $total');
    },
    onDone: () { print(total); },
    onError: (e) { print(e.toString()); }
  );
//  print(total);
}

int mass(int num) {
  num = num ~/ 3;
  num -= 2;
  if(num <= 0) { return 0; }
  num += mass(num);
  return num;
}

