import 'package:calendar/model/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../repository/database_handler.dart';

class Clist extends StatefulWidget {
  final Stream<String> stream;

  const Clist({super.key, required this.stream});

  @override
  State<Clist> createState() => _ClistState();
}

class _ClistState extends State<Clist> {
  // late DatabaseHandler handler; // DatabaseHandler 클라스로 만들어준 클라스
  var f = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');
  late List<Calendar> list;

  @override
  void initState() {
    super.initState();
    list = [];
    myList(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    widget.stream.listen((event) {
      // 날짜를 가지고 가서 list 불러오는 함수 불러오기
      myList(event);
    });
  }

  // -----------------------------------------------
  // 날짜 변할 때 마다 새로운 리스트 가져오는 함수
  myList(String day) {
    DatabaseHandler handler = DatabaseHandler();
    handler.queryYear(day).then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return list[index].content != ""
              ? Card(
                  margin: const EdgeInsets.all(0), // 카드간의 간격
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundColor: list[index].inex == "수입"
                                    ? const Color.fromARGB(255, 250, 187, 187)
                                    : const Color.fromARGB(255, 177, 195, 255),
                                child: Text(
                                  list[index].inex == "수입" ? '수입' : '지출',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              list[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              list[index].expenditure == 0
                                  ? "+ ${f.format(list[index].income)}"
                                  : "- ${f.format(list[index].expenditure)}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: list[index].expenditure == 0
                                    ? const Color.fromARGB(255, 250, 187, 187)
                                    : const Color.fromARGB(255, 177, 195, 255),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              list[index].content,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Card(
                  margin: const EdgeInsets.all(0), // 카드간의 간격
                  elevation: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundColor: list[index].inex == "수입"
                                    ? const Color.fromARGB(255, 250, 187, 187)
                                    : const Color.fromARGB(255, 177, 195, 255),
                                child: Text(
                                  list[index].inex == "수입" ? '수입' : '지출',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              list[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          list[index].expenditure == 0
                              ? "+ ${f.format(list[index].income)}"
                              : "- ${f.format(list[index].expenditure)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: list[index].expenditure == 0
                                ? const Color.fromARGB(255, 250, 187, 187)
                                : const Color.fromARGB(255, 177, 195, 255),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        });
  }
}
