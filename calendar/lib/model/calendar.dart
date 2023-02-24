class Calendar {
  final int? id;
  final String title;
  final String inex;
  final int income;
  final int expenditure;
  final String content;
  final String writeday;

  static List<String> calc = [
    'sum(income)',
    'sum(expenditure)',
    'sum(income) - sum(expenditure)'
  ];

  Calendar(
      {this.id,
      required this.title,
      required this.inex,
      required this.income,
      required this.expenditure,
      required this.content,
      required this.writeday});

  Calendar.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        title = res["title"],
        inex = res["inex"],
        income = res["income"],
        expenditure = res["expenditure"],
        content = res["content"],
        writeday = res["writeday"];

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "inex": inex,
      "income": income,
      "expenditure": expenditure,
      "content": content,
      "writeday": writeday
    };
  }

  @override
  String toString() {
    return 'Calendar{id: $id, title: $title, inex: $inex, income: $income, expenditure: $expenditure, content: $content, writeday: $writeday}';
  }
}
