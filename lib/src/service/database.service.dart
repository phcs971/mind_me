import 'package:mind_me/src/models/note.model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils.dart';

class DatabaseService {
  static const _databaseName = 'mind.me.notes.db';
  static const _databaseVersion = 3;

  DatabaseService._pC();
  static final DatabaseService instance = DatabaseService._pC();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String appPath = (await getApplicationDocumentsDirectory()).path;
    String path = join(appPath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    log.i("<Database> Updating from $oldVersion to $newVersion");
    if (oldVersion == 1) {
      await db.execute("""
      ALTER TABLE ${NoteDatabase.table}
      ADD ${NoteDatabase.columnNotificationsIds} TEXT; 
    """);
    }
    if (oldVersion <= 2) {
      await db.execute("""
      ALTER TABLE ${NoteDatabase.table}
      ADD ${NoteDatabase.columnIndex} INTEGER; 
    """);
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE ${NoteDatabase.table} (
        ${NoteDatabase.columnId} TEXT PRIMARY KEY NOT NULL,
        ${NoteDatabase.columnIndex} INTEGER,
        ${NoteDatabase.columnTitle} TEXT NOT NULL,
        ${NoteDatabase.columnColor} INTEGER NOT NULL,
        ${NoteDatabase.columnLock} INTEGER NOT NULL,
        ${NoteDatabase.columnLocalAuth} INTEGER NOT NULL,
        ${NoteDatabase.columnPassCode} TEXT,
        ${NoteDatabase.columnNotify} INTEGER NOT NULL,
        ${NoteDatabase.columnRandomNotification} INTEGER NOT NULL,
        ${NoteDatabase.columnTime} TEXT NOT NULL,
        ${NoteDatabase.columnDates} TEXT NOT NULL,
        ${NoteDatabase.columnNotificationsIds} TEXT
      )
    """);
  }

  Future<int> create(NoteModel note) async {
    Database db = await database;
    return await db.insert(NoteDatabase.table, note.toJson());
  }

  Future<List<NoteModel>> read() async {
    Database db = await database;
    List<NoteModel> notes = [];

    List<Map<String, dynamic>> data = await db.query(NoteDatabase.table);
    for (var json in data) notes.add(NoteModel.fromJson(json));

    return notes;
  }

  Future<int> update(NoteModel note) async {
    Database db = await database;
    return await db.update(
      NoteDatabase.table,
      note.toJson(),
      where: '${NoteDatabase.columnId} = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> updateAll(List<NoteModel> notes) async {
    for (var note in notes) await update(note);
  }

  Future<int> delete(String id) async {
    Database db = await database;
    return await db.delete(
      NoteDatabase.table,
      where: '${NoteDatabase.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    Database db = await database;
    return await db.delete(NoteDatabase.table);
  }
}
