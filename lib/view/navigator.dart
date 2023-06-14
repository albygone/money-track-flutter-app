import 'package:flutter/material.dart';
import 'package:money_track/view/pages/other.dart';
import 'package:money_track/view/pages/overview.dart';
import 'package:money_track/view/pages/wallets.dart';

class Navigator extends StatefulWidget {
  const Navigator({Key? key}) : super(key: key);

  @override
  State<Navigator> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigator> {
  int _currentIndex = 0;

  List<Page> pages = [
    Page("Overview", const OverViewPage()),
    Page("Wallets", const WalletsPage()),
    Page("Other", const OthersPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: pages[_currentIndex].page,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.space_dashboard_rounded),
            icon: Icon(Icons.space_dashboard_rounded),
            label: "Overview",
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.wallet_rounded),
            icon: Icon(Icons.wallet_rounded),
            label: 'Wallets',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.more_horiz_rounded),
            icon: Icon(Icons.more_horiz_rounded),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class Page {
  String name = "";
  Widget? page;

  Page(String iname, Widget ipage) {
    name = iname;
    page = ipage;
  }
}
