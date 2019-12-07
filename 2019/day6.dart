import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  Map<String,String> orbits = {};
  var orbittest = RegExp(r'(\w+)\)(\w+)');
  int orbitCounter = 0;
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var match = orbittest.firstMatch(line);
      var orbiter = match.group(2);
      var orbitee = match.group(1);
      orbits[orbiter] = orbitee;
   //   orbitCounter += countOrbits(orbits, orbiter, orbitCounter);
    },
    onDone: () { orbits.forEach((er,_) => orbitCounter = countOrbits(orbits, er, orbitCounter)); print(orbitCounter); },
    onError: (e) { print(e.toString()); }
  );
}

int countOrbits (Map<String,String> orbits, which, counter) {
  
  if(orbits[which] == null) {
    return counter;
  }
  counter = countOrbits(orbits, orbits[which], counter+1);
  
  return counter;
}
