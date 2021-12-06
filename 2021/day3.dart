class Day3 {
  static const dayFile = '2021/day3.txt';
  static List<List<String>> inputs = [];

  // forward 1 / down 2 / up 3
  static handle(String line) {
    // print('INPUT: $line');
    inputs.add(line.split(''));
  }
  static whenDone() {
    String epsilon = '';
    String gamma = '';

    List<Map<int,int>> freq = findFreq(inputs);
    for (var val in freq) {
      if(val[1] > val[0]) {
        gamma = gamma + '1';
        epsilon = epsilon + '0';
      } else {
        gamma = gamma + '0';
        epsilon = epsilon + '1';
      }
    }
    final result = int.parse(epsilon, radix:2) * int.parse(gamma, radix:2);
    print('Part 1: $epsilon, $gamma, = $result');

    // Part 2, reduce set to 1 item:
    // oxy = by most common value
    // co2 = by least common

    List<List<String>> oxy = List.from(inputs);
    var index = 0;
    while(oxy.length > 1) {
      // already got common/uncommon in full set
      if(freq[index][1] >= freq[index][0]) {
        oxy = oxy.where((val) => val[index] == '1').toList();
      } else {
        oxy = oxy.where((val) => val[index] == '0').toList();
      }
      freq = findFreq(oxy);
      index++;
    }

    freq = findFreq(inputs);
    List<List<String>> co2 = List.from(inputs);
    index = 0;
    while(co2.length > 1) {
      // already got common/uncommon in full set
      if(freq[index][1] >= freq[index][0]) {
        co2 = co2.where((val) => val[index] == '0').toList();
      } else {
        co2 = co2.where((val) => val[index] == '1').toList();
      }
      freq = findFreq(co2);
      index++;
    }
    final result2 = int.parse(oxy[0].join(''), radix:2) * int.parse(co2[0].join(''), radix:2);
    print('Part 1: ${oxy[0]}, ${co2[0]}, = $result2');

  }

   static List<Map<int,int>> findFreq(List<List<String>> set) {
    List<Map<int,int>> freq = [];
    set[0].forEach((val) => freq.add({1:0,0:0}));

    for (var i=0; i<set.length; i++) {
      for (var l=0; l<set[i].length; l++) {
        final val = int.parse(set[i][l]);
        freq[l][val]++;
      }
    }
    return freq;
  }
}
