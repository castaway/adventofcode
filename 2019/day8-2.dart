import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<int> layers = [];
  List<List<int>> image = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var layerSplit = RegExp(r'(\d{150})');
      var layers = layerSplit.allMatches(line);
      for (var layer in layers) {
        var pixels = layer.group(1).split('');
        var pos = 0;
        for (var y = 0; y< 6; y++) {
          // setup (layer 1 only)
          if(image.isEmpty ||  image.length < y+1) {
            image.add([]);
          }
          for (var i = pos; i < pos+25; i++) {
            // setup layer 1 (ggrrr at dart)
            if(image[y].length < i-pos+1) {
              image[y].add(int.parse(pixels[i]));
            }
            // replace lower layers if we can see through to a 0 or a 1
            if(int.parse(pixels[i]) !=2 && image[y][i-pos] == 2) {
              image[y][i-pos] = int.parse(pixels[i]);
            }
          }
          // next row in layer
          pos += 25;
        }
//        print(image);

      }
    },
    onDone: () {
      for(var y in image) {
        //print(y);
        var line = '';
        for (var x in y) {
          //print(x);
          if(x == 0) {
            line += ' ';
          } else if(x == 1) {
            line += 'X';
          } else {
            line += ' ';
          }
        }
        print(line);
      }
    },
    onError: (e) { print(e.toString()); }
  );
}

