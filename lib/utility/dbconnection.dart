import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'dictionarymodel.dart';

class DBprovider{
  DBprovider._();

  static final DBprovider db =DBprovider._();
  static Database _database;

  Future<Database> get database async{
    if(_database != null){
      return _database;
    }else{
      _database=await initDB();
      return _database;
    }
  }

  initDB () async{
    return await openDatabase(
      join(await getDatabasesPath(), 'dictionary'),
      onCreate: (db, version) async{
        await db.execute('''
        CREATE TABLE allword (
          id integer primary key autoincrement,
          Amharic TEXT,
          Kistanigna TEXT,
          English TEXT,
          Definition TEXT,
          Favorite TEXT,
          check TEXT,
          )
        ''');

        await db.execute('''
        CREATE TABLE favorite (
          id integer primary key autoincrement,
          Amharic TEXT,
          Kistanigna TEXT,
          English TEXT,
          Definition TEXT,
          Favorite TEXT,check TEXT)
        ''');

      },
        version: 1
    );
  }

  newdictionary(Dictionary dictionary) async{
    final db = await database;

    var res = await db.rawInsert(''' 
      INSERT INTO allword(
        Amharic,Kistanigna,English,Definition,Favorite
      )VALUES (?,?,?,?,?)
      
    ''' , [dictionary.Amharic, dictionary.Kistanigna,dictionary.English,dictionary.Definition,dictionary.Favorite]);
    return res;
  }
  check(Dictionary dictionary) async{
    final db = await database;

    var res = await db.rawInsert(''' 
      INSERT INTO allword(
       check
      )VALUES (?)
      
    ''' , [dictionary.check]);
    return res;
  }
  newsfavorite(Dictionary dictionary) async{

    final db = await database;
    var res = await db.rawInsert(''' 
      INSERT INTO favorite(
         Amharic,Kistanigna,English,Definition,Favorite
      )VALUES (?,?,?,?,?)
    ''' , [dictionary.Amharic, dictionary.Kistanigna,dictionary.English,dictionary.Definition,dictionary.Favorite]);
    return res;
  }



  Future<dynamic> getdictionary() async{

    final db = await database;
    var res = await db.query('allword');
    if(res.length == 0){
      print("hi");
      return null;
    }else{
      List<Map<String, dynamic>> resmap=res;
      print(resmap);
      return resmap;
    }
  }

  Future<dynamic> getfavorite() async{

    final db = await database;
    var res = await db.query('favorite');
    if(res.length == 0){
      return null;
    }else{
      List<Map<String, dynamic>> resmap=res;
      print(resmap);
      return resmap;
    }
  }
  Future<dynamic> getcheck() async{

    final db = await database;
    var res = await db.query('check');
    if(res.length == 0){
      return null;
    }else{
      List<Map<String, dynamic>> resmap=res;
      print(resmap);
      return resmap;
    }
  }
  Future<void> deletefavorite(String id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'favorite',
      // Use a `where` clause to delete a specific dog.
      where: "Kistanigna = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
  Future<void> deletecheck(String id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the Database.
    await db.delete(
      'check',
      // Use a `where` clause to delete a specific dog.
      where: "check = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }


  Future<void> updatefev(String id,int fev) async{ // returns the number of rows updated

    final db = await database;

    await db.rawUpdate('UPDATE allword SET Favorite = ? WHERE Kistanigna = ?', [fev, id]);

  }




  Future<void> updatecheck(String id,int fev) async{ // returns the number of rows updated

    final db = await database;

    await db.rawUpdate('UPDATE allword SET check = ? WHERE check = ?', [fev, id]);

  }
}

