import 'package:flutter/material.dart';

import 'model/chore.dart';
import 'model/person_model.dart';
import 'select_icon.dart';
import 'utils.dart';

class AddChore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Chore')),
      body: AddChoreForm(),
    );
  }
}

class AddChoreForm extends StatefulWidget {
  @override
  _AddChoreState createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChoreForm> {
  final _formKey = GlobalKey<FormState>();
  final _personModel = PersonModel();
  Chore _chore;
  List<String> _peopleNames = [];
  String _iconImage = 'assets/icons8-info-100.png';
  bool _showDaysOfWeek = false;
  bool _showDate = true;

  void _initPeopleNames() {
    _personModel.getAllPeopleNames(null).then((peopleNames) {
      setState(() {
        _peopleNames = peopleNames;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _initPeopleNames();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    if (_chore == null) {
      _chore = Chore();
      _chore.icon = _iconImage;
      _chore.date = toDateString(now.year, now.month, now.day);
      _chore.time = toTimeString(now.hour, now.minute);
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Chore name',
                  labelText: 'Name:',
                ),
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                onSaved: (value) => setState(() => _chore.name = value),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Assigned To:'),
                  value: _chore.assignedTo,
                  items: _peopleNames
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    _chore.assignedTo = value;
                  }),
                ),
              ),
            ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Icon:'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Select'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return IconSelector.getIconSelectorDialog(context);
                        },
                      ).then((selectedIcon) {
                        print(selectedIcon);
                        setState(() {
                          _iconImage = selectedIcon;
                          _chore.icon = selectedIcon;
                        });
                      });
                    },
                  ),
                  Expanded(
                    child: Image.asset(_iconImage, height: 50),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('Repeat Interval'),
                  value: _chore.repeat,
                  items: ['None', 'Daily', 'Weekly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: _updateRepeat,
                ),
              ),
            ),
            !_showDate
                ? Container()
                : ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text('Date:'),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Select'),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: now,
                              lastDate: DateTime(2100),
                            ).then((value) {
                              setState(() {
                                _chore.date = toDateString(
                                    value.year, value.month, value.day);
                              });
                            });
                          },
                        ),
                        Expanded(
                          child: Text(_chore == null || _chore.date == null
                              ? toDateString(now.year, now.month, now.day)
                              : _chore.date),
                        ),
                      ],
                    ),
                  ),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('Time:'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Select'),
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime:
                            TimeOfDay(hour: now.hour, minute: now.minute),
                      ).then((value) {
                        setState(() {
                          _chore.time = toTimeString(value.hour, value.minute);
                        });
                      });
                    },
                  ),
                  Expanded(
                    child: Text(_chore.time),
                  ),
                ],
              ),
            ),
            !_showDaysOfWeek
                ? Container()
                : ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text('Days of week:'),
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            Text('Sunday'),
                            Checkbox(
                                value:
                                    _chore.sunday == null || _chore.sunday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.sunday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                            Text('Monday'),
                            Checkbox(
                                value:
                                    _chore.monday == null || _chore.monday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.monday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Tuesday'),
                            Checkbox(
                                value:
                                    _chore.tuesday == null || _chore.tuesday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.tuesday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                            Text('Wednesday'),
                            Checkbox(
                                value:
                                    _chore.wednesday == null || _chore.wednesday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.wednesday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Thursday'),
                            Checkbox(
                                value:
                                    _chore.thursday == null || _chore.thursday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.thursday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                            Text('Friday'),
                            Checkbox(
                                value:
                                    _chore.friday == null || _chore.friday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.friday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Saturday'),
                            Checkbox(
                                value:
                                    _chore.saturday == null || _chore.saturday == 0
                                        ? false
                                        : true,
                                onChanged: (value) {
                                  setState(() {
                                    _chore.saturday =
                                        value == null || value == false ? 0 : 1;
                                  });
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Center(
                child: RaisedButton(
                  child: Text('Add Chore'),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();

                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Chore "${_chore.name}" added.')));

                      Navigator.pop(context, _chore);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateRepeat(String value) {
    print('updateRepeat($value)');
    setState(() {
      _chore.repeat = value;

      if (value == 'Weekly') {
        _showDaysOfWeek = true;
      } else {
        _showDaysOfWeek = false;
      }

      if (value == null || value == 'None') {
        _showDate = true;
      } else {
        _showDate = false;
      }
    });
  }
}
