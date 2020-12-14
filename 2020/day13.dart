class Day13 {
  static var dayFile = '2020/day13.txt';
  
  static int timeStamp = 0;
  static List<int> buses;
  static handle(String line) {
    if(timeStamp == 0) {
      timeStamp = int.parse(line);
    } else {
      buses = line.split(',').map((b) => b == 'x' ? -1 : int.parse(b)).toList();
    }
  }
  
  static whenDone() {
    int arrivesIn = timeStamp;
    int chosenBus;
    for(var bus in buses) {
      if(bus == -1) {
        continue;
      }

      var div = timeStamp / bus;
      print('bus: $bus');
      //print('Div: ${div.truncate()}, Mult: ${bus * div.truncate()}');
      //print(timeStamp % bus);
      var nextBus = (div.truncate()+1) * bus;
      if(nextBus - timeStamp < arrivesIn){
        arrivesIn = nextBus - timeStamp;
        chosenBus = bus;
      }
    }
    print('PART 1: ${arrivesIn * chosenBus}');

    // ignore the timeStamp, find the time(s) at which
    // each bus leaves 1 min after the previous one
    // ignore x's

    Map<int,Map<String, dynamic>> departureOffsets = {};
    int counter = 0;
    for(var bus in buses) {
      if(bus != -1) {
        departureOffsets[bus] = {'offset': counter};
      }
      counter++;
    }
    print(departureOffsets);
    for(var dep in departureOffsets.entries) {
      for(var depCheck in departureOffsets.entries) {
        if(dep.key == depCheck.key) {
          continue;
        }
        if(dep.value['offset'] > 0 && dep.value['offset'] % depCheck.key == 0) {
          print('Bus: ${dep.key} (${dep.value['offset']}) - leaves at same time as ${depCheck.key}');
        }
      }
    }
  }
}