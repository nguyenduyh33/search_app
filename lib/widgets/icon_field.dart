import 'package:flutter/material.dart';

class IconField extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool vertical;
  final Color color;

  const IconField({
    @required this.iconData,
    @required this.text,
    this.color,
    this.vertical = false,
  });

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).accentColor;
    final _textWidget = Text(
      text,
      style: TextStyle(color: _color),
    );
    final _iconWidget = Icon(iconData, color: _color);

    buildRow() {
      return Row(
        children: <Widget>[
          _iconWidget,
          Container(
            width: 2,
          ),
          FittedBox(child: _textWidget),
        ],
      );
    }

    buildColumn() {
      return Column(
        children: <Widget>[
          _iconWidget,
          FittedBox(
            child: _textWidget,
          )
        ],
      );
    }

    return vertical ? buildColumn() : buildRow();
  }
}
