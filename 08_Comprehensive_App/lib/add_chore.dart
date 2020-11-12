import 'package:flutter/material.dart';

import 'model/chore.dart';
import 'model/person_model.dart';
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
}
