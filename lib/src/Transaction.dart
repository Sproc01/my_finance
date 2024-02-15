import "dart:convert";

import "package:my_finance/src/TypeTransaction.dart";

class Transaction
{
  late int id;
  double amount;
  DateTime date;
  static int counter = 0;
  TypeTransaction? type;

  Transaction(this.amount, this.date, this.type)
  {
    counter=counter+1;
    id=counter;
  }

  Transaction.withId(this.id, this.amount, this.date, this.type);


  factory Transaction.fromJson(Map<String, dynamic> jsonData) {
    return Transaction.withId(
      jsonData['id'],
      jsonData['amount'],
      jsonData['date'],
      jsonData['type'],
    );
  }

  static Map<String, dynamic> toMap(Transaction t) => {
    'id': t.id,
    'amount': t.amount,
    'date': t.date,
    'type': t.type,
  };

  static String encode(List<Transaction> t) => json.encode(
    t
      .map<Map<String, dynamic>>((el) => Transaction.toMap(el))
      .toList(),
  );

  static List<Transaction> decode(String t) =>
    (json.decode(t) as List<dynamic>)
        .map<Transaction>((item) => Transaction.fromJson(item))
        .toList();

}