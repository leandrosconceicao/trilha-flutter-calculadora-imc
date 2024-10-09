import 'package:sqlite3/sqlite3.dart';

import '../models/imc.dart';

class AppRepository {
  
  Database _db;
  AppRepository._() : _db = sqlite3.openInMemory();

  factory AppRepository() {
    final instance = AppRepository._();
    instance._init();
    return instance;
  }

  void _init() {
    _db.execute('''
      create table if not exists registers (
          id INTEGER NOT NULL PRIMARY KEY,
          peso DOUBLE NOT NULL,
          altura DOUBLE NOT NULL
      );
    '''); 
  }

  void dispose() {
    _db.dispose();
  }

  List<Imc> findAll() {
    final registers = _db.select("SELECT * FROM registers");
    final data = registers.rows;
    List<Imc> rawData = [];
    for (dynamic dt in data) {
      rawData.add(Imc(id: dt[0], peso: dt[1], altura: dt[2] ?? 0.0));
    }
    return rawData;
  }

  addData(Imc imc) {
    _db.prepare("insert into registers (peso, altura) VALUES (?, ?)")
      .execute([imc.peso, imc.altura]);
  }

}