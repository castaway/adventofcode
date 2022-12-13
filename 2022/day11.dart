import 'dart:convert';

class Advent {
  static const dayFile = '2022/day11_test.txt';
  static List<Map<String, dynamic>> monkeys = [];
//Monkey 0:
//  Starting items: 79, 98
//  Operation: new = old * 19
//  Test: divisible by 23
//    If true: throw to monkey 2
//    If false: throw to monkey 3
      
  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    final monkeyRE = RegExp(r'^Monkey\s(\d+):');
    final itemsRE = RegExp(r'^\s+Starting\sitems:\s([\d\s,]+)');
    final opsRE = RegExp(r'^\s+Operation:\snew\s=\sold\s(.)\s([\d\s,]+|old)');
    final testRE = RegExp(r'^\s+Test:\sdivisible\sby\s([\d\s,]+)');
    final condRE = RegExp(r'^\s+If\s(\w+):\sthrow\sto\smonkey\s([\d\s,]+)');
    if(monkeyRE.hasMatch(line)) {
        monkeys.add({'inspected': 0});
    }
    if(itemsRE.hasMatch(line)) {
      var match = itemsRE.firstMatch(line);
      var items = match.group(1).split(', ').map((i) => int.parse(i)).toList();
      monkeys.last['items'] = items;
    }
    if(opsRE.hasMatch(line)) {
      var match = opsRE.firstMatch(line);
      Map<String, dynamic> op = {};
      op['op'] = match.group(1);
      if(match.group(2) == 'old') {
        op['old'] = true;
      } else {
        op['amount'] = int.parse(match.group(2));
        op['old'] = false;        
     }
      monkeys.last['op'] = op;
    }
    if(testRE.hasMatch(line)) {
      var match = testRE.firstMatch(line);
      monkeys.last['test'] = int.parse(match.group(1));
    }
    if(condRE.hasMatch(line)) {
      var match = condRE.firstMatch(line);
      monkeys.last[match.group(1)] = int.parse(match.group(2));
    }
  }

  static whenDone() {
    var p1 = 0;
    print(monkeys);
    var origMonkeys = json.decode(json.encode(monkeys));
    origMonkeys = origMonkeys.map((m) => Map<String, dynamic>.from(m)).toList();
    rounds(monkeys, 20, true);
    monkeys.sort((a, b) => a['inspected'].compareTo(b['inspected']));
    print(monkeys.reversed);
    var ms = monkeys.reversed.toList();
    p1 = ms[0]['inspected'] * ms[1]['inspected'];

    // Need BigInts here, sigh (but json doesnt en/decode those)
    for (var m in origMonkeys) {
      m['items'] = m['items'].map((i) => BigInt.from(i)).toList();
    }
    rounds(origMonkeys, 10000, false);
    print(origMonkeys);
    origMonkeys.sort((a, b) => a['inspected'].compareTo(b['inspected']) as int);
    print(origMonkeys.reversed);
    var ms2 = origMonkeys.reversed.toList();
    print(ms2);
    var p2 = ms2[0]['inspected'] * ms2[1]['inspected'];
    
    print('Part 1: $p1');
    print('Part 2: $p2');
  }
}

rounds(monkeys, int loop, bool div) {
  for(var i = 0; i < loop; i++) {
    print('Round: $i');
    for(var m in monkeys) {
      m['inspected'] += m['items'].length;
      for(var item in m['items']) {
        var opAmount;
        if(m['op']['old']) {
          opAmount = item;
        } else {
          opAmount = m['op']['amount'];
        }
        if(item is BigInt && opAmount is! BigInt) {
          opAmount = BigInt.from(opAmount);
        }
        if(m['op']['op'] == '*') {
         item *= opAmount;
        } else {
          item += opAmount;
        }
        if(div) {
          item /= 3;
          item = item.toInt();
        }
        var testM = m['test'];
        if (item is BigInt) {
          testM = BigInt.from(testM);
        }
        if(item % testM == 0) {
          monkeys[m['true']]['items'].add(item);
        } else {
          monkeys[m['false']]['items'].add(item);          
        }
        m['items'] = [];
      }
    }
    //print(monkeys);
  }
}

