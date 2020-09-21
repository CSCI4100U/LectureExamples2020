import 'dart:async';

// class Course {
//   String _code;
//   String _name;

//   Course(int age, {this._code, this._name}) {
//     // do something with age?
//   }

//   String toString() {
//     return 'Course($_code)';
//   }
// }

// var c = Course(21, _code = 'CSCI4100U', _name = 'Mobile Devices');

// class Online {
//   String url;
// }

// class Battler {
//   int hp;
//   int defense;
//   int attack;
// }

// class Healer {
//   int healPower;

//   void heal(Battler b) {
//     b.hp += 10;
//   }
// }

// class Sprite {
//   // stuff related to sprites
// }

// class Player with Battler, Sprite, Healer {
//   String name;
//   int level;
//   int xp;
// }

Future<String> longTermOperation(int numSeconds, String message) async {
  print('$message: operation started');
  String result = await Future.delayed(Duration(seconds: numSeconds), () {
    print('$message: after the delay');
    return message;
  });
  print('$message: after the delayed');
  return result;
}

// main() {
//   longTermOperation(5, 'hello from async').then((result) {
//     print(result);
//   });
//   print('after longTermOperation');
// }

// async/await version, running it twice:
main() async {
  String s = await longTermOperation(5, 'hello from async');
  String s1 = await longTermOperation(5, 'goodbye from async');
  print('after longTermOperation: ${s}, ${s1}');
}
