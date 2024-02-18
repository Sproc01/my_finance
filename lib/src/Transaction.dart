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
      DateTime.parse(jsonData['date']),
      TypeTransaction.values.firstWhere((e) => e.toString() == jsonData['type']),
    );
  }

  static Map<String, dynamic> toMap(Transaction t) => {
    'id': t.id,
    'amount': t.amount,
    'date': t.date.toIso8601String(),
    'type': t.type.toString(),
  };

  static String encode(List<Transaction> t)
  {
    List<Map<String, dynamic>> list = [];
    for (var i = 0; i < t.length; i++) {
      list.add(Transaction.toMap(t[i]));
    }
    return json.encode(list);
  }

  static List<Transaction> decode(String t) 
  {
    List<Transaction> transactions = [];
    List<dynamic> list = json.decode(t);
    for (var i = 0; i < list.length; i++) {
      transactions.add(Transaction.fromJson(list[i]));
    }
    return transactions;
  }

}