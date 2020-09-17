String getCourse() {
  return 'CSCI 4100U';
}

printStudent(sid, firstName, lastName) {
  print('sid: $sid, fname: $firstName, lname: $lastName');
}

printName(name) {
  print(name);
}

void main() {
  printStudent('111222333', 'Randy', 'Fortier');

  String firstName; // default null
  var lastName = 'Fortier';

  dynamic x = 'Dynamic';
  x = 7;

  const programmingLanguage = 'Dart';
  final String name2 = getCourse();

  List<String> names = ['Ashfaq', 'Sally', 'Fred', 'Tunil'];
  names.add('Carla');

//   names.forEach(printName);

//   names.forEach((name) {
//     print(name);
//     // more lines of code
//   });

  names.forEach((name) => print(name));

//   names.forEach(print);

  var names2 = names.map((name) => '*' + name + '*');
  print(names2);
//   names2.forEach((name) => print(name));

  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  var sum = numbers.reduce((a, b) => a + b);
  print('Sum: $sum');

  var oddNumbers = numbers.where((n) {
    if ((n % 2) == 1) {
      return true;
    } else {
      return false;
    }
  });
  print(oddNumbers);

  var allOdd = oddNumbers.every((n) => (n % 2) == 1);
  print('Using every:  $allOdd');

  String name = 'Randy';
  if (name == 'Randy') {
    print('The world makes sense.');
  } else if (name == 'Fred') {
    print('Say what?');
  }

  Map<String, int> wordCount = {
    'the': 18,
    'dog': 3,
    'eat': 0,
    'cat': 4,
    'cheese': 1,
  };
  print('There were ${wordCount["the"]} "the" instances.  Yay, I found \$100');
}
