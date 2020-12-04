class Day1 {
  static const dayFile = 'day1_1.txt';
  static List<int> inputs = [];

  static handle(String line) {
      print('INPUT: $line');
      int newNum = int.parse(line);
      var result = Day1.check_sum(inputs, newNum, 2020);
      if (result > 0) {
        print('FOUND 1: ${result * newNum}');
      } else {
        inputs.add(newNum);
      }
      var part2 = check_sum_three(inputs, 2020);
      print('PART2: $part2');
  }

  static int check_sum(List<int> nums, int newValue, int total) {
    for (var val in nums) {
      if(val+newValue==total) {
        return val;
      }
    }
    return 0;
  }

  static int check_sum_three(List<int> nums, int total) {
    nums.sort();
    for (var x in nums) {
      for (var y in nums.sublist(1)) {
        for (var z in nums.sublist(2)) {
          if(x+y+z == total) {
            return x*y*z;
          }
        }
      }
    }
  }
}