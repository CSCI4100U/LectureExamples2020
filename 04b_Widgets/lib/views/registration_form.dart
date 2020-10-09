import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _country = 'Canada';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'E-Mail',
              hintText: 'someone@email.com',
            ),
            validator: (String value) {
              print('Validating email');
              if (value.isEmpty) {
                return 'E-Mail is required';
              }
              return null;
            },
            onSaved: (String value) {
              _email = value;
              print('Saving email: $_email');
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (String value) {
              print('Validating password');
              if (value.length < 8) {
                return 'Passwords must be at least 8 characters';
              }
              return null;
            },
            onSaved: (String value) {
              _password = value;
              print('Saving password: $_password');
            },
          ),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: 'Country',
            ),
            value: _country,
            items: <String>['Canada', 'USA', 'Britain']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String value) {
              _country = value;
              print('Country changed: $_country');
            },
            validator: (String value) {
              print('Validating country');
            },
            onSaved: (String value) {
              print('Saving country: $_country');
            },
          ),
          RaisedButton(
            child: Text('Register'),
            onPressed: () {
              print('Registered!');

              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Registered new user'),
                ));
                _formKey.currentState.save();
              }
            },
          ),
        ],
      ),
    );
  }
}
