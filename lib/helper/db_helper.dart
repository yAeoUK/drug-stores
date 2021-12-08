// import 'package:flutter_ddd/common/parameters.dart';
// import 'package:flutter_ddd/domain/result/value/sql/sql.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// const _dbFile = 'database.db';
// const _dbVersion = DATABASE_VERSION;
//
// class DbHelper {
//   late Database _db;
//   late Transaction? _txn;
//
//   // ignore: missing_return
//   Future<void> execute(SQL sql)async{
//       return _db.execute(sql.value);
//   }
//
//   Future<Database> open() async {
//     final databasesPath = await getDatabasesPath();
//     final path = join(databasesPath, _dbFile);
//
//     _db = await openDatabase(
//       path,
//       version: _dbVersion,
//       onCreate: (Database db, int version) async {
//         await db.execute('''
//           CREATE TABLE notes (
//             id TEXT NOT NULL,
//             title TEXT NOT NULL,
//             body TEXT NOT NULL,
//             category_id TEXT NOT NULL,
//             PRIMARY KEY (id)
//           )
//         ''');
//
//         await db.execute('''
//           CREATE INDEX idx_category_id
//           ON notes(category_id)
//         ''');
//
//         await db.execute('''
//           CREATE TABLE categories (
//             id TEXT NOT NULL,
//             name TEXT NOT NULL,
//             PRIMARY KEY (id)
//           )
//         ''');
//       },
//     );
//
//     return _db;
//   }
//
//   Future<void> dispose() async {
//     await _db.close();
//     // _db = null;
//   }
//
//   Future<T> transaction<T>(Future<T> Function() f) async {
//     return _db.transaction<T>((txn) async {
//       _txn = txn;
//       return await f();
//     }).then((v) {
//       // _txn = null;
//       return v;
//     });
//   }
//
//   Future<List<Map<String, dynamic>>> rawQuery(
//     String sql, [
//     List<dynamic>? arguments,
//   ]) async {
//     return await (_txn ?? _db).rawQuery(sql, arguments);
//   }
//
//   Future<int> rawInsert(
//     String sql, [
//     List<dynamic>? arguments,
//   ]) async {
//     return await (_txn ?? _db).rawInsert(sql, arguments);
//   }
//
//   Future<int> rawDelete(
//     String sql, [
//     List<dynamic>? arguments,
//   ]) async {
//     return await (_txn ?? _db).rawDelete(sql, arguments);
//   }
// }
