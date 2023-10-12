import 'package:database_flutter/model/student.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<Student>> studentListNotifier = ValueNotifier([]);

late Database db;
Future<void> createDataBase() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,register TEXT,phone TEXT,image TEXT,mark )');
    },
  );
  await getData();
}

Future<void> insert({required Student model}) async {
  await db.rawInsert('INSERT INTO student(name,register,phone,image) VALUES(?, ?, ?,?)',
      [model.name, model.register, model.phonenumber,model.image]);
      await getData();
}

Future<void> getData() async {
  final data = await db.rawQuery('SELECT * FROM student');
  studentListNotifier.value.clear();
  for (var map in data) {
    final model = Student.toStudent(map);
    studentListNotifier.value.add(model);
  }
  studentListNotifier.notifyListeners();
}

Future<void>update({required Student model}) async {
  await db.rawUpdate(
    'UPDATE student SET name = ?,register = ?,phone = ? ,image = ? WHERE id =?',
    [model.name,model.register,model.phonenumber,model.image,model.id]);
 await getData();
}

Future<void> delete({required Student model}) async {
  await db.rawDelete('DELETE FROM student WHERE id = ?', [model.id]);
  await getData();
}

