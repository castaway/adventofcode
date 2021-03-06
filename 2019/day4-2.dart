import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
// 278384-824795.
void main(List<String> arguments) {
  int result = 0;
  for(var i = 278384; i<= 824795; i++) {
    List<String> digits = i.toString().split('');
    var sorted = [...digits];
    sorted.sort();
    if(sorted.join('') != digits.join('')) {
      continue;
    }
    var pairs = RegExp(r'(?<!1)11(?!1)|(?<!2)22(?!2)|(?<!3)33(?!3)|(?<!4)44(?!4)|(?<!5)55(?!5)|(?<!6)66(?!6)|(?<!7)77(?!7)|(?<!8)88(?!8)|(?<!9)99(?!9)|00');
    if(!pairs.hasMatch(i.toString())) {
      continue;
    }
    result++;
  }
  print(result);
}

int solve(Map<String,List<String>> junctions) {
  print(junctions);
  List<int> distances = [];
  int minSteps;
  junctions.entries
  .where((entry) => entry.value.length > 1)
  .forEach((entry) {
      print(entry.key);
      print(entry.value);
      Set<int> lines = <int>{};
      int steps = 0;
      entry.value.forEach((val) {
          var xy = RegExp(r'(\d+):(\d+)');
          var match = xy.firstMatch(val);
          lines.add(int.parse(match.group(1)));
          steps += int.parse(match.group(2));
      });
      print('Steps: $steps');
      print('Lines: $lines');
      if(lines.length > 1 && steps > 0 && (minSteps == null || steps < minSteps)) {
        minSteps = steps;
      }
  });

  print(minSteps);
}

