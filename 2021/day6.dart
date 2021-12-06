class Day6 {
  static const dayFile = '2021/day6.txt';
  static List<int> inputs = [];
  // counts of each value 0-8
  static List<int> fish = List.generate(9, (int index) => 0);

  static handle(String line) {
    print('INPUT: $line');
    inputs.addAll(line.split(',')
      .map((v)=>int.parse(v)).toList());
    inputs.sort();
    print(inputs);
    for(var f in inputs) {
      fish[f]++;
      //print(fish);
    }
  }
  static whenDone() {
    //print(inputs);
    for(var x=0; x<80; x++) {
      print('Iteration: $x, $fish');
      iterateFish();
    }
    print('Part1: ${fish.reduce((val,ele) => val+ele)}');
    for(var x=80; x<256; x++) {
      iterateFish();
    }
  // 1686252324092
    print('Part2: ${fish.reduce((val,ele) => val+ele)}');

  }

  static iterateFish() {
    var newFish = 0;
      // move each fish type down one 
      // assign 0s to 8 and 6
      for(var f=0; f<8; f++) {
        if(f == 0) {
          newFish = fish[0];
        }
        fish[f] = fish[f+1];    
      }
      fish[8] = newFish;
      fish[6] += newFish;
      //print('Length: $fish');

  }
} 