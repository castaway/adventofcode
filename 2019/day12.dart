import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:trotter/trotter.dart';

void main(List<String> arguments) {
  var filename = arguments[0];
  List<Map<String,int>> moons = [];
  File inputFile = new File(filename);
  Stream<List<int>> inputStream = inputFile.openRead();
  inputStream
  .transform(utf8.decoder)
  .transform(new LineSplitter())
  .listen((String line) {
      var moonPos = RegExp(r'<x=(-?\d+), y=(-?\d+), z=(-?\d+)>');
      var match = moonPos.firstMatch(line);
      moons.add({'x': int.parse(match.group(1)), 'y':int.parse(match.group(2)), 'z':int.parse(match.group(3))});
    },
    onDone: () {
      var energy = applyGravityAndMove(moons, 1000);
      print(moons);
      print(energy);
    },
    onError: (e) { print(e.toString()); }
  );
}

int applyGravityAndMove(List<Map<String,int>> start, iterations) {
  List<Map<String,int>> vels = [{'x':0,'y':0,'z':0},{'x':0,'y':0,'z':0},{'x':0,'y':0,'z':0},{'x':0,'y':0,'z':0}];
  for(var i = 0; i < iterations; i++) {
    // Gravity (velocity changes towards)
    var combos= Combinations(2, [0,1,2,3]);
    for(var combo in combos()) {
      var m1 = start[combo[0]];
      var m2 = start[combo[1]];
      for(var dim in ['x','y','z']) {
        if(m1[dim] > m2[dim]) {
          vels[combo[0]][dim]--; vels[combo[1]][dim]++;
        } else if(m1[dim] < m2[dim]) {
          vels[combo[0]][dim]++; vels[combo[1]][dim]--;
        } // else no changes
      }
    }
    // Apply velocities
    for(var j =0; j< start.length; j++) {
      start[j]['x'] += vels[j]['x'];
      start[j]['y'] += vels[j]['y'];
      start[j]['z'] += vels[j]['z'];
    }
    print('moons: $start');
    print('velocities: $vels');
  }
  // sum abs locations, multiply by sum of abs velocities
  int energy = 0;
  for(var i = 0; i < start.length; i++) {
    energy += start[i].values.reduce((ele,val) => ele.abs() + val.abs()) *
    vels[i].values.reduce((ele,val) => ele.abs() + val.abs());
  }
  //  var potEnergy = start.map((val) => val.values.reduce((v1,e1) => v1.abs() + e1.abs()));
  //print(potEnergy);
  //var kinEnergy = vels.map((val) => val.values.reduce((v1,e1) => v1.abs() + e1.abs()));
  //print(kinEnergy);
  //return potEnergy.reduce((val,ele) => val+ele) + kinEnergy.reduce((val,ele) => val+ele);
  return energy;
}
