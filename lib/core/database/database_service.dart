import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'growthx.db');
    return openDatabase(
      path,
      version: 6,
      onCreate: (db, version) async {
        await _createHabitsTable(db);
        await _createStudySessionsTable(db);
        await _createWorkoutsTable(db);
        await _createWeightEntriesTable(db);
        await _createWaterEntriesTable(db);
        await _createJournalEntriesTable(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) await _createStudySessionsTable(db);
        if (oldVersion < 3) await _createWorkoutsTable(db);
        if (oldVersion < 4) await _createWeightEntriesTable(db);
        if (oldVersion < 5) await _createWaterEntriesTable(db);
        if (oldVersion < 6) await _createJournalEntriesTable(db);
      },
    );
  }

  Future<void> _createHabitsTable(Database db) async {
    await db.execute('''
      CREATE TABLE habits(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        isDone INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future<void> _createStudySessionsTable(Database db) async {
    await db.execute('''
      CREATE TABLE study_sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        subject TEXT NOT NULL,
        durationMinutes INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createWorkoutsTable(Database db) async {
    await db.execute('''
      CREATE TABLE workouts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise TEXT NOT NULL,
        sets INTEGER NOT NULL,
        reps INTEGER NOT NULL,
        caloriesBurned INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createWeightEntriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE weight_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weightKg REAL NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createWaterEntriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE water_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amountMl INTEGER NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createJournalEntriesTable(Database db) async {
    await db.execute('''
      CREATE TABLE journal_entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        mood TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }
}