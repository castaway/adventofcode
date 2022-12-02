class Advent {
  static const dayFile = '2022/day2.txt';
  static List<List<String>> inputs = [];

  static handle(String line) {
    // print('INPUT: $line, ${line.length}');
    List<String> game = line.split(' ');
    inputs.add(game);
  }

  static whenDone() {
    Map<String, int> values = {
      'A': 1, 'B': 2, 'C': 3,
      'X': 1, 'Y': 2, 'Z': 3,
    };
    Map<String, int> scores = {
      'A,X' : 3, // Rock, Rock
      'A,Y' : 6, // Rock, Paper
      'A,Z' : 0, // Rock, Scissors
      'B,X' : 0, // Paper, Rock
      'B,Y' : 3, // Paper, Paper
      'B,Z' : 6, // Paper, Scissors
      'C,X' : 6, // Scissors, Rock
      'C,Y' : 0, // Scissors, Paper
      'C,Z' : 3, // Scissors, Scissors
    };
    int score = 0;
    for (var game in inputs) {
      score += values[game[1]];
      int result = scores[game.join(',')];
      //print('Game: $game, Result: $result');
      score += result;
    }

    // X = Lose, Y = Draw, Z = Win
    Map<String, int> choices = {
      'A,X' : 0+3, // Rock, Lose
      'A,Y' : 3+1, // Rock, Draw
      'A,Z' : 6+2, // Rock, Win
      'B,X' : 0+1, // Paper, Lose
      'B,Y' : 3+2, // Paper, Draw
      'B,Z' : 6+3, // Paper, Win
      'C,X' : 0+2, // Scissors, Lose
      'C,Y' : 3+3, // Scissors, Draw
      'C,Z' : 6+1, // Scissors, Win
    };
    int score2 = 0;
    for (var game in inputs) {
      int result = choices[game.join(',')];
      print('Game: $game, Result: $result');
      score2 += result;
    }
    
    print("Part 1: $score");
    print("Part 2: $score2");

  }
}