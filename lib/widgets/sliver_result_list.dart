import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/results.dart';
import './result_item.dart';

class SliverResultList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resultsData = Provider.of<Results>(context);
    final results = resultsData.results;

    return results.length > 0
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ResultItem(result: results[index]);
              },
              childCount: results.length,
            ),
          )
        : SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'No results',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize,
                    ),
                  ),
                  Text('Try a synonym or more general words')
                ],
              ),
            ),
          );
  }
}
