class Day7 {
  static const dayFile = '2021/day7.txt';
  static List<int> inputs = [];
  static int total = 0;
  
  static handle(String line) {
    //print('INPUT: $line');
    inputs.addAll(line.split(',')
      .map((v)=>int.parse(v)).toList());
    total = inputs.reduce((val, ele) => val+ele);
  }
  static whenDone() {
    print(inputs);
    print('Mean: $total, ${inputs.length}, ${total / inputs.length}');

    var mean = (total / inputs.length).ceil();

    print('Mean: $mean');
    // most of:
    // var most = dist.entries.reduce((val, ele) => ele.value > val.value ? ele : val);
    // print(most);

    var fuel = total;
    var c = mean;
    while(true) {
      var newfuel = inputs.map((k) => (c - k).abs()).reduce((f,ele) => f + ele);
      if(newfuel > fuel) {
        break;
      }
      c--;
      fuel = newfuel;
    }
  
    print('Part 1: $c, $fuel');

    fuel = total*total;
    c = mean;
    while(true) {
      var newfuel = inputs
        .map((k) {var n = (c - k).abs(); return (n*(n+1)/2).toInt();}) // calc fuel per crab
        .reduce((f,ele) => f + ele); // sum all fuels
      if(newfuel > fuel) {
        break;
      }
      c--;
      fuel = newfuel;
    }
    print('Part 2: $c, $fuel');
  }
}