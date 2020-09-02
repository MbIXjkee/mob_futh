import 'package:flutter/material.dart';
import 'package:mob_futh/colors.dart';

/// Нижняя панель навигации.
class MainBottomBar extends StatefulWidget {
  final Set<TabBarItem> tabs;

  const MainBottomBar({
    Key key,
    @required this.tabs,
  }) : super(key: key);

  @override
  _MainBottomBarState createState() => _MainBottomBarState();
}

class _MainBottomBarState extends State<MainBottomBar> {
  TabBarItem _selected;

  @override
  void initState() {
    super.initState();

    _selected = widget.tabs.first;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: []..addAll(
              widget.tabs
                  .map((tab) => _buildTab(tab, _selected == tab))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(TabBarItem item, bool isSelected) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = item;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isSelected ? selectedItemColor : primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  item.iconData,
                  color: Colors.white,
                ),
                if (isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      item.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Данные для отображения элемента нижней панели
class TabBarItem {
  final IconData iconData;
  final String text;

  const TabBarItem({this.iconData, this.text});
}