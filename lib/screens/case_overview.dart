import 'package:flutter/material.dart';
import 'live_feed.dart';
import 'vault_screen.dart';
import 'evidence_map.dart';

class CaseOverviewScreen extends StatefulWidget {
  const CaseOverviewScreen({super.key});

  @override
  State<CaseOverviewScreen> createState() => _CaseOverviewScreenState();
}

class _CaseOverviewScreenState extends State<CaseOverviewScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    LiveFeedWidget(),
    EvidenceMapWidget(),
    VaultScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Case — ACME Investigation')),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Vault'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
