import 'package:flutter/material.dart';

import '../models/result.dart';
import '../screens/result_detail_screen.dart';

class ResultItem extends StatelessWidget {
  final Result result;

  const ResultItem({
    Key key,
    @required this.result,
  }) : super(key: key);

  void selectResult(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return ResultDetailScreen(result.id, result.title);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = new Container(
      alignment: FractionalOffset.centerLeft,
      child: Icon(
        Icons.photo,
        color: Theme.of(context).accentColor,
        size: 92.0,
      ),
    );

    final baseTextStyle = const TextStyle(fontFamily: 'Poppins');
    final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      // fontSize: 12.0,
      fontWeight: FontWeight.w400,
    );
    final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    Widget _resultValue({String value, IconData icon}) {
      return new Row(children: <Widget>[
        Icon(icon, size: 14, color: Theme.of(context).primaryColorLight),
        new Container(width: 8.0),
        new Text(value, style: regularTextStyle),
      ]);
    }

    final cardContent = new Container(
      margin: new EdgeInsets.fromLTRB(64.0, 16.0, 16.0, 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              result.title,
              style: headerTextStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              // softWrap: false,
            ),
          ),
          Expanded(
            flex: 1,
            child: new Row(
              children: <Widget>[
                new Expanded(
                    child: _resultValue(
                        value: result.price, icon: Icons.attach_money)),
                new Expanded(
                    child: _resultValue(value: '10 days', icon: Icons.timer))
              ],
            ),
          ),
        ],
      ),
    );

    final card = Card(
      margin: new EdgeInsets.only(left: 46.0),
      child: cardContent,
      // color: Color(0xFF333366),
      color: Theme.of(context).primaryColorDark,
    );

    return InkWell(
      onTap: () => selectResult(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: new Container(
          height: 120.0,
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              card,
              thumbnail,
            ],
          )),
    );
  }
}
