import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

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
    /* This thumbnail is just a placeholder for where the actual thumbnail image would go.
    This placeholder is being used as there is currently an issue with accessing the actual images in the sandbox environment. 
    */
    final thumbnail = Container(
      alignment: FractionalOffset.centerLeft,
      child: Icon(
        Icons.photo,
        // Using a random color to represent how the thumbnail serves as a visual differentiator between list items
        color: RandomColor().randomColor(),
        size: 92.0,
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
