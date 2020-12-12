class Day10 {
  static var dayFile = '2020/day10_test.txt';
  
  static List<int> input = [];
  
  static handle(String line) {
    input.add(int.parse(line));
  }
  
  static whenDone() {
    input.sort();
    input.insert(0,0);
    input.add(input.last+3);
    print(input);
    Map<int,int> counts = {1: 0, 3: 0};
    List<int> diffs = [];
    for(var i=0;i< input.length-1;i++) {
      counts[input[i+1]-input[i]] += 1;
      diffs.add(input[i+1]-input[i]);
    }
    print(counts);
    var result = counts[1] * (counts[3]);
    print('PART 1: $result');
    
    // Part 2, how many variations are there? We only care about differences of 1 (3 is fine)
    // We can remove any 1-gap number that isnt preceeded by, or followed by, a gap of 3
    // except when there's more than 2 in a row aa that also leaves > 3 to next/previous items
    // variations = 1 (everything), 1 (none of the above), + removed items*2 ?

    // test = 15 removables (19208 variations)
    // 
    int variations = 0;
    print(diffs);
    var lastDiff = 1;
    var removables = 0;
    List<int> shortest = [0];
    for(var i = 1; i < input.length-2; i++) {
      //print(input[i]);
      print(lastDiff);
      if(lastDiff == 1
         && input[i+1]-input[i] == 1
         && input[i+1]-input[i-1] < 3) {

        removables +=1;
      }
      lastDiff = input[i+1]-input[i];
    }
    print(removables);
  }
}