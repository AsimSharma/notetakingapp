import "dart:developer";
import "package:notetakingapp/models/notes_models.dart";
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqflite.dart";

class SqlDbHelper {
  //createsTables
  static Future<void> createsTable(sql.Database database) async {
    await database.execute('''CREATE TABLE notes (
       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
       title TEXT, 
       descriptions TEXT,      
       priority INTEGER,
       colors INTEGER,
       createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    )''');
  }

  //create databases
  static Future<sql.Database> db() async {
    return sql.openDatabase("notes.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      log("_____________________________Creating the tables notes___________________________________");
      await createsTable(database);
    });
  }

  //insertNotesintoDb
  static Future<int> addNoteToDb(NotesModels notesModels) async {
    log('addNoteToDb call');
    final db = await SqlDbHelper.db();
    return db.insert("notes", notesModels.toJson());
  }

  //gettheNotes from db
  static Future<List<Map<String, dynamic>>> getallNoteFromDb() async {
    log('getallNoteFromDb Methods call');
    final db = await SqlDbHelper.db();
    return db.query("notes", orderBy: 'id');
  }

//getTheNotesbyId
  static getTheNotesbyId(int id) async {
    log('getTheNotesbyId Methods call');
    try {
      final db = await SqlDbHelper.db();
      final data = await db.query(
        "notes",
        where: "id = ?",
        whereArgs: [id],
      );
      log("Data $id ;   $data");
      return data;
    } catch (e) {
      log("Error :$e");
    }
  }

//deleteNotesById
  static Future<int> deleteById(int id) async {
    log('delete notes byId Methods call');
    final db = await SqlDbHelper.db();
    return db.delete(
      "notes",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//updatebynotesbyID

  static Future<int> updateNotes(NotesModels notesModels) async {
    log("this is editsIndex ${notesModels.id}");
    final db = await SqlDbHelper.db();
    log(notesModels.toJson().toString());
    return await db.update(
      "notes",
      notesModels.toJson(),
      where: "id = ?",
      whereArgs: [notesModels.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
