import 'package:flutter/material.dart';

import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        useCountryCode: false,
        fallbackFile: 'en',
        basePath: 'assets/flutter_i18n'),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);
  runApp(MyApp(flutterI18nDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  MyApp(this.flutterI18nDelegate);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internationalization',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: 'Internationalization'),
      localizationsDelegates: [
        flutterI18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _username;
  String _password;
  bool _validLogin;
  int _numAttempts = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          FlatButton(
            child: Text('EN'),
            onPressed: () async {
              print('Switching to english');
              Locale newLocale = Locale('en');
              await FlutterI18n.refresh(context, newLocale);
              setState(() {});
            },
          ),
          FlatButton(
            child: Text('PT'),
            onPressed: () async {
              print('Switching to portugese');
              Locale newLocale = Locale('pt');
              await FlutterI18n.refresh(context, newLocale);
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(_validLogin == null
                ? ''
                : _validLogin
                    ? FlutterI18n.translate(context, "login.success",
                        translationParams: {"username": _username})
                    : FlutterI18n.translate(context, "login.failure")),
          ),
          ListTile(
            title: I18nPlural("login.num_attempts", _numAttempts),
          ),
          ListTile(
            leading: Text(FlutterI18n.translate(context, "login.username")),
            title: TextField(
              controller: TextEditingController(text: _username),
              onChanged: (newValue) {
                _username = newValue;
              },
            ),
          ),
          ListTile(
            leading: Text(FlutterI18n.translate(context, "login.password")),
            title: TextField(
              controller: TextEditingController(text: _password),
              onChanged: (newValue) {
                _password = newValue;
              },
            ),
          ),
          ListTile(
            title: FlatButton(
              child: Text(FlutterI18n.translate(context, "login.login")),
              onPressed: () {
                if (_username == 'admin' && _password == '12345') {
                  setState(() {
                    _validLogin = true;
                  });
                } else {
                  _validLogin = false;
                  _numAttempts++;
                  setState(() {
                  });
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
