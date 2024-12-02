import 'package:flutter/material.dart';
import 'package:money_track/controller/google_auth_controller.dart';
import 'package:money_track/controller/transactions_controller.dart';
import 'package:money_track/model/transaction_model.dart';
import 'package:money_track/view/components/transaction_list_element.dart';

import '../../controller/general_utility_controller.dart';

class OverViewPage extends StatefulWidget {
  const OverViewPage({super.key});

  @override
  State<OverViewPage> createState() => _OverViewPageState();
}

class _OverViewPageState extends State<OverViewPage> {
  List<TransactionModel> transactions = TransactionsController.transactions;
  double balance = 0;

  Future<void> fetchData() async {
    try {
      await TransactionsController.getTransactions(
          'https://moneytrack-api.albygonella775.workers.dev',
          GoogleAuthController.user?.uid ?? "");
      setState(() {
        transactions = TransactionsController.transactions;
        balance = TransactionsController.balance;
      });
    } catch (e) {
      GeneralUtilityController.showError(
          context, e.toString(), "Errore", "Chiudi");
    }
  }

  List<Widget> showList() {
    List<Widget> list = <Widget>[];

    for (TransactionModel item in transactions) {
      list.add(TransactionListElement(transaction: item));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (!TransactionsController.fetchingData) {
      if (TransactionsController.transactions.isEmpty) {
        fetchData();
      } else {
        setState(() {
          transactions = TransactionsController.transactions;
          balance = TransactionsController.balance;
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: Column(
          children: [
            Text(
              "${balance.toStringAsFixed(2).replaceAll('.', ',')} €",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 5),
              child: Text(
                "Cash flow",
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: ListView(
                    children: transactions.isNotEmpty
                        ? showList()
                        : [const Text("aspetta")]),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () async {
                await GoogleAuthController.logIn();
              },
              child: const Text('Google auth'),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {
                GoogleAuthController.logOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
