class Day4 {
  static var dayFile = '2020/day4.txt';
  
  static List<Map<String,String>> passports = [];
  static Map<String, String> current = {};
  static handle(String line) {
    if(line == '') {
      passports.add(current);
      current = {};
      return;
    }
    var kvs = line.split(' ');
    for(var kv in kvs) {
      var keyvalue = kv.split(':');
      current[keyvalue[0]] = keyvalue[1];
    }
  }
  
  static whenDone() {
    passports.add(current);
    
    var valid = passports.where((passport) {
      var nid = passport.entries.where((entry) => entry.key != 'cid');
      return nid.toList().length == 7 ? true : false;
    });
    print('PART 1: Valid entries: ${valid.length}');
    var part2 = validate();
    print('PART 2: $part2');
  }
  
  static int validate() {
    var valid = passports.where((passport) {
      var nid = Map.fromEntries(passport.entries.where((entry) => entry.key != 'cid'));
      if(nid.keys.length != 7) {
        return false;
      }
      var byr = int.parse(nid['byr']);
      if(byr < 1920 || byr > 2002) {
        return false;
      }
      var iyr = int.parse(nid['iyr']);
      if(iyr < 2010 || iyr > 2020) {
        return false;
      }
      var eyr = int.parse(nid['eyr']);
      if(eyr < 2020 || eyr > 2030) {
        return false;
      }
      var hgtCheck = RegExp(r'^(\d+)(cm|in)$');
      var hgtMatch = hgtCheck.firstMatch(nid['hgt']);
      //print(nid['hgt']);
      if(hgtCheck.hasMatch(nid['hgt'])) {
        var hgt = int.parse(hgtMatch.group(1));
        if((hgtMatch.group(2) == 'in' && (hgt < 59 || hgt > 76)) ||
        (hgtMatch.group(2) == 'cm' && (hgt < 150 || hgt > 193))) {
          return false;
        }
      } else {
        return false;
      }
      var hclMatch = RegExp(r'^#[0-9a-f]{6}$');
      print(nid['hcl']);
      if(!hclMatch.hasMatch(nid['hcl'])) {
        return false;
      }
      var eclMatch = RegExp(r'^amb|blu|brn|gry|grn|hzl|oth$');
      print(nid['ecl']);
      if(!eclMatch.hasMatch(nid['ecl'])) {
        return false;
      }
      var pidMatch = RegExp(r'^\d{9}$');
      print(nid['pid']);
      if(!pidMatch.hasMatch(nid['pid'])) {
        return false;
      }
      print('Pass: $passport');
      return true;
    });
    return valid.length;
  }
}