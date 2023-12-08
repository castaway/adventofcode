import 'dart:math';
class Advent {
  static const dayFile = '2023/day7_test.txt';
  static List<Map<String,dynamic>> hands = [];
  static List<String> ranks = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'];

  static handle(String line) {
    //print('INPUT: $line, ${line.length}');
    final inputRE = RegExp(r'([\d\w]+)\s+(\d+)');
    final match = inputRE.firstMatch(line);
    final hand = match[1].split(RegExp(r''));

    hands.add({'hand': match[1], 'bid': match[2], 'cards': hand });
  }
/*
  Five of a kind, where all five cards have the same label: AAAAA
  Four of a kind, where four cards have the same label and one card has a different label: AA8AA
  Full house, where three cards have the same label, and the remaining two cards share a different label: 23332
  Three of a kind, where three cards have the same label, and the remaining two cards are each different from any other card in the hand: TTT98
  Two pair, where two cards share one label, two other cards share a second label, and the remaining card has a third label: 23432
  One pair, where two cards share one label, and the other three cards have a different label from the pair and each other: A23A4
  High card, where all cards' labels are distinct: 23456
*/
  static whenDone() {
    // Figure out which type of result each hand is..
    for(var hand in hands) {
      // sets of cards:
      hand['counts'] = {};
      ranks.forEach((r) => hand['counts'][r] = 0);
      // print(hand['counts']);
      hand['cards'].forEach((c) => hand['counts'][c]++);
      if(hand['counts'].containsValue(5)) {
        hand['type'] = 1;
      } else if (hand['counts'].containsValue(4)) {
        hand['type'] = 2;
      } else if (hand['counts'].containsValue(3) &&
                hand['counts'].containsValue(2)) {
        hand['type'] = 3;
      } else if(hand['counts'].containsValue(3)) {
        hand['type'] = 4;
      } else if (hand['counts'].containsValue(2)) {
        var firstPair = '';
        var secondPair = '';
        hand['counts'].forEach((k,v) {
          if(v == 2 && firstPair.isEmpty) {
            firstPair = k;
          } else if (v == 2 && firstPair.isNotEmpty) {
            secondPair = k;
          }
        });
        if(firstPair.isNotEmpty && secondPair.isNotEmpty) {
          hand['type'] = 5;
        }
        if(firstPair.isNotEmpty) {
          hand['type'] = 6;
        }
      } else {
        hand['type'] = 7;
      }
    }
    print(hands);

    // Sort whole thing by strength
    hands.sort((a,b) => a['type'].compareTo(b['type']) 
              || ranks.indexOf(a['cards'][0]).compareTo(ranks.indexOf(b['cards'][0])));

    print(hands);
    //print("Part 1: $total");
    //print("Part 2: ${rSolutions.length}");

  }
}
