import 'package:data_sqflite/model/counter.dart';
import 'package:sqflite/sqflite.dart' as SQL;
import 'package:path/path.dart';

class DatabaseMy {
  SQL.Database ? db;
 
   Future <void> openDatabase() async{
    const dbName='data.test';
    final dbPath=await  SQL.getDatabasesPath();
    db=await SQL.openDatabase(join(dbPath,dbName),version: 1,onCreate:_onCreate);



  }
  Future <void> _onCreate(SQL.Database  db ,int ver) async{
    
      await db.execute('CREATE TABLE T_Test (id  INTEGER PRIMARY KEY ,counter INTEGER)');
      print("Create");
  }
  Future <void> insert(Counter counter) async{
   
     await db!.rawInsert('INSERT INTO T_test(counter) VALUES (${counter.counter})');
     print("Insrted");

  }
  Future <List<Counter>>  getAll()async{
    List <Map> result=await db!.rawQuery('SELECT * FROM T_test');
    List<Counter> res=[];
    result.forEach((element) { 
      res.add(new Counter(element['id'], element['counter']));
     
    });
 
    return res;
    
  }
  
}