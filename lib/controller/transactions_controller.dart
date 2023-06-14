import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:money_track/model/category_model.dart';
import 'package:money_track/model/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionsController {
  static List<TransactionModel> transactions = <TransactionModel>[];
  static double balance = 0;
  static bool fetchingData = false;

  static dynamic getTransactions(String url, String id) async {
    fetchingData = true;
    transactions.clear();
    balance = 0;

    final response = await http.post(Uri.parse(url + "/getTransactions"),
        body: jsonEncode({"id": id}));

    print(response.body);

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      print(body);

      for (var item in body) {
        transactions.add(
          TransactionModel(
              double.parse(item["value"].toString()),
              item["type"] == 1
                  ? TransactionType.expense
                  : TransactionType.income,
              CategoryModel(
                  item["category"]["name"],
                  IconData(int.parse(item["category"]["iconCode"]),
                      fontFamily: "MaterialIcons")),
              item["description"].toString()),
        );

        if (transactions.last.type == TransactionType.income) {
          balance += transactions.last.value;
        } else {
          balance -= transactions.last.value;
        }
      }
    } else {
      throw Exception('Failed to retreive data');
    }

    fetchingData = false;
  }
}
