import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobius Reuse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Reuse Demo Page'),
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
  bool _isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isFirst ? first() : second(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Switch"),
        onPressed: () {
          setState(() {
            _isFirst = !_isFirst;
          });
        },
      ),
    );
  }

  Widget first() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "test",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.error,
          ),
        ],
      );

  Widget second() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "one more test",
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          Icon(
            Icons.add,
          ),
        ],
      );
}
