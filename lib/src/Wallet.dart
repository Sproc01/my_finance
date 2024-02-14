import 'package:flutter/material.dart';
import 'Transaction.dart';

class Wallet extends ChangeNotifier
{
  List<Transaction> transactions = [];
  double get balance{
    double balance = 0;
    for (var transaction in transactions) {
      balance += transaction.amount;
    }
    return balance;
  }

  void addTransaction(Transaction transaction){
    transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction){
    transactions.remove(transaction);
    notifyListeners();
  }

  @override
  String toString() {
    String s="";
    for (var transaction in transactions) {
      s+="$transaction\n";
    }
    return s;
  }
}