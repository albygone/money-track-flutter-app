import 'package:flutter/material.dart';
import 'package:money_track/model/transaction_model.dart';

class TransactionListElement extends StatefulWidget {
  late TransactionModel displayedTransaction;

  TransactionListElement({super.key, required TransactionModel transaction}) {
    displayedTransaction = transaction;
  }

  @override
  State<TransactionListElement> createState() =>
      _TransactionListElementState(displayedTransaction);
}

class _TransactionListElementState extends State<TransactionListElement> {
  late TransactionModel displayedTransaction;
  _TransactionListElementState(TransactionModel inDisplayedTransaction) {
    displayedTransaction = inDisplayedTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 15, top: 6, bottom: 6),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: displayedTransaction.type == TransactionType.income
                          ? Colors.green
                          : Colors.red[400]),
                  padding: const EdgeInsets.all(8),
                  child: Icon(
                    displayedTransaction.category.icon,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                        displayedTransaction.category.name,
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black45,
                              size: 14,
                            ),
                          ),
                          Text(
                            displayedTransaction.description,
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 23),
                    child: Text(
                      "${displayedTransaction.type == TransactionType.income ? '+' : '-'}${displayedTransaction.value}",
                      style: TextStyle(
                          color: displayedTransaction.type ==
                                  TransactionType.income
                              ? Colors.green
                              : Colors.red[400],
                          fontSize: 15),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            )),
        const Divider(
          indent: 15,
          endIndent: 15,
          color: Colors.black38,
        ),
      ],
    );
  }
}
