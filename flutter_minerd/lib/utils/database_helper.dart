import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/incidencia.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('minerd_tecnico.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidencias(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT,
        centroEducativo TEXT,
        regional TEXT,
        distrito TEXT,
        fecha TEXT,
        descripcion TEXT,
        fotoPath TEXT,
        audioPath TEXT
      )
    ''');
  }

  Future<int> insertIncidencia(Incidencia incidencia) async {
    final db = await instance.database;
    return await db.insert('incidencias', incidencia.toMap());
  }
Future<List<Incidencia>> getIncidencias() async {
    final db = await instance.database;
    final incidencias = await db.query('incidencias', orderBy: 'fecha DESC');
    return incidencias.map((json) => Incidencia.fromMap(json)).toList();
  }

  Future<Incidencia?> getIncidencia(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'incidencias',
      columns: ['id', 'titulo', 'centroEducativo', 'regional', 'distrito', 'fecha', 'descripcion', 'fotoPath', 'audioPath'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Incidencia.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateIncidencia(Incidencia incidencia) async {
    final db = await instance.database;
    return db.update(
      'incidencias',
      incidencia.toMap(),
      where: 'id = ?',
      whereArgs: [incidencia.id],
    );
  }

  Future<int> deleteIncidencia(int id) async {
    final db = await instance.database;
    return await db.delete(
      'incidencias',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}