import 'package:flutter/material.dart';
import 'package:mob_futh/colors.dart';
import 'package:mob_futh/main_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomBar Example',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'BottomBar Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<TabBarItem> _tabs;

  @override
  void initState() {
    super.initState();

    _tabs = Set<TabBarItem>();
    _tabs.add(TabBarItem(iconData: Icons.error, text: 'Первый'));
    _tabs.add(TabBarItem(iconData: Icons.group, text: 'Второй'));
    _tabs.add(TabBarItem(iconData: Icons.home, text: 'Третий'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MainBottomBar(
              tabs: _tabs,
            )
          ],
        ),
      ),
    );
  }
}
