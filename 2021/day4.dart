class Day4 {
  static const dayFile = '2021/day4.txt';
  static List<int> draw = [];
  // List of boards, each board has rows:, cols: containing 5 sets for each
  // Order of row/col contents is unimportant, and they must be different
  static List<Map<String,List<Set>>> boards = [{'cols':[], 'rows':[]}];


  static handle(String line) {
    // print('INPUT: $line');
    if(draw.length == 0) {
      draw = line.split(',').map((val) => int.parse(val)).toList();

      for(var i in [0,1,2,3,4]) {
        boards.last['cols'].add(Set());
      }
      return;
    }
    if(line.length == 0) {
      return;
    }
    if(boards.last['rows'].length == 5) {
      boards.add({'cols':[], 'rows':[]});
      for(var i in [0,1,2,3,4]) {
        boards.last['cols'].add(Set());
      }
    }

    var boardrow;
    try {
      boardrow = 
      line.split(RegExp(r'\s+'))
        .where((val) => val.length > 0)
        .map((val) => int.parse(val)).toList();
    } catch(e) {
      print(line);
      print(e);
    }

    boards.last['rows'].add(Set.from(boardrow));
    for(var i=0; i<boardrow.length; i++) {
      try {
        boards.last['cols'][i].add(boardrow[i]);
      } catch(e) {
        print(e);
        print(i);
        print(boardrow[i]);
      }
    }
  }
  static whenDone() {
    //print(boards);
    print('Boards len: ${boards.length}');
    var calledNumbers = 4;
    var winningBoardId;
    while(true) {
      winningBoardId = checkRowOrCol(calledNumbers);
      if(winningBoardId > -1) {
        break;
      }
      calledNumbers++;
    }

    var winningBoard = boards[winningBoardId];
    print('Current number: ${draw[calledNumbers]}');
    print('Board: $winningBoard');
    // get all numbers, find unmarked ones:
    var numbers = Set();
    winningBoard['rows'].forEach((set) => numbers.addAll(set));
    var unmarked = numbers.difference(draw.getRange(0, calledNumbers+1).toSet());
    var sum = unmarked.reduce((value, element) => value + element);
    var result = sum * draw[calledNumbers];
    print('Numbers: $numbers');
    print('Unmarked: $unmarked');
    print('Sum: $sum');
    print('Part 1: $result');

    // Part 2 keep going until you find the last board that would "win"
    boards.removeAt(winningBoardId);
    while(boards.length > 1) {
      while(true) {
        winningBoardId = checkRowOrCol(calledNumbers);
        if(winningBoardId > -1) {
          break;
        }
        calledNumbers++;
      }
      boards.removeAt(winningBoardId);
    }
    while(true) {
      winningBoardId = checkRowOrCol(calledNumbers);
      if(winningBoardId > -1) {
        break;
      }
      calledNumbers++;
    }

    // last board:
    winningBoard = boards.first;
    print('Current number: ${draw[calledNumbers]}');
    print('Board: $winningBoard');
    numbers = Set();
    winningBoard['rows'].forEach((set) => numbers.addAll(set));
    unmarked = numbers.difference(draw.getRange(0, calledNumbers+1).toSet());
    sum = unmarked.reduce((value, element) => value + element);
    var result2 = sum * draw[calledNumbers];
    print(boards);
    print('Numbers: $numbers');
    print('Unmarked: $unmarked');
    print('Sum: $sum');
    print('Part 1: $result2');

  }

  static int checkRowOrCol(int called) {
    // range is start to < end !?
    final matchNumbers = draw.getRange(0, called+1).toSet();
    for(var b = 0; b < boards.length; b++) {
      var board = boards[b];
      for(var i=0; i<5; i++) {
        if(matchNumbers.containsAll(board['rows'][i])) {
          print('Bingo! Row/Col: ${board['rows'][i]} Called: $matchNumbers');
          return b;
        }
        if(matchNumbers.containsAll(board['cols'][i])) {
          print('Bingo! Row/Col: ${board['cols'][i]} Called: $matchNumbers');
          return b;
        }
      }
    }
    return -1;

  }
}