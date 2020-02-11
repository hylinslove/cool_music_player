import 'package:cool_music_player/entity/songEntity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbUtil {
  factory DbUtil() => _getInstance();
  static DbUtil get instance => _getInstance();

  static DbUtil _instance;
  Database _db;

  DbUtil._internal() {
    createDb();
  }

  static DbUtil _getInstance() {
    if (_instance == null) {
      _instance = new DbUtil._internal();
    }
    return _instance;
  }

  void createDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cool_music.db');

    _db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db,int version)async {
          await db.execute("CREATE TABLE IF NOT EXISTS music("
              "id text primary key,name text, arName text, alName text, picUrl text)");
        }
    );

    if(_db == null) {
      print("db = null");
    } else {
      print("db != null");
    }
  }

  void insert(String musicId, String name, String arName, String alName, String picUrl) async {
    await _db.transaction((txn) async {
      int id = await txn.rawInsert(
          "INSERT INTO music(id,name,arName,alName,picUrl) VALUES (?,?,?,?,?)",
          [musicId, name, arName, alName, picUrl]
      );
      print("insert : $id");
    });
  }

  void update(String musicId, String name, String arName, String alName, String picUrl) async {
    int id = await _db.rawUpdate(
        "UPDATE music SET name = ?, arName = ?, alName = ?, picUrl = ? WHERE id = ?",
        [name, arName, alName, picUrl, musicId]
    );
    print("update : $id");
  }

  Future<List<SongEntity>> query() async {
    List<Map<String ,dynamic>> queryList =  await _db.rawQuery("SELECT * FROM music");
    List<SongEntity> songs = List();
    queryList.forEach((item) {
      SongEntity songEntity = SongEntity(
        id: item["id"],
        name: item["name"],
        arName: item["arName"],
        alName: item["alName"],
        picUrl: item["picUrl"],

      );
      songs.add(songEntity);

    });
    return songs;
  }

  void delete(String musicId) async {
    int id = await _db.rawDelete('''DELETE FROM music WHERE name = "$musicId"''');
    print("delete : $id");
  }
}