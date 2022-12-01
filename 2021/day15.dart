class Day15 {
  static const dayFile = '2021/day15_test.txt';
  static List<List<int>> input = {};
  static var lineCount = 0;
  static var colCount = 0;
  
  static handle(String line) {
    //print('INPUT: $line');
    List<int> row = 
    line.split('').map((v) => int.parse(v));
    input.add(row);
    lineCount++;
    colCount = row.length;
  }

  static whenDone() {
    print(input);
    var List<List<int>> frontier;
    var start = [0,0];
    var goal = [colCount - 1, lineCount - 1];
    frontier.add(start);
    Map<String, int> came_from = {};
    Map<String, int> cost_so_far = {};
    came_from['0:0'] = 0;
    cost_so_far['0:0'] = 0;

    while(frontier.isNotEmpty) {
      var current = frontier.last;

      // found the end
      if(current[0] == goal[0] && current[1] == goal[1]) {
       break;
      }

      for(var next in [[current[0]-1, current[1]],
                       [current[0], current[1]-1],
                       [current[0]+1, current[1]],
                       [current[0], current[1]-1]]) {
        if(next[0] < 0 || next[1] < 0
           || next[0] >= colCount
           || next[1] >= lineCount) {
          continue;
        }
        // input is lines, then rows
        var new_cost = cost_so_far[current] + input[next[1]][next[0]];
        var nextKey = '${next[0]}:${next[1]}';
        if(!cost_so_far.containsKey(nextKey) 
           || new_cost < cost_so_far[nextKey]) {
         cost_so_far[nextKey] = new_cost;
         var priority = new_cost + heuristic(goal, next)
         frontier.add(next, priority)
         came_from[nextKey] = '${current[0]}:${current[1]}';
  }
} 