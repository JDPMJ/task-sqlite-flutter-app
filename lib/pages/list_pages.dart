import 'package:app4/pages/save_page.dart';
import "package:flutter/material.dart";

import '../db/operation.dart';
import '../models/note.dart';

class ListPages extends StatelessWidget {
  static const String ROUTE = "/";
  @override
  Widget build(BuildContext context) {
    
    return _MyList();
  }
}

class _MyList extends StatefulWidget {
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Note> notes = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: const Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, SavePage.ROUTE, arguments: Note(title: "", content: "")).then((value) => _loadData());
      }),
      appBar: AppBar(title: const Text("Listado")),
      body: Container(
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (_, i) => _createItem(i)
        )
      )
    );
  }

  _loadData() async {
    List<Note> auxNote = await Operation.notes();
    setState(() {
      notes = auxNote;
    });
  }

  _createItem(int i) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 5),
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.delete, color: Colors.white)
          )
      ),
      onDismissed: (direction) {
        Operation.delete(notes[i]);
      },
      child: ListTile(
        title: Text(notes[i].title.toString()),
        trailing: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, SavePage.ROUTE, arguments: notes[i]).then((value) => _loadData());
            },
            child: const Icon(Icons.edit)
          )
      ),
    );
  }
}