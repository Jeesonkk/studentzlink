import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, required this.text});
  var iconData;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    required this.items,
    required this.centerItemText,
    this.height: 65.0,
    this.iconSize: 24.0,
    required this.backgroundColor,
    required this.color,
    required this.selectedColor,
    required this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText,
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required FABBottomAppBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              onPressed(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImageIcon(AssetImage(item.iconData),
                    color: color, size: widget.iconSize),
                const SizedBox(
                  height: 2,
                ),
                // Icon(item.iconData, color: color, size: widget.iconSize),
                Text(
                  item.text,
                  style: TextStyle(
                      fontFamily: 'Century Gothic',
                      color: color,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
