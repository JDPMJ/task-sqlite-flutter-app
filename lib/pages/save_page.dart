import 'package:app4/pages/list_pages.dart';
import 'package:flutter/material.dart';

import '../db/operation.dart';
import '../models/note.dart';

class SavePage extends StatefulWidget {
  static const String ROUTE = "/save";

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Note note = ModalRoute.of(context)!.settings.arguments as Note;
    _init(note);
    return Scaffold(
      appBar: AppBar(title: const Text("Guardar")),
      body: Container(
        child: _buildForm(note)
      )
    );
  }

  _init(Note note) {
    titleController.text = note.title!;
    contentController.text = note.content!;

  }

  Widget _buildForm(Note note) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            controller: titleController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Datos nulos";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Título",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
            )
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: contentController,
            maxLines: 8,
            maxLength: 1000,
            validator: (value) {
              if (value!.isEmpty) {
                return "Datos nulos";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Contenido",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
            )
          ),
          ElevatedButton(
            child: const Text("Guardar"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (note.id != null) {
                  print("ESTO ES UNA ACTUALIZACIÓN");
                  note.title = titleController.text;
                  note.content = contentController.text;
                  Operation.update(note);
                  Navigator.pushNamed(context, ListPages.ROUTE);
                } else {
                  print("ESTO ES UNA INSERCIÓN");
                  note.title = titleController.text;
                  note.content = contentController.text;
                  Operation.insert(Note(title: note.title, content: note.content));
                  Navigator.pushNamed(context, ListPages.ROUTE);
                }
              }
            }
          )
        ])
      )
    );
  }

  /*Future<bool?> showMyDialog(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("¿Quiere regresar?"),
      content: Text("Si regresa la información actual se perderá"),
      actions: [
        TextButton(
          child: Text("Cancelar"),
          onPressed: () => Navigator.pop(context, false)
        ),
        TextButton(
          child: Text("Salir"),
          onPressed: () => Navigator.pop(context, true)
        )
      ]
    )
  );*/
}