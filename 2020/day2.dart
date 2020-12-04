class Day2 {
  static const dayFile = 'day2.txt';
  static var counter = 0;
  static var lines = 0;
  static var count_pt2 = 0;
  static handle(String line) {
    lines++;
    //print("Line: $lines");
    //print('incoming: $line');
    List<String> parts = line.split(': ');
    var rule = RegExp(r'(\d+)-(\d+)\s(\w)');

    var match = rule.firstMatch(parts[0]);
    // Part 2
    var firstIndex = int.parse(match.group(1));
    var secondIndex = int.parse(match.group(2));
    var letter = match.group(3);
    var hasOne = parts[1][firstIndex-1] == letter;
    var hasTwo = parts[1][secondIndex-1] == letter;
    if( (hasOne || hasTwo) && !(hasOne && hasTwo) ) {
      print('Yes');
      count_pt2++;
    }
    // Part 1
    var regex = parts[0].replaceAllMapped(rule,
       (Match m) => "(?<!${m[3]})${m[3]}{${m[1]},${m[2]}}(?!${m[3]})");
    
    //print("Pattern: $regex");
    var passwd = parts[1];
    //print("Against: $passwd");
    var stripped = passwd.replaceAll(new RegExp('[^${match.group(3)}]'), '');
    //print("Stripped: $stripped");
    
    if(stripped.contains(new RegExp(regex))) {
      // print('good');
      //print(line);
      counter++;
    } else {
      //print('bad');
    }
    //print('---');
  }

  static whenDone() {
    print('PART 1: $counter / $lines');
    print('PART 2: $count_pt2');
  }
}