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
    },
    onDone: () { orbitCounter = findRoute(orbits, 'YOU', 'SAN'); print(orbitCounter); },
    onError: (e) { print(e.toString()); }
  );
}

int findRoute(Map<String,String> orbits, String start, String end) {
  List<String> startList = [];
  while( orbits[start] != null) {
    startList.add(orbits[start]);
    start = orbits[start];
  }
  int endCount = 0;
   while(orbits[end] != null){
     int startCount = startList.indexOf(orbits[end]);
     if(startCount > -1) {
       return endCount + startCount;
     }
     endCount++;
    end = orbits[end];
  }
}
  
 
int countOrbits (Map<String,String> orbits, which, counter) {
  
  if(orbits[which] == null) {
    return counter;
  }
  counter = countOrbits(orbits, orbits[which], counter+1);
  
  return counter;
}
