import 'package:flutter/material.dart';

import 'add_chore.dart';

import 'model/chore.dart';
import 'model/chore_model.dart';

class ChoreList extends StatefulWidget {
  final String title;

  ChoreList({Key key, this.title}) : super(key: key);

  @override
  _ChoreListState createState() => _ChoreListState();
}

class _ChoreListState extends State<ChoreList> {
  List<Chore> _chores;
  ChoreModel _choreModel = new ChoreModel();

  @override
  initState() {
    super.initState();

    reload();
  }

  void reload() {
    _choreModel.getAllChores(null).then((chores) {
      setState(() {
        _chores = chores;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
                itemCount: _chores == null ? 0 : _chores.length,
                itemBuilder: (context, index) {
                  var chore = _chores[index];
                  return Dismissible(
                    key: Key(chore.id.toString()),
                    onDismissed: (direction) {
                      _deleteChore(index);

                      // give some feedback to the user
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Chore ${chore.name} deleted')));
                    },
                    child: ListTile(
                      title: Text(_chores[index].name),
                      dense: false,
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add Chore',
        onPressed: () {
          _addChore().then((chore) {
            if (chore != null) {
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Chore ${chore.name} added.')));
            }
          });
        },
      ),
    );
  }

  Future<Chore> _addChore() async {
    Chore chore = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddChore()));

    if (chore != null) {
      setState(() {
        _chores.add(chore);
      });

      _choreModel.insertChore(null, chore);

      return chore;
    }

    return null;
  }

  void _deleteChore(int index) {
    if (index < _chores.length) {
      // delete the local copy of the chore
      setState(() {
        _chores.removeAt(index);
      });

      // delete the chore from the database
      _choreModel.deleteChore(null, _chores[index].id);
    }
  }
}
