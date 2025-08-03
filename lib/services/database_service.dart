import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app/models/student_model.dart';

class DatabaseService {
  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();
  factory DatabaseService() => instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDataBase();
      return _database!;
    }
  }

  Future<Database> _initDataBase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'students_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        department TEXT NOT NULL
      )
    ''');
  }

  // CRUD operations

  Future<int> insertStudentProfile(StudentModel studentModel) async {
    final db = await database;
    int id = await db.insert(
      'students',
      studentModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'students',
      // orderBy: 'createdDate DESC',
    );
    return maps.map((json) => StudentModel.fromMap(json)).toList();
  }

  // Future<int> updateStudent(StudentModel studentModel) async {
  //   final db = await database;
  //   return await db.update(
  //     'students',
  //     studentModel.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [studentModel.id],
  //   );
  // }

  Future<int> deleteStudentProfile(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  // Future<void> deleteAllStudents() async {
  //   final db = await database;
  //   await db.delete('student');
  // }

  Future close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
