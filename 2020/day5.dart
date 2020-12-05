class Day5 {
  static const dayFile = '2020/day5.txt';
  static List<int> seats = [];
  static handle(String line) {
    List<String> inputs = line.split('');
    int index = 0;
    double low = 0;
    double high = 128;
    print(line);
    while(index < 7) {
      if(inputs[index] == 'F') {
        high = high - (high - low) / 2;
      } else {
        low = low + (high - low) / 2;
      }
      print('${inputs[index]}, $low, $high');
      index++;
    }
    double left = 0;
    double right = 8;
    while (index < 10) {
      if(inputs[index] == 'L') {
        right = right - (right - left) / 2;
      } else {
        left = left + (right - left) / 2;
      }
      print('${inputs[index]}, $left, $right');
      index++;
    }
    seats.add((low * 8 + left).toInt());
  }
  
  static whenDone() {
    print(seats);
    print(seats.reduce((v1, v2) => v1 > v2 ? v1 : v2));
  }
}