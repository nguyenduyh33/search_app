import 'package:flutter/material.dart';

import './icon_field.dart';
import '../models/result.dart';
import '../screens/result_detail_screen.dart';

class ResultItem extends StatelessWidget {
  final Result result;

  const ResultItem({
    Key key,
    @required this.result,
  }) : super(key: key);

  void _selectResult(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return ResultDetailScreen(result.itemId);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final thumbnail = Container(
      alignment: Alignment.centerLeft,
      width: 92,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          image: DecorationImage(
            image: NetworkImage(result.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    final cardContent = Container(
      margin: const EdgeInsets.fromLTRB(62, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              result.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconField(
                  text: result.price,
                  iconData: Icons.attach_money,
                ),
                IconField(
                  text: '${result?.timeLeftSummary} left',
                  iconData: Icons.timer,
                  color: result.isExpiringWithin24Hours
                      ? Colors.red
                      : Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final card = Card(
      margin: const EdgeInsets.only(left: 46.0),
      child: cardContent,
      color: Theme.of(context).primaryColor,
    );

    return InkWell(
      onTap: () => _selectResult(context),
      child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Stack(
            children: <Widget>[
              card,
              thumbnail,
            ],
          )),
    );
  }
}
