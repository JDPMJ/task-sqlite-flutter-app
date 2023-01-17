import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

import '../models/note.dart';

class Operation {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), "note.db"),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT)");
      },
      version: 1
    );
  }

  static Future<int> insert(Note note) async {
    Database database = await _openDB();
    return database.insert("notes", note.toMap());
  }

  static Future<int> delete(Note note) async {
    Database database = await _openDB();
    return database.delete("notes", where: "id = ?", whereArgs: [note.id]);
  }

  static Future<int> update(Note note) async {
    Database database = await _openDB();
    return database.update("notes", note.toMap(), where: "id = ?", whereArgs: [note.id]);
  }

  static Future<List<Note>> notes() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> notesMap = await database.query("notes");
    for (var n in notesMap) {
      print(n["id"].toString() + " " + n["title"] + ": " + n["content"]);
    }
    return List.generate(notesMap.length, (i) => Note(
      id: notesMap[i]["id"],
      title: notesMap[i]["title"],
      content: notesMap[i]["content"]
    ));
  }
}