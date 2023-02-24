import 'package:calendar/model/calendar_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/calendar.dart';

// Table 생성
class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "calendar.db"),
      onCreate: (database, version) async {
        await database.execute(
            "create table calendar(id integer primary key autoincrement, title text, inex text, income integer, expenditure integer, content text, writeday text)");
      },
      version: 1,
    );
  }

  Future<int> insertCal(Calendar calendar) async {
    //파일쓰는거라 async 사용
    int result = 0;
    final Database db = await initializeDB(); //그런애있냐 하고 이니셜라이징하고
    result = await db.rawInsert(
        "insert into calendar (title, inex, income, expenditure, content, writeday) values(?,?,?,?,?,?)",
        [
          calendar.title,
          calendar.inex,
          calendar.income,
          calendar.expenditure,
          calendar.content,
          calendar.writeday
        ]);
    return result;
  }

// 날짜 오름차순
  Future<List<Calendar>> queryYear(String? selectedDate) async {
    final Database db = await initializeDB();

    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select * from calendar where writeday == ?",
        [selectedDate]); //셀렉트 때문에 ap<String, Object?> toMap()만듬
    return queryResult.map((e) => Calendar.fromMap(e)).toList();
  }

  // 수입 지출 데이터 내림차순 정렬 후
  // 월별 페이지에 출력해주기
  Future<List<Calendar>> querySelectDate() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
        "select * from calendar order by writeday desc"); //셀렉트 때문에 ap<String, Object?> toMap()만듬
    return queryResult.map((e) => Calendar.fromMap(e)).toList();
  }

  // 수입, 지출, 합계의 합계
  queryIncom() async {
    final Database db = await initializeDB();

    for (int i = 0; i < 3; i++) {
      final List<Map<String, Object?>> queryResult$i = await db.rawQuery(
          "select ${Calendar.calc[i]} as sum from calendar"); //셀렉트 때문에 ap<String, Object?> toMap()만듬

      Object test = queryResult$i[0]['sum'] ?? 0;
      int result = int.parse(test.toString());
      CalendartVM.ls[i] = result;
    }
  }
}
