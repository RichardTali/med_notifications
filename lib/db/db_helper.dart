import 'package:med_notifications/models/medicamento.dart';
import 'package:sqflite/sqflite.dart'; 
import 'package:path/path.dart'; 

class DBHelper{
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'medicamentos.db'),
      onCreate: (db,version){
        return db.execute('''
          CREATE TABLE medicamentos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            dosis TEXT,
            cantidad TEXT,
            inicio TEXT,
            fin TEXT,
            fechaToma TEXT,
            horaToma TEXT
          )
        ''');
      },
      version: 1,
    );
  }

   static Future<void> insertMedicamento(Medicamento med) async {
    final db = await _openDB();
    await db.insert('medicamentos', med.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Medicamento>> getMedicamentos() async {
    final db = await _openDB();
    final List<Map<String, dynamic>> maps = await db.query('medicamentos');
    return List.generate(maps.length, (i) {
      return Medicamento(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        dosis: maps[i]['dosis'],
        cantidad: maps[i]['cantidad'],
        inicio: maps[i]['inicio'],
        fin: maps[i]['fin'],
        fechaToma: maps[i]['fechaToma'],
        horaToma: maps[i]['horaToma'],
      );
    });
  }
}