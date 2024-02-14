// ignore: file_names, constant_identifier_names
enum TypeTransaction {Food, Transport, Shopping, Health, Leisure, Other, Income}

List<String> valueTypeTransaction()
{
  List<String> list = [];
  for (var item in TypeTransaction.values) {
    list.add(item.toString().split('.').last);
  }
  return list;
}