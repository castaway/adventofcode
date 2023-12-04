import 'dart:math';
class Advent {
  static const dayFile = '2023/day4.txt';
  static List<Map> games = [];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    // Card 175: 91 78  3 20 86 98 89 82 13 57 | 24 76 59 66 73  1  5 82 45  6 92  3 33 43 17 83 12 14 91 71 19 46 54 96 25
    final card_game = line.split(RegExp(r':\s+'));
    final id_match = RegExp(r'Card\s+(\d+)').firstMatch(card_game[0]);
    final parts = card_game[1].split(RegExp(r'\s+\|\s+'));
    final winning = parts[0].split(RegExp(r'\s+'));
    final numbers = parts[1].split(RegExp(r'\s+'));
    //print(winning);
    games.add({
      'id': int.parse(id_match[1]),
      'winning': winning.map((ele) => int.parse(ele)).toSet(),
      'numbers': numbers.map((ele) => int.parse(ele)).toSet(),
      'cards': 1
    });
  }

  static whenDone() {
    var total = 0;
    for(var g in games) {
      //print(g);
      final wins = g['winning'].intersection(g['numbers']).length;
      for(var i = 0; i < wins; i++) {
        print(i+g['id']);
        games[i+g['id']]['cards'] += g['cards'];
      }
      print("$wins, $total");
      total += pow(2,wins-1).toInt();
    }
    // count cards after all this
    int cardTotal = 0;
    games.forEach((ele) => cardTotal += ele['cards']);
    print("Part 1: $total");
    print("Part 2: $cardTotal");

  }
}

checkSymbol(int x, int y, int maxX, int maxY, Map symbols, List gears) {
  var x_min = x > 0 ? x - 1 : x;
  var y_min = y > 0 ? y - 1 : y;
  var x_max = x < maxX + 1 ? x + 1 : x;
  var y_max = y < maxY + 1 ? y + 1 : y;

  for(var fromx = x_min; fromx <= x_max; fromx++) {
    for(var fromy = y_min; fromy <= y_max; fromy++) {
      if(symbols.containsKey("$fromx:$fromy") && symbols["$fromx:$fromy"].length > 0) {
        if(symbols["$fromx:$fromy"] == '*') {
          gears.add("$fromx:$fromy");
        }
        return symbols["$fromx:$fromy"];
      }
    }
  }
  return '';
}