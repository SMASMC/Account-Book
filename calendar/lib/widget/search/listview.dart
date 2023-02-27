import 'package:calendar/repository/database_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchListView extends StatefulWidget {
  final Stream<List> stream;
  const SearchListView({super.key, required this.stream});

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  DatabaseHandler handler = DatabaseHandler();

  List myMap = ['%%', '%%'];
  String searchText = "";

  late Future<List> _future = handler.querySelectDate();

  @override
  void initState() {
    super.initState();

    widget.stream.listen((event) {
      // event[0] = text에서 넘어온 value
      // event[1] = button에서 넘어온 value
      if (event[0] == '0') {
        myMap[0] = '%${event[1]}%';
      } else {
        myMap[1] = '%${event[1]}%';
      }

      setState(() {
        // myMap[0] = text, myMap[1] = button
        _future = handler.textSearchList(myMap[0], myMap[1]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        //데이터는 스냅샷에 들어있다
        if (snapshot.hasData) {
          //데이터 있을경우
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                var f = NumberFormat('###,###,###,###');
                List<String> day = snapshot.data![index].writeday.split('-');

                var date = '${day[0]}년 ${day[1]}월 ${day[2]}일';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 6, top: 10, bottom: 5),
                      child: Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 89,
                      child: Card(
                        margin: const EdgeInsets.all(0), // 카드간의 간격

                        // elevation: 0,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.13,
                                height:
                                    MediaQuery.of(context).size.width * 0.13,
                                child: CircleAvatar(
                                  backgroundColor: snapshot.data![index].inex ==
                                          "수입"
                                      ? const Color.fromARGB(255, 250, 187, 187)
                                      : const Color.fromARGB(
                                          255, 177, 195, 255),
                                  child: Text(
                                    snapshot.data![index].inex == "수입"
                                        ? '수입'
                                        : '지출',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                height: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: Center(
                                  child: Text(
                                    snapshot.data![index].category,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.01,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data![index].expenditure == 0
                                          ? "+ ${f.format(snapshot.data![index].income)}원"
                                          : "- ${f.format(snapshot.data![index].expenditure)}원",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            snapshot.data![index].expenditure ==
                                                    0
                                                ? const Color.fromARGB(
                                                    255, 250, 187, 187)
                                                : const Color.fromARGB(
                                                    255, 177, 195, 255),
                                      ),
                                    ),
                                    if (snapshot.data![index].content !=
                                        "") ...[
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].content,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Card(
                      //   margin: const EdgeInsets.all(6.0), // 카드간의 간격
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(0.0)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(10.0),
                      //             child: SizedBox(
                      //               height: 50,
                      //               width: 50,
                      //               child: CircleAvatar(
                      //                 backgroundColor:
                      //                     snapshot.data![index].inex == "지출"
                      //                         ? const Color.fromARGB(
                      //                             255, 177, 195, 255)
                      //                         : const Color.fromARGB(
                      //                             255, 250, 187, 187),
                      //                 child: Text(
                      //                   snapshot.data![index].inex == "수입"
                      //                       ? "수입"
                      //                       : "지출",
                      //                   style: const TextStyle(
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Row(
                      //             children: [
                      //               Container(
                      //                 width: 28,
                      //                 height: 18,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius:
                      //                         BorderRadius.circular(30),
                      //                     border: Border.all(
                      //                       color: Colors.grey,
                      //                     )),
                      //                 child: Center(
                      //                   child: Text(
                      //                     snapshot.data![index].category,
                      //                     style: const TextStyle(
                      //                       color: Colors.grey,
                      //                       fontSize: 10,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //               const SizedBox(
                      //                 width: 10,
                      //               ),
                      //               Text(
                      //                 snapshot.data![index].title,
                      //                 style: const TextStyle(
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 15,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               snapshot.data![index].income == 0
                      //                   // '${f.format(foodListModel.price)}원',
                      //                   ? "-${f.format(snapshot.data![index].expenditure)}원"
                      //                   : "+${f.format(snapshot.data![index].income)}원",
                      //               style: TextStyle(
                      //                 fontSize: 16,
                      //                 fontWeight: FontWeight.bold,
                      //                 color: snapshot.data![index].income == 0
                      //                     ? const Color.fromARGB(
                      //                         255, 177, 195, 255)
                      //                     : const Color.fromARGB(
                      //                         255, 250, 187, 187),
                      //               ),
                      //             ),
                      //             if (snapshot.data![index].content != "")
                      //               const SizedBox(
                      //                 height: 5,
                      //               ),
                      //             if (snapshot.data![index].content != "")
                      //               Text(
                      //                 snapshot.data![index].content,
                      //                 style: const TextStyle(
                      //                   fontSize: 12,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.grey,
                      //                 ),
                      //               ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ],
                );
              });
        } else {
          //데이터 없으면
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
