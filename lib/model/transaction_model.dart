import 'package:money_track/model/category_model.dart';

class TransactionModel {
  late double value;
  late TransactionType type;
  late CategoryModel category;
  String description = "";

  TransactionModel(
      double inValue, TransactionType inType, CategoryModel inCategory,
      [String inDescription = ""]) {
    value = inValue;
    type = inType;
    description = inDescription;
    category = inCategory;
  }
}

enum TransactionType { expense, income }
