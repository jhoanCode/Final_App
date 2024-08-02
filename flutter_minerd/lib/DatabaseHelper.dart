import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'visitas.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE visitas (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cedula TEXT,
            codigoCentro TEXT,
            motivo TEXT,
            comentario TEXT,
            imagePath TEXT,
            latitud REAL,
            longitud REAL,
            fecha TEXT,
            hora TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertVisita(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert('visitas', row, conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
