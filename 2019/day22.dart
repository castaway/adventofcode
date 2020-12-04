import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import './intcode.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<List<dynamic>> inputs = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var newStack = RegExp(r'deal into new stack');
      var dealIncrement = RegExp(r'deal with increment (-?\d+)');
      var cut = RegExp(r'cut (-?\d+)');
      if(newStack.hasMatch(line)) {
        inputs.add(['restack',0]);
      }
      if(dealIncrement.hasMatch(line)) {
        inputs.add(['increment', int.parse(dealIncrement.firstMatch(line).group(1))]);
      }
      if(cut.hasMatch(line)) {
        inputs.add(['cut', int.parse(cut.firstMatch(line).group(1))]);
      }
    },
    onDone: () {
      var deck = List.generate(10007, (int index) => index);
//      var deck = List.generate(10, (int index) => index);
      var newDeck = solve(deck, inputs);
      print(newDeck);
      print(newDeck.indexWhere((val) => val == 2019));
    },
    onError: (e) { print(e.toString()); }
  );
}

List<int> solve(List<int> deck, List<List<dynamic>> program) {
  List<int> myDeck = [...deck];
  for(var instruction in program) {
    print(myDeck);
    if(instruction[0] == 'restack') {
      myDeck = myDeck.reversed.toList();
      continue;
    }
    if(instruction[0] == 'cut') {
      if(instruction[1] > 0) {
        myDeck = myDeck.sublist(instruction[1], myDeck.length) + myDeck.sublist(0, instruction[1]);
      } else {
        var pos = instruction[1].abs(); 
        myDeck = myDeck.sublist(myDeck.length-pos, myDeck.length) + myDeck.sublist(0, myDeck.length-pos);
      }
    }
    if(instruction[0] == 'increment') {
      List<int> newDeck = [];
      newDeck.length = deck.length;
      int pos = 0;
      for (var i in myDeck) {
//        print('inc: $newDeck');
        newDeck[pos] = i;
        pos = pos + instruction[1] > deck.length-1 ? pos + instruction[1] - deck.length : pos + instruction[1];
      }
      myDeck = [...newDeck];
    }
  }

  return myDeck;
}

//
// Next i: 176
// original: [1002, 132, -1, 132]
// Write: Location: 132, Value: -303
//
// Next i: 130
// original: [1105, 1, -303]
// Next i: -303
