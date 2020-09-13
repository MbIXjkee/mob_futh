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
      title: 'Implicit Animation Example',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Implicit Animation Example'),
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
  bool _selected = false;
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = !_selected;
                  });
                },
                child: Center(
                  child: AnimatedContainer(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_selected ? 0.0 : 20.0),
                      color: _selected ? primaryColor : secondaryColor,
                    ),
                    width: _selected ? 200.0 : 100.0,
                    height: _selected ? 100.0 : 200.0,
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: FlutterLogo(size: 75),
                  ),
                ),
              ),
            ),
            MainBottomBar(
              tabs: _tabs,
            )
          ],
        ),
      ),
    );
  }
}
