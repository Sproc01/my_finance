import 'package:flutter/material.dart';
import 'package:my_finance/src/TypeTransaction.dart';
import 'Transaction.dart';

class Wallet extends ChangeNotifier
{
  List<Transaction> transactions=[];
  double get balance{
    double balance = 0;
    for (var transaction in transactions) {
      balance += transaction.amount;
    }
    return balance;
  }

  Wallet();

  Wallet.fromString(String s){
    if (s=="") return;
    List<String> lines = s.split("\n");
    for (var line in lines) {
      if(line.isNotEmpty)
      {
        transactions.add(Transaction.fromString(line));
      }
    }
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

  double percentageOut(TypeTransaction type){
    double total = 0;
    double totalType = 0;
    for (var transaction in transactions) {
      if(transaction.type != TypeTransaction.Income){
        total += transaction.amount;
      }
      if (transaction.type == type) {
        totalType += transaction.amount;
      }
    }
    return -1*totalType/total*100;
  }
}