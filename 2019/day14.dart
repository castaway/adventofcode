import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:trotter/trotter.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  Map<String,Map<String,dynamic>> reactions = {};
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var basicReact = RegExp(r'(\d+)\s(\w+)');
      var matches = basicReact.allMatches(line);
      // last one is the amount + value of the output
      String creates = matches.last.group(2);
      int createsAmount = int.parse(matches.last.group(1));
      List<Map<String,int>> inputs = [];
      for(var match in matches) {
        // skip last item
        if(match.group(2) == creates) break;
        inputs.add({match.group(2): int.parse(match.group(1))});
      }
      reactions[creates] = {'amount': createsAmount, 'components': inputs};
    },
    onDone: () {
      Map<String,int> extras = {};
      var ore = solve(reactions, 1, 'FUEL', extras, 0);
      print(reactions);
      print(ore);
    },
    onError: (e) { print(e.toString()); }
  );
}

// 1 FUEL
// ...
// -> 3 BC 
//  -> 21(amount) C(chem); 5(makes); requestMultiplier = (21/5).ceil() = 5; ORE(component); 7(componentAmount); generateAtLeast = 7*requestMultiplier = 35;
// we use 35 ore, making 25C, which is 4 extra
//   -> 

// 53 STKFG
//  -> 2 VPVL

int solve(Map<String,Map<String,dynamic>> reacts, int amount, String chem, Map<String,int> extras, int oreCount) {
  print('Looking at: $amount, of $chem');
  // Recipe makes this many output of $chem
  int makes = reacts[chem]['amount'];
  // Run the recipe this many times:
  var requestMultiplier = 1;
  if(amount > makes) {
    requestMultiplier = (amount/makes).ceil();
  }
  for(var reqs in reacts[chem]['components']) {
    var component = reqs.keys.first;
    var componentAmount = reqs.values.first;
    var generateAtLeast = componentAmount * requestMultiplier;

    if(makes * requestMultiplier > amount) {
      print('too much! stored: ${makes * requestMultiplier - amount} of $chem');
      if(extras[chem] == null) {
        extras[chem] = makes * requestMultiplier - amount;
      } else {
        extras[chem] += makes * requestMultiplier - amount;
      }
    }
    if(component == 'ORE') {
      print('Need at least: ${generateAtLeast} ORE');
      return oreCount + generateAtLeast;
    }

    if(extras[component] != null && extras[component] > 0) {
      if(generateAtLeast > extras[component]) {
        generateAtLeast -= extras[component];
        extras[component] = 0;
      } else {
        print('blub!');
      }
    }
    oreCount = solve(reacts, generateAtLeast, component, extras, oreCount);
  }
  return oreCount;
}
