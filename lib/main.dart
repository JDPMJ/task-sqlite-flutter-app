import 'package:app4/pages/list_pages.dart';
import 'package:app4/pages/save_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute:
      ListPages.ROUTE,
      routes: {
        ListPages.ROUTE: (_) => ListPages(),
        SavePage.ROUTE: (_) => SavePage()
      }
    );
  }
}
