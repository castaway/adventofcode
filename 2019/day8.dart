import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> layers = [];
  var minCount = 150;
  var minLayer = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var layerSplit = RegExp(r'(\d{150})');
      var layers = layerSplit.allMatches(line);
      for (var layer in layers) {
        var pixelCount = layer.group(1).split('').where((pixel) => int.parse(pixel) == 0).toList().length;
        if(pixelCount < minCount) {
          minCount = pixelCount;
          minLayer = layer.group(1).split('');
        }
      }
    },
    onDone: () { print(minCount);
      var minOnes = minLayer.where((pixel) => int.parse(pixel) == 1).length;
      var minTwos = minLayer.where((pixel) => int.parse(pixel) == 2).length;
      print(minOnes*minTwos);
    },
    onError: (e) { print(e.toString()); }
  );
}

